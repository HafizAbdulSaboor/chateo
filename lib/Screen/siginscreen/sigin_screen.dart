import 'package:chateo/Screen/loginscreen/login_screen.dart';

import 'package:chateo/Screen/siginscreen/widget/login_text_form_.dart';
import 'package:chateo/Screen/siginscreen/widget/sign_in_bar.dart';
import 'package:chateo/utils/colors.dart';

import 'package:flutter/material.dart';

class SiginScreen extends StatelessWidget {

  const SiginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 78),
              child: SignInBar(),
            ),
            SizedBox(
              height: 80,
            ),
            //  Text Form Field
            LoginTextFormField(),
          ],
        ),
      ),

      //  move to login screen
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
        child: RichText(
            text: const TextSpan(children: [
          TextSpan(
            text: 'Already a member?',
            style: TextStyle(
                fontFamily: 'mulish',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.containerColor),
          ),
          TextSpan(
            text: ' Log In',
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
