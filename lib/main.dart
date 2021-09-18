import 'package:chat_app/cubit/theme_cubit/theme_cubit.dart';
import 'package:chat_app/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/theme_config.dart';
import 'ui/screens/main_screen.dart';
import 'ui/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Day 2 - Init Firebase

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

    // TODO: Day 1 - ThemeCubit
    return MultiBlocProvider(
      providers: [
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
              // TODO: Day 2 - Inisialisasi halaman menyesuikan status login
              initialRoute: "main_screen",
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
