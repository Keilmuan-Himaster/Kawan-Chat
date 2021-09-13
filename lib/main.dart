import 'package:chat_app/config/theme_config.dart';
import 'package:chat_app/cubit/cubit.dart';
import 'package:chat_app/ui/screens/main_screen.dart';
import 'package:chat_app/ui/screens/onboarding_screen.dart';
import 'package:chat_app/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool isDark = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  isDark = await Preferences.instance().then((value) => value.isDark ?? false);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeCubit themeCubit = ThemeCubit();

  @override
  void initState() {
    themeCubit
        .changeTheme((isDark) ? ThemeConfig.darkTheme : ThemeConfig.lightTheme);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        )
      ],
      child: BlocProvider(
        create: (context) => themeCubit,
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              theme: state.themeData,
              // home: OnboardingScreen(),
              initialRoute: (FirebaseAuth.instance.currentUser == null)
                  ? "onboardingScreen"
                  : "mainScreen",
              routes: {
                "onboardingScreen": (context) => OnboardingScreen(),
                "mainScreen": (context) => MainScreen()
              },
            );
          },
        ),
      ),
    );
  }
}
