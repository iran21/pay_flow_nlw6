import 'package:flutter/material.dart';
import 'package:payflow/shared/theme/app_colors.dart';
import 'package:payflow/shared/widgets/divider/divider_widget.dart';
import 'package:payflow/shared/widgets/label_button/label_buton_widget.dart';

class SetButtons extends StatelessWidget {
  final String firstLabel;
  final String secondLabel;
  final VoidCallback firstPressed;
  final VoidCallback secondPressed;

  const SetButtons({
    Key? key,
    required this.firstLabel,
    required this.secondLabel,
    required this.firstPressed,
    required this.secondPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LabelButton(
            label: firstLabel,
            onPressed: firstPressed,
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
    );
  }
}
