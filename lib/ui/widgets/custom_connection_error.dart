import 'package:chat_app/ui/widgets/custom_button.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomConnectionError extends StatelessWidget {
  const CustomConnectionError({Key? key, this.onTap, this.message})
      : super(key: key);

  final Function? onTap;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/connection_error.png",
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
            "Mohon periksa koneksi internet anda",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SizedBox(height: 20,),
        CustomButton(
          label: "Refresh",
          width: SizeConfig.screenWidth * 0.5,
          onTap: () => onTap,
        ),
      ],
    );
  }
}
