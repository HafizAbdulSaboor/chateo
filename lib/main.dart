import 'package:chateo/Screen/bottm_bar/provider/bottom_bar_provider.dart';
import 'package:chateo/Screen/splach/splach_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// global object for accessing device Screen Size
late Size mq;

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => BottomBarProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplachScreen(),
    );
  }
}
