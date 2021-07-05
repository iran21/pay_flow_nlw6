import 'package:flutter/material.dart';
import 'package:payflow/shared/theme/app_colors.dart';
import 'package:payflow/shared/theme/app_textstyle.dart';
import 'package:payflow/shared/widgets/label_button/label_buton_widget.dart';
import 'package:payflow/shared/widgets/set_buttons/set_buttons_widget.dart';

class BottomSheetWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String firstLabel;
  final String secondLabel;
  final VoidCallback firstPressed;
  final VoidCallback secondPressed;

  const BottomSheetWidget({
    Key? key,
    required this.firstLabel,
    required this.secondLabel,
    required this.firstPressed,
    required this.secondPressed,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: RotatedBox(
        quarterTurns: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(10),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.buttonBoldHeading,
                ),
              ),
              subtitle: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: AppTextStyle.buttonHeading,
              ),
            ),
            SetButtons(
              enablePrimary: true,
              firstLabel: firstLabel,
              firstPressed: firstPressed,
              secondLabel: secondLabel,
              secondPressed: secondPressed,
            )
          ],
        ),
      ),
    );
  }
}
