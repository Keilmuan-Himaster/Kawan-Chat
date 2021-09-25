import 'package:chat_app/ui/widgets/custom_button.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomConnectionError extends StatelessWidget {
  const CustomConnectionError({Key? key, this.onTap, required this.showButton, this.subtitle, this.message, required this.imageName})
      : super(key: key);

  final Function? onTap;
  final String? message, subtitle;
  final String imageName;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/$imageName",
          height: 176,
          width: 176,
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: Text(message ?? "",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2),
        ),
        SizedBox(
          height: 4,
        ),
        SizedBox(
          width: SizeConfig.screenWidth * 0.45,
          child: Text(
            subtitle ?? "",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
       (showButton) ? Padding(
         padding:  EdgeInsets.only(top: 20),
         child: CustomButton(
            label: "Refresh",
            width: SizeConfig.screenWidth * 0.5,
            onTap: () => onTap,
          ),
       ) : SizedBox.shrink(),
      ],
    );
  }
}
