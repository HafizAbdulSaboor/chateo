import 'package:chateo/Screen/bottm_bar/provider/bottom_bar_provider.dart';
import 'package:chateo/Screen/chat_screen/provider/chat_text_field_provider.dart';
import 'package:chateo/Screen/siginscreen/provider/signup_provider.dart';
import 'package:chateo/Screen/splach/splach_Screen.dart';
import 'package:chateo/chat_provider/chat_provider.dart';
import 'package:chateo/provider/bool_provider.dart';
import 'package:chateo/services/message_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth/provider/auth_provider.dart';

// global object for accessing device Screen Size
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MessagingServices.getToken();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => BottomBarProvider(),
      ),
      ChangeNotifierProvider(create: (context) => ChatTextFieldProvider()),
      ChangeNotifierProvider(create: (context) => RegisterProvider()),
      ChangeNotifierProvider(create: (context) => Authpro()),
      ChangeNotifierProvider(create: (context) => ProviderBool()),
      ChangeNotifierProvider(create: (context) => ChatProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplachScreen(),
    );
  }
}
