import 'package:chat_app/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/cubit/cubits.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'config/theme_config.dart';
import 'ui/screens/main_screen.dart';
import 'ui/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Day 2.1 - Init Firebase
  await Firebase.initializeApp();

  // TODO: Day 1.3 - Listen data Thema dari SharedPreference
  bool isDark =
      await Preferences.instance().then((value) => value.isDark ?? false);

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
  // TODO: Day 1.4 - Buat variabel themeCubit dan Ganti data ThemeCubit sesuai dengan data dari SharedPreference
  ThemeCubit themeCubit = ThemeCubit();

  @override
  void initState() {
    themeCubit.changeTheme(
        (widget.isDark) ? ThemeConfig.darkTheme : ThemeConfig.lightTheme);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Day 1.5 - Inisialisasi Cubit

    // TODO: Day 1.6 - BlocBuilder dan BlocProvider ThemeCubit
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        ),
      ],
      child: BlocProvider(
        create: (context) => themeCubit,
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              theme: state.themeData,
              // TODO: Day 2.14 - Inisialisasi halaman menyesuikan status login
              initialRoute: (FirebaseAuth.instance.currentUser == null)
                  ? "onboarding_screen"
                  : "main_screen",
              routes: {
                "onboarding_screen": (context) => OnboardingScreen(),
                "main_screen": (context) => MainScreen()
              },
            );
          },
        ),
      ),
    );
  }
}
