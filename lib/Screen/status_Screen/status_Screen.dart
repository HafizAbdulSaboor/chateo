import 'package:chateo/utils/colors.dart';
import 'package:flutter/material.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Status Screen",
          style: TextStyle(color: AppColors.whiteColor),
        )
      ],
    );
  }
}
