import 'package:chateo/Screen/bottm_bar/home_bottom_bar.dart';
import 'package:chateo/Screen/loginscreen/widget/forget_row.dart';
import 'package:chateo/utils/images.dart';
import 'package:chateo/widgets/custom%20_container.dart';
import 'package:chateo/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginTextFiled extends StatelessWidget {
  const LoginTextFiled({super.key});

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
              ontap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const HomeBottomBar()),
                  (route) {
                    return false;
                  },
                );
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
