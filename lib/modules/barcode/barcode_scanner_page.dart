import 'package:flutter/material.dart';
import 'package:payflow/shared/theme/app_colors.dart';
import 'package:payflow/shared/theme/app_textstyle.dart';
import 'package:payflow/shared/widgets/divider/divider_widget.dart';
import 'package:payflow/shared/widgets/label_button/label_buton_widget.dart';
import 'package:payflow/shared/widgets/set_buttons/set_buttons_widget.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RotatedBox(
        quarterTurns: 1,
        child: Scaffold(
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
                child: Container(color: Colors.grey),
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
              secondPressed: () {}),
        ),
      ),
    );
  }
}
