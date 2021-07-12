import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payflow/modules/barcode/barcode_scanner_status.dart';

class BarcodeScannerController {
  final statusNotifier = ValueNotifier<BarcodeScannerStatus>(BarcodeScannerStatus());
  BarcodeScannerStatus get barcodeStatus => statusNotifier.value;
  set barcodeStatus(BarcodeScannerStatus barcodeStatus) => statusNotifier.value = barcodeStatus;
  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

  CameraController? cameraController;

  InputImage? imagePicker;

  ///1. Verifica se as câmeras estão disponíveis
  ///2. Seleciona a câmera traseira
  ///3. Cria um objeto cameraController que recebe: a camera traseira, a resolução e desativa o audio
  ///4. Passa o objeto cameraController para o factory BarcodeStatus.available e recebe um status
  Future<void> getAvailableCameras() async {
    try {
      final response = await availableCameras();
      final camera =
          response.firstWhere((element) => element.lensDirection == CameraLensDirection.back);
      cameraController = CameraController(camera, ResolutionPreset.max, enableAudio: false);
      await cameraController!.initialize();
      scanWithCamera();
      listenCamera();
    } catch (e) {
      barcodeStatus = BarcodeScannerStatus.error(e.toString());
      print(e);
    }
  }

  ///Caixa preta que configura a câmera para o MLKit
  void listenCamera() {
    if (cameraController!.value.isStreamingImages == false) {
      cameraController!.startImageStream(
        (cameraImage) async {
          if (barcodeStatus.stopScanner == false) {
            try {
              final WriteBuffer allBytes = WriteBuffer();

              for (Plane plane in cameraImage.planes) {
                allBytes.putUint8List(plane.bytes);
              }

              final Size imageSize =
                  Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());

              final InputImageRotation imageRotation = InputImageRotation.Rotation_0deg;

              final InputImageFormat imageFormat =
                  InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
                      InputImageFormat.NV21;

              final planeData = cameraImage.planes
                  .map(
                    (Plane plane) => InputImagePlaneMetadata(
                      bytesPerRow: plane.bytesPerRow,
                      height: plane.height,
                      width: plane.width,
                    ),
                  )
                  .toList();

              final inputImageData = InputImageData(
                  size: imageSize,
                  imageRotation: imageRotation,
                  inputImageFormat: imageFormat,
                  planeData: planeData);

              final bytes = allBytes.done().buffer.asUint8List();

              final inputImageCamera =
                  InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

              scannerBarcode(inputImageCamera);
            } catch (e) {
              print(e);
            }
          }
        },
      );
    }
  }

  Future<void> scannerBarcode(InputImage inputImageCamera) async {
    try {
      final barcodes = await barcodeScanner.processImage(inputImageCamera);
      String? barcode;
      for (Barcode item in barcodes) {
        barcode = item.value.displayValue;
      }
      if (barcode != null && barcodeStatus.barcode.isEmpty) {
        barcodeStatus = BarcodeScannerStatus.barcode(barcode);
        cameraController!.dispose();
        await barcodeScanner.close();
      }
      return;
    } catch (e) {
      print('ERRO DE LEITURA $e');
    }
  }

  void scanWithCamera() {
    barcodeStatus = BarcodeScannerStatus.available();

    Future.delayed(Duration(seconds: 20)).then((value) {
      if (barcodeStatus.hasBarcode == false)
        barcodeStatus = BarcodeScannerStatus.error('Timeout de leitura de boleto');
    });
  }

  void scanWithImagePicker() async {
    final response = await ImagePicker().getImage(source: ImageSource.gallery);
    final inputImage = InputImage.fromFilePath(response!.path);
    scannerBarcode(inputImage);
  }

  void dispose() {
    statusNotifier.dispose();
    barcodeScanner.close();
    if (barcodeStatus.showCamera) {
      cameraController!.dispose();
    }
  }
}
