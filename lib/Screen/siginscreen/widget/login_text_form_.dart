import 'package:chateo/Screen/loginscreen/login_screen.dart';
import 'package:chateo/Screen/siginscreen/widget/check_box_row.dart';
import 'package:chateo/utils/images.dart';
import 'package:chateo/widgets/custom%20_container.dart';
import 'package:chateo/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginTextFormField extends StatelessWidget {
  const LoginTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomTextField(
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
              ontap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) {
                    return false;
                  },
                );
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
