import 'package:flutter/material.dart';

import 'config/theme_config.dart';
import 'ui/screens/main_screen.dart';
import 'ui/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Day 2.1 - Init Firebase

  // TODO: Day 1.3 - Listen data Thema dari SharedPreference
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
  // TODO: Day 1.4 - Buat variabel themeCubit dan InitState untuk Ganti data ThemeCubit sesuai dengan data dari SharedPreference

  @override
  Widget build(BuildContext context) {
    // TODO: Day 1.5 - Inisialisasi Cubit

    // TODO: Day 1.6 - BlocBuilder dan BlocProvider ThemeCubit
    return MaterialApp(
      theme: (widget.isDark) ? ThemeConfig.darkTheme : ThemeConfig.lightTheme,
      // TODO: Day 2.16 - Inisialisasi halaman menyesuikan status login
      initialRoute: "main_screen",
      routes: {
        "onboarding_screen": (context) => OnboardingScreen(),
        "main_screen": (context) => MainScreen()
      },
    );
  }
}
