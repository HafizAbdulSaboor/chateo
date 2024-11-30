import 'package:chateo/utils/colors.dart';
import 'package:flutter/material.dart';

class SignInBar extends StatelessWidget {
  const SignInBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Get Started",
            style: TextStyle(
                fontFamily: "mulish",
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.containerColor),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            "by creating a free account.",
            style: TextStyle(
                fontFamily: "mulish",
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: AppColors.textColor),
          ),
        ],
      ),
    );
  }
}
