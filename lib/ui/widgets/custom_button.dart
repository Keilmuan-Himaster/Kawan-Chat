import 'package:flutter/material.dart';

import '../../config/custom_color.dart';
import '../../utils/size_config.dart';

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
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$label",
                style: Theme.of(context).textTheme.subtitle2?.copyWith(color: NeutralColor.offWhite),
              )
            ],
          )),
    );
  }
}
