import 'package:chateo/Screen/loginscreen/login_screen.dart';
import 'package:chateo/apis/auth_apis.dart';
import 'package:chateo/utils/colors.dart';
import 'package:chateo/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogOutScreen extends StatefulWidget {
  const LogOutScreen({super.key});

  @override
  State<LogOutScreen> createState() => _LogOutScreenState();
}

class _LogOutScreenState extends State<LogOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GestureDetector(
        onTap: () {
          Apis.auth.signOut().then((value) => Navigator.of(context)
              .pushReplacement(MaterialPageRoute(
                  builder: (context) => const LoginScreen())));
        },
        child: Center(
          child: Container(
            height: 37,
            width: 137,
            decoration: const BoxDecoration(
                color: AppColors.containerColor,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(AppImage.logouticon),
                  const Text(
                    'Logout',
                    style: TextStyle(
                        fontFamily: 'hind',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
