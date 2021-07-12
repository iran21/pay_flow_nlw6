import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode/barcode_scanner_controller.dart';
import 'package:payflow/modules/barcode/barcode_scanner_status.dart';
import 'package:payflow/shared/theme/app_colors.dart';
import 'package:payflow/shared/theme/app_textstyle.dart';
import 'package:payflow/shared/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:payflow/shared/widgets/divider/divider_widget.dart';
import 'package:payflow/shared/widgets/label_button/label_buton_widget.dart';
import 'package:payflow/shared/widgets/set_buttons/set_buttons_widget.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final controller = BarcodeScannerController();

  @override
  void initState() {
    super.initState();
    controller.getAvailableCameras();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, barcodeStatus, __) {
              if (barcodeStatus.showCamera) {
                return Container(
                  child: controller.cameraController!.buildPreview(),
                );
              } else {
                return Container(
                );
              }
            },
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text(
                  'Escaneie o código de barras do boleto',
                  style: AppTextStyle.buttonBackground,
                ),
                backgroundColor: Colors.black,
                leading: BackButton(
                  color: AppColors.background,
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Container(color: Colors.black),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(color: Colors.transparent),
                  ),
                  Expanded(
                    child: Container(color: Colors.black),
                  ),
                ],
              ),
              bottomNavigationBar: SetButtons(
                firstLabel: 'Inserir código do boleto',
                secondLabel: 'Inserir boleto da galeria',
                firstPressed: () {},
                secondPressed: () {},
              ),
            ),
          ),
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, barcodeStatus, __) {
              if (barcodeStatus.hasError) {
                return BottomSheetWidget(
                  firstLabel: 'Escanear Novamente',
                  firstPressed: (){
                    controller.scanWithCamera();
                  },
                  secondLabel: 'Digitar Código',
                  secondPressed: () {},
                  title: 'Não foi possível escanear o código do seu boleto',
                  subtitle: 'Tente novamente ou digite o código do seu boleto',
                );
              } else {
                return Container(
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
