import 'package:chateo/utils/colors.dart';
import 'package:flutter/material.dart';

class ForgetRow extends StatefulWidget {
  const ForgetRow({super.key});

  @override
  State<ForgetRow> createState() => _ForgetRowState();
}

class _ForgetRowState extends State<ForgetRow> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // login check box
        Checkbox(
          checkColor: AppColors.containerColor,
          activeColor: AppColors.checkColor,
          overlayColor: const WidgetStatePropertyAll(AppColors.checkColor),
          focusColor: AppColors.checkColor,
          side: const BorderSide(
            color: AppColors.checkColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // Change border radius here
          ),
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),

        const Text(
          'Remember me',
          style: TextStyle(
              fontFamily: 'mulish',
              fontSize: 9,
              fontWeight: FontWeight.w400,
              color: AppColors.containerColor),
        ),
        Spacer(),
        const Row(
          children: [
            Text(
              'Forget password ?',
              style: TextStyle(
                  fontFamily: 'mulish',
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                  color: AppColors.spanColor),
            )
          ],
        )
      ],
    );
  }
}
