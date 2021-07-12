import 'package:camera/camera.dart';

///Gerenciador de estados do barcode
class BarcodeScannerStatus {
  final bool isCameraAvailable;
  final String error;
  final String barcode;

  final bool stopScanner;

  BarcodeScannerStatus( {
    this.stopScanner = false,
    this.isCameraAvailable = false,
    this.error = '',
    this.barcode = '',
  });

/*NOTE métodos factory para retornar objetos só com os parâmetros necessários, 
neste caso eu retiro a responsabilidade do meu construtor default de criar todas as variáveis*/

  ///Recebe um objeto do tipo [CameraController] e retorna um objeto do tipo [BarcodeScannerStatus]
  factory BarcodeScannerStatus.available() =>
      BarcodeScannerStatus(isCameraAvailable: true, stopScanner: false);

  factory BarcodeScannerStatus.error(String errorMessage) =>
      BarcodeScannerStatus(error: errorMessage, stopScanner: true);

  factory BarcodeScannerStatus.barcode(String barcode) => BarcodeScannerStatus(barcode: barcode, stopScanner: true);

  bool get showCamera => isCameraAvailable && error.isEmpty;

  bool get hasError => error.isNotEmpty;

  bool get hasBarcode => barcode.isNotEmpty;
}
