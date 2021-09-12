import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class CustomDialog {
  // FIXME: Update to use ThemeData
  static ProgressDialog customProgressDialog(BuildContext context,
        {String? message, String? title}) =>
    ProgressDialog(context,
        dialogStyle: DialogStyle(borderRadius: BorderRadius.circular(6)),
        message: Text(message ?? "Sedang menambahkan data"),
        title: Text(title ?? "Loading..."));
}