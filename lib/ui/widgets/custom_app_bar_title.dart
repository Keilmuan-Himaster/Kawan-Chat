import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:flutter/material.dart';


class CustomAppBarTitle extends StatelessWidget {
  const CustomAppBarTitle({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
     title,
      style: CustomTextStyle()
          .subHeading1
          .copyWith(color: NeutralColor.active),
    );
  }
}
