import 'package:flutter/material.dart';
import 'package:payflow/shared/theme/app_colors.dart';
import 'package:payflow/shared/theme/app_textstyle.dart';
import 'package:payflow/shared/widgets/divider/divider_widget.dart';
import 'package:payflow/shared/widgets/label_button/label_buton_widget.dart';

class SetButtons extends StatelessWidget {
  final String firstLabel;
  final String secondLabel;
  final VoidCallback firstPressed;
  final VoidCallback secondPressed;
  final bool enablePrimary;

  const SetButtons({
    Key? key,
    required this.firstLabel,
    required this.secondLabel,
    required this.firstPressed,
    required this.secondPressed,
    this.enablePrimary = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.shape,
      child: Row(
        children: [
          Expanded(
            child: LabelButton(
              label: firstLabel,
              onPressed: firstPressed,
              style: enablePrimary ? AppTextStyle.buttonPrimary : null,
            ),
          ),
          MyDivider(color: AppColors.stroke),
          Expanded(
            child: LabelButton(
              label: secondLabel,
              onPressed: secondPressed,
            ),
          ),
        ],
      ),
    );
  }
}
