import 'package:flutter/material.dart';
import 'package:payflow/shared/theme/app_colors.dart';
import 'package:payflow/shared/theme/app_images.dart';
import 'package:payflow/shared/theme/app_textstyle.dart';
import 'package:payflow/shared/widgets/divider/divider_widget.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  const SocialLoginButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.shape,
            borderRadius: BorderRadius.circular(5),
            border: Border.fromBorderSide(
              BorderSide(color: AppColors.stroke),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(AppImages.google),
              ),
              MyDivider(color: AppColors.stroke),
              Expanded(
                flex: 4,
                child: Text(
                  'Entrar com Google',
                  style: AppTextStyle.buttonGray,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
