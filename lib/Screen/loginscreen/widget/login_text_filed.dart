import 'dart:developer';

import 'package:chateo/Screen/bottm_bar/home_bottom_bar.dart';
import 'package:chateo/Screen/loginscreen/widget/forget_row.dart';
import 'package:chateo/Screen/siginscreen/provider/signup_provider.dart';
import 'package:chateo/utils/images.dart';
import 'package:chateo/widgets/custom%20_container.dart';
import 'package:chateo/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginTextFiled extends StatefulWidget {
  const LoginTextFiled({super.key});

  @override
  State<LoginTextFiled> createState() => _LoginTextFiledState();
}

class _LoginTextFiledState extends State<LoginTextFiled> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterProvider>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomTextField(
            xicon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImage.mailicon),
              ],
            ),
            text: 'Valid email',
            controller: provider.email,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomTextField(
            isPass: true,
            xicon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImage.lockicon),
              ],
            ),
            text: 'Strong Password',
            controller: provider.password,
          ),
        ),
        const SizedBox(
          height: 17,
        ),
        //  forget Row
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 33),
          child: ForgetRow(),
        ),

        //  Login & google Container
        const SizedBox(
          height: 100,
        ),
        //  Sign In container
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomContainer(
              ontap: () async {
                if (provider.email.text.isNotEmpty &&
                    provider.password.text.isNotEmpty) {
                  await provider.sigins(context);
                } else {
                  log('provider.email.text');
                  log('provider.password.text');
                  VxToast.show(context,
                      msg: "Please fill in all fields",
                      bgColor: Colors.red,
                      textColor: Colors.white);
                }
              },
              isPass: true,
              text: 'Login'),
        ),
        const SizedBox(
          height: 30,
        ),
        //  Divider
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Divider(
            height: 10,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        //  google container
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: CustomContainer(
              // icon: SvgPicture.asset(AppImage.googleicon),
              text: "Continue with Google",
              isPass: false),
        ),
      ],
    );
  }
}
