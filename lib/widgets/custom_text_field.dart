import 'package:chateo/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final Widget? icon;
  final Widget? xicon;
  final Function()? onTap;
  final bool isreadonly;
  final bool isPass;

  final TextEditingController? controller;
  final TextInputType? keyboardtype;
  const CustomTextField({
    super.key,
    required this.text,
    this.icon,
    this.xicon,
    this.isPass = false,
    this.onTap,
    this.isreadonly = false,
    this.controller,
    this.keyboardtype,
  });
  @override
  Widget build(BuildContext context) {
    return isPass
        ? TextFormField(
            controller: controller,
            obscureText: true,
            style: const TextStyle(
                color: Colors.black,
                fontFamily: "mulish",
                fontSize: 14,
                fontWeight: FontWeight.w300),
            onTap: onTap,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(14)),
              filled: true,
              fillColor: AppColors.textfieldfillColor.withOpacity(0.2),
              hintText: text,
              hintStyle: TextStyle(
                  color: AppColors.hinttextColor.withOpacity(0.5),
                  fontFamily: 'mulish',
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                child: icon,
              ),
              suffixIcon: xicon,
            ),
          )
        : TextFormField(
            controller: controller,
            style: const TextStyle(
                color: Colors.black,
                fontFamily: "mulish",
                fontSize: 14,
                fontWeight: FontWeight.w300),
            onTap: onTap,
            keyboardType: keyboardtype,
            readOnly: isreadonly,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(14)),
              filled: true,
              fillColor: AppColors.textfieldfillColor.withOpacity(0.2),
              hintText: text,
              hintStyle: TextStyle(
                  color: AppColors.hinttextColor.withOpacity(0.5),
                  fontFamily: 'mulish',
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                child: icon,
              ),
              suffixIcon: xicon,
            ),
          );
  }
}
