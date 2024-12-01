import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../auth/user_auth.dart';
import '../../bottm_bar/home_bottom_bar.dart';
import '../../loginscreen/login_screen.dart';

class RegisterProvider with ChangeNotifier {
  final email = TextEditingController();

  final fullName = TextEditingController();
  final password = TextEditingController();
  //  create user
  Future<void> createUser(BuildContext context) async {
    String result = await AuthServices.createUser(
        email.text, password.text,  fullName.text,);
    if (result == 'register') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
    }
  }

  // Sign in
  Future<void> sigins(BuildContext context) async {
    try {
      String result =
      await AuthServices.signin(email.text, password.text, context);
      if (result == 'success') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeBottomBar()),
                (route) => false);
        VxToast.show(context, msg: 'Signup Successful',bgColor: Colors.green,textColor: Colors.white);
      }
    } catch (e) {
      log("login error : $e");
      VxToast.show(context, msg: 'An Error Occured',bgColor: Colors.red,textColor: Colors.white);
    }
  }
}