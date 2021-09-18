import 'package:flutter/material.dart';

import 'config/theme_config.dart';
import 'ui/screens/main_screen.dart';
import 'ui/screens/onboarding_screen.dart';

void main() {
  // TODO: Day 2 - Init Firebase

  // TODO: Day 1 - Listen data Thema dari SharedPreference
  bool isDark = true;

  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.isDark}) : super(key: key);

  final bool isDark;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: Day 1 - Ganti data ThemeCubit sesuai dengan data dari SharedPreference

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Day 1 - Inisialisasi Cubit

    // TODO: Day 1 - ThemeCubit
    return MaterialApp(
      theme: (widget.isDark) ? ThemeConfig.darkTheme : ThemeConfig.lightTheme,
      // TODO: Day 2 - Inisialisasi halaman menyesuikan status login
      initialRoute: "main_screen",
      routes: {
        "onboarding_screen": (context) => OnboardingScreen(),
        "main_screen": (context) => MainScreen()
      },
    );
  }
}
