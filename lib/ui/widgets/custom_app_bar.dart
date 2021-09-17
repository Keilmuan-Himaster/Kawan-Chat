import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/utils/custom_navigator.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key, this.label}) : super(key: key);

  final String? label;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          title: Text(
            label ?? "",
            style: CustomTextStyle
                .subHeading1
                .copyWith(color: NeutralColor.active),
          ),
          iconTheme: IconThemeData(color: NeutralColor.active),
          leading: GestureDetector(
              onTap: () {
                CustomNavigator().closeScreen(context);
              },
              child: Icon(
                Icons.chevron_left,
                size: 30,
              )),
          centerTitle: true,
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
