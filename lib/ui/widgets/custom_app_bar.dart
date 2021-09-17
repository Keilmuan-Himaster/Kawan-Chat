import 'package:chat_app/utils/screen_navigator.dart';
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
            style: Theme.of(context).textTheme.subtitle1
          ),
          iconTheme: Theme.of(context).appBarTheme.iconTheme,
          leading: GestureDetector(
              onTap: () {
                ScreenNavigator.closeScreen(context);
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