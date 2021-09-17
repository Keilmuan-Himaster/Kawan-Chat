import 'package:chat_app/config/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class CustomNumericalKeyboard extends StatelessWidget {
  const CustomNumericalKeyboard({
    Key? key,
    required this.onKeyboardTap,
    required this.rightButtonFn
  }) : super(key: key);

  final void Function(String) onKeyboardTap;
  final dynamic Function() rightButtonFn;

  @override
  Widget build(BuildContext context) {
    return Container(
          color: Theme.of(context).accentColor,
          child: NumericKeyboard(
              onKeyboardTap: onKeyboardTap,
              textColor: (Theme.of(context).scaffoldBackgroundColor ==
                      NeutralColor.white)
                  ? NeutralColor.active
                  : NeutralColor.offWhite,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              rightIcon: Icon(
                Icons.backspace,
                color: Theme.of(context).iconTheme.color,
              ),
              rightButtonFn: () => rightButtonFn()),
        );
  }
}