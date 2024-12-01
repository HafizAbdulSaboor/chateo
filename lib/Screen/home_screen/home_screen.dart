import 'package:chateo/Screen/home_screen/widget/list_of_user.dart';
import 'package:chateo/Screen/settings_screen/settings_screen.dart';

import 'package:chateo/utils/colors.dart';
import 'package:chateo/utils/images.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text('Chats',
              style: TextStyle(
                  fontFamily: 'mulish',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: AppColors.apptextColor)),
        ),
        actions: [
          const Icon(
            Icons.search,
            color: AppColors.containerColor,
          ),
          const SizedBox(
            width: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 19.0),
            child: PopupMenuButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
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
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SettingsScreen()));
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
                child:
                    const Icon(Icons.more_vert, color: AppColors.blackColor)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
                // height: mq.height * 0.035,
                ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: ListOfUser(),
            ),
          ],
        ),
      ),
      //  user chat screen
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.whiteColor),
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              // border: Border.all(width: 2, color: AppColors.whitecolor),
              color: AppColors.floatingcontainerColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppImage.messageicon),
            ],
          ),
        ),
      ),
    );
  }
}
