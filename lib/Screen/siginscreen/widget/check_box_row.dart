import 'package:chateo/utils/colors.dart';
import 'package:flutter/material.dart';

class CheckBoxRow extends StatefulWidget {
  const CheckBoxRow({super.key});

  @override
  State<CheckBoxRow> createState() => _CheckBoxRowState();
}

class _CheckBoxRowState extends State<CheckBoxRow> {
  bool isChecked = false;
  int selected = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
        RichText(
            text: const TextSpan(children: [
          TextSpan(
              text: 'By checking the box you agree to our',
              style: TextStyle(
                  fontFamily: 'mulish',
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                  color: AppColors.containerColor)),
          TextSpan(
              text: ' Terms',
              style: TextStyle(
                  fontFamily: 'mulish',
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                  color: AppColors.spanColor)),
          TextSpan(
              text: ' and',
              style: TextStyle(
                  fontFamily: 'mulish',
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                  color: AppColors.containerColor)),
          TextSpan(
              text: ' Conditions',
              style: TextStyle(
                  fontFamily: 'mulish',
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                  color: AppColors.spanColor)),
        ]))
      ],
    );
  }
}
