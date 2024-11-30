import 'package:chateo/utils/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Home Screen',
          style: TextStyle(color: AppColors.whiteColor),
        )
      ],
    );
  }
}
