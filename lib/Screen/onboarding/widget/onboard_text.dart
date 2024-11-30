import 'package:chateo/utils/colors.dart';
import 'package:flutter/material.dart';

class OnboardText extends StatelessWidget {
  const OnboardText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          width: 268,
          child: Text(
            textAlign: TextAlign.center,
            "Connect easily with your family and friends over countries",
            style: TextStyle(
                fontFamily: 'mulish',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.onbordTextColor),
          ),
        ),
        SizedBox(
          height: 150,
        ),
        Text(
          "Terms & Privacy Policy",
          style: TextStyle(
              fontFamily: 'mulish',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
