import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class CustomToast {
  static void showToast({String? message}) {
    Fluttertoast.showToast(
        msg: message ?? "", backgroundColor: Colors.black);
  }
}
