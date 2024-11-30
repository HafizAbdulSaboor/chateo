import 'package:chateo/Screen/onboarding/widget/onboard_text.dart';
import 'package:chateo/Screen/siginscreen/sigin_screen.dart';
import 'package:chateo/utils/colors.dart';
import 'package:chateo/utils/images.dart';
import 'package:chateo/widgets/custom%20_container.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          //  logo widget
          Padding(
            padding: const EdgeInsets.only(
              top: 100,
              right: 46,
              left: 46,
            ),
            child: SizedBox(
                // width: 268,
                // height: 271,
                child: Image.asset(AppImage.onbordlogo)),
          ),
          const SizedBox(
            height: 50,
          ),
          //  Text
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 46),
              child: OnboardText()),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23),
        child: CustomContainer(
          isPass: true,
          ontap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SiginScreen()));
          },
          text: 'Start Messaging',
        ),
      ),
    );
  }
}
