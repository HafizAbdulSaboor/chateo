import 'package:chateo/Screen/bottm_bar/home_bottom_bar.dart';
import 'package:chateo/Screen/onboarding/onboarding_screen.dart';
import 'package:chateo/apis/auth_apis.dart';
import 'package:chateo/utils/colors.dart';
import 'package:chateo/utils/images.dart';
import 'package:flutter/material.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // navigate Home screen
      if (Apis.auth.currentUser != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeBottomBar()),
            (route) => false);
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnboardingScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
          child: SizedBox(
              height: 800, width: 800, child: Image.asset(AppImage.logoImage))),
    );
  }
}
