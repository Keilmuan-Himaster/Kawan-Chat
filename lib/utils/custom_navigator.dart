import 'package:flutter/material.dart';

class CustomNavigator {
  startScreen(BuildContext context, Widget screen) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

  replaceScreen(BuildContext context, Widget screen) =>
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => screen));

  removeAllScreen(BuildContext context, Widget screen) =>
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => screen), (route) => false);

  removeScreen(BuildContext context, Widget screen) =>
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => screen));

  closeScreen<T>(BuildContext context, [T? value]) => Navigator.pop<T>(context);
}
