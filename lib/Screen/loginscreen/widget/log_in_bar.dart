import 'package:chateo/utils/colors.dart';
import 'package:flutter/material.dart';

class LogInBar extends StatelessWidget {
  const LogInBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Welcome back",
            style: TextStyle(
                fontFamily: "mulish",
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.containerColor),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            "Sign in to access your account",
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
