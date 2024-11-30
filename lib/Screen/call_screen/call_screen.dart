import 'package:chateo/utils/colors.dart';
import 'package:flutter/material.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Call Screen',
          style: TextStyle(color: AppColors.whiteColor),
        )
      ],
    );
  }
}
