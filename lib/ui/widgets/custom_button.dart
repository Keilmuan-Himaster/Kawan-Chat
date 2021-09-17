import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.label,
    this.onTap,
    this.labelColor,
    this.backgroundColor,
  }) : super(key: key);

  final String? label;
  final Function? onTap;
  final Color? labelColor, backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        primary: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      onPressed: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            color: backgroundColor ?? BrandColor.defaultColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$label",
                style: CustomTextStyle
                    .subHeading2
                    .copyWith(color: labelColor ?? NeutralColor.white),
              )
            ],
          )),
    );
  }
}
