import 'dart:developer';

import 'package:chateo/Screen/loginscreen/login_screen.dart';
import 'package:chateo/Screen/siginscreen/widget/check_box_row.dart';
import 'package:chateo/auth/user_auth.dart';
import 'package:chateo/utils/images.dart';
import 'package:chateo/widgets/custom%20_container.dart';
import 'package:chateo/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../provider/signup_provider.dart';

class LoginTextFormField extends StatefulWidget {
  const LoginTextFormField({super.key});

  @override
  State<LoginTextFormField> createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends State<LoginTextFormField> {
  @override
  Widget build(BuildContext context) {
    final registerProvider =
    Provider.of<RegisterProvider>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomTextField(
            controller: registerProvider.fullName,
            xicon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImage.usericon),
              ],
            ),
            text: 'Full name',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomTextField(
            controller: registerProvider.email,
            // controller: email,
            xicon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImage.mailicon),
              ],
            ),
            text: 'Valid email',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomTextField(
            controller: registerProvider.password,
            isPass: true,
            xicon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImage.lockicon),
              ],
            ),
            text: 'Strong Password',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        //  CheckBox or terms & condition
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 44),
          child: CheckBoxRow(),
        ),
        const SizedBox(
          height: 50,
        ),
        //  Sign In container
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: CustomContainer(
              ontap: () async{
                if(registerProvider.fullName.text.isNotEmpty && registerProvider.email.text.isNotEmpty && registerProvider.password.text.isNotEmpty){
                  await registerProvider.sigins(context);

                }else{
                  log('provider.email.text');
                  log('provider.password.text');
                  log('provider.fullName.text');

                }
              },
              isPass: true,
              text: 'Sign up'),
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
