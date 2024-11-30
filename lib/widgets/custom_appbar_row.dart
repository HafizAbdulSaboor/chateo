import 'package:chateo/utils/colors.dart';
import 'package:chateo/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBArRow extends StatelessWidget {
  final String rowtext;
  const CustomAppBArRow({
    super.key,
    required this.rowtext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          rowtext,
          style: const TextStyle(
              fontFamily: 'mulish',
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor),
        ),
        Row(children: [
          SvgPicture.asset(AppImage.searchicon),
          const SizedBox(
            width: 20,
          ),
          PopupMenuButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            // popUpAnimationStyle: AnimationStyle(duration: Durations.medium2),
            position: PopupMenuPosition.under,

            color: AppColors.containerColor,
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                    child: Container(
                  height: 44,
                  // width: 193,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColors.whiteColor),
                  child: const Center(
                    child: Text(
                      'Create a New group',
                      style: TextStyle(
                          color: AppColors.poptextColor,
                          fontFamily: 'mulish',
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )),
                PopupMenuItem(
                    height: 50,
                    child: Container(
                      height: 44,
                      // width: 193,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColors.whiteColor),
                      child: const Center(
                        child: Text(
                          'Your linked devices',
                          style: TextStyle(
                              color: AppColors.poptextColor,
                              fontFamily: 'mulish',
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )),
                PopupMenuItem(
                    height: 50,
                    child: Container(
                      // width: 193,
                      height: 44,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColors.whiteColor),
                      child: const Center(
                        child: Text(
                          'Starred Messages',
                          style: TextStyle(
                              color: AppColors.poptextColor,
                              fontFamily: 'mulish',
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )),
                PopupMenuItem(
                    child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => const SettingScreen()));
                  },
                  child: Container(
                    // width: 193,
                    height: 44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColors.whiteColor),
                    child: const Center(
                      child: Text(
                        'Settings',
                        style: TextStyle(
                            color: AppColors.poptextColor,
                            fontFamily: 'mulish',
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )),
              ];
            },
            child: SvgPicture.asset(AppImage.menuicon),
          ),
        ])
      ],
    );
  }
}
