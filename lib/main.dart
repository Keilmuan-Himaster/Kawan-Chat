import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/ui/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Mulish",
        backgroundColor: NeutralColor().white,
        appBarTheme: AppBarTheme(
          backgroundColor: NeutralColor().white
        )
      ),
      home: OnboardingScreen(),
    );
  }
}
