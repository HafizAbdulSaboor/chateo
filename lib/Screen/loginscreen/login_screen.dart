import 'package:chateo/Screen/loginscreen/widget/log_in_bar.dart';
import 'package:chateo/Screen/loginscreen/widget/login_text_filed.dart';
import 'package:chateo/Screen/siginscreen/sigin_screen.dart';
import 'package:chateo/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: LogInBar(),
            ),
            SizedBox(
              height: 95,
            ),
            LoginTextFiled(),
          ],
        ),
      ),

      //  navigate sigin screen if u have already acc
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SiginScreen()));
        },
        child: RichText(
            text: const TextSpan(children: [
          TextSpan(
            text: 'Dont have an account? ',
            style: TextStyle(
                fontFamily: 'mulish',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.containerColor),
          ),
          TextSpan(
            text: '  Sign up',
            style: TextStyle(
                fontFamily: 'mulish',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.spanColor),
          ),
        ])),
      ),
    );
  }
}
