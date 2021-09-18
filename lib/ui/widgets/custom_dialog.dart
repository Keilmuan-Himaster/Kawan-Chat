import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';

import '../../config/custom_color.dart';

class CustomDialog {
  static ProgressDialog showProgressDialog(BuildContext context,
          {String? message, String? title}) =>
      ProgressDialog(context,
          dialogStyle: DialogStyle(
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.circular(6),
            contentTextStyle: TextStyle(color: NeutralColor.active),
            titleTextStyle: TextStyle(color: NeutralColor.active),
          ),
          defaultLoadingWidget: showCircularProgressIndicator(),
          message: Text(
            message ?? "Sedang menambahkan data",
          ),
          title: Text(
            title ?? "Loading...",
          ));

  static Widget showCircularProgressIndicator() => Container(
        padding: EdgeInsets.all(10.0),
        height: 50.0,
        width: 50.0,
        child: CircularProgressIndicator(
          backgroundColor: Colors.blue,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 3,
        ),
      );

  static void showToast({String? message}) {
    Fluttertoast.showToast(msg: message ?? "", backgroundColor: Colors.black);
  }
}
