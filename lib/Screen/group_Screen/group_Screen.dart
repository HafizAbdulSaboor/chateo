import 'package:chateo/utils/colors.dart';
import 'package:flutter/material.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Group Screen",
          style: TextStyle(color: AppColors.whiteColor),
        )
      ],
    );
  }
}
