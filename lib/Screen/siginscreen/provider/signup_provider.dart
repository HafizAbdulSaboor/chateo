import 'dart:developer';
import 'package:chateo/auth/provider/auth_provider.dart';
import 'package:chateo/provider/bool_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    try {
      String result = await AuthServices.createUser(
        email.text,
        password.text,
        fullName.text,
      );
      if (result == 'register') {
        Provider.of<ProviderBool>(context, listen: false).setValue(false);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
        VxToast.show(context,
            msg: 'Signup Successful',
            bgColor: Colors.green,
            textColor: Colors.white);
      }
    } catch (e) {
      log("signup error : $e");
      VxToast.show(context,
          msg: 'An Error Occured',
          bgColor: Colors.red,
          textColor: Colors.white);
    }
  }

  // Sign in
  Future<void> sigins(BuildContext context) async {
    try {
      String result =
          await AuthServices.signin(email.text, password.text, context);
      if (result == 'success') {
        // await provider.getSelfInfo();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeBottomBar()),
            (route) => false);
        VxToast.show(context,
            msg: 'Signup Successful',
            bgColor: Colors.green,
            textColor: Colors.white);
        email.clear();
        password.clear();
      }
    } catch (e) {
      log("login error : $e");
      VxToast.show(context,
          msg: 'An Error Occured',
          bgColor: Colors.red,
          textColor: Colors.white);
    }
  }
}
