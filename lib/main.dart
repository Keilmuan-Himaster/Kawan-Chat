import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/cubit/cubit.dart';
import 'package:chat_app/ui/screens/main_screen.dart';
import 'package:chat_app/ui/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: "Mulish",
            backgroundColor: NeutralColor().white,
            appBarTheme: AppBarTheme(backgroundColor: NeutralColor().white)),
        // home: OnboardingScreen(),
        initialRoute: (FirebaseAuth.instance.currentUser == null)
            ? "onboardingScreen"
            : "mainScreen",
        routes: {
          "onboardingScreen": (context) => OnboardingScreen(),
          "mainScreen": (context) => MainScreen()
        },
      ),
    );
  }
}
