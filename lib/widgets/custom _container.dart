import 'package:chateo/utils/colors.dart';
import 'package:chateo/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Function()? ontap;
  final bool isPass;
  final Widget? icon;
  const CustomContainer(
      {super.key,
      required this.text,
      this.style,
      this.ontap,
      required this.isPass,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return isPass
        ? GestureDetector(
            onTap: ontap,
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                  color: AppColors.containerColor,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  text,
                  style: const TextStyle(
                      fontFamily: 'mulish',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.containertextColor),
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: ontap,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor, width: 1.1),
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(AppImage.googleImage)),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    text,
                    style: const TextStyle(
                        fontFamily: 'mulish',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.containerColor),
                  ),
                ],
              ),
            ),
          );
  }
}
