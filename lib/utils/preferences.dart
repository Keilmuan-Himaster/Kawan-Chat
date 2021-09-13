import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final SharedPreferences shared;

  Preferences(this.shared);

  // Save Data
  set isDark(bool? value) => shared.setBool("is_dark", value ?? false);

  // Load Data
  bool? get isDark => shared.getBool("is_dark");

  static Future<Preferences> instance() =>
      SharedPreferences.getInstance().then((value) => Preferences(value));
}