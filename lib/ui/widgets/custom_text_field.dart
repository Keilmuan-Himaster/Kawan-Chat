import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? suffixText;
  final String hintText;
  final int? maxLines;
  final int? minLines;
  final Function? onTap;
  final Function? onChanged;
  final Function? onEditingComplete;
  final bool? autofocus;
  final bool? readOnly;
  final FocusNode? focusNode;
  final Widget? prefixIcon;

  const CustomTextField(
      {Key? key,
      required this.controller,
      this.suffixText,
      required this.hintText,
      this.maxLines,
      this.focusNode,
      this.onChanged,
      this.onTap,
      this.readOnly,
      this.onEditingComplete,
      this.autofocus,
      this.prefixIcon,
      this.minLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TextFormField(
          controller: controller,
          minLines: (minLines == null) ? 1 : minLines,
          maxLines: (maxLines == null) ? 1 : maxLines,
          onTap: () {
            if (onTap != null) {
              onTap!();
            }
          },
          onChanged: (text) {
            if (onChanged != null) {
              onChanged!();
            }
          },
          onEditingComplete: () {
            if (onEditingComplete != null) {
              onEditingComplete!();
            }
          },
          autofocus: autofocus ?? false,
          readOnly: readOnly ?? false,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            focusedBorder: outlineInputFocusedBorder(),
            enabledBorder: outlineInputEnableBorder(),
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: (Theme.of(context).scaffoldBackgroundColor ==
                        NeutralColor().white)
                    ? NeutralColor().disabled
                    : NeutralColor().offWhite),
            fillColor: (Theme.of(context).scaffoldBackgroundColor ==
                    NeutralColor().white)
                ? NeutralColor().offWhite
                : NeutralColor().dark,
            suffixText: suffixText ?? "",
          )),
    );
  }
}

InputBorder? outlineInputFocusedBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: NeutralColor().offWhite,
      ),
    );

InputBorder? outlineInputEnableBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: NeutralColor().offWhite,
      ),
    );
