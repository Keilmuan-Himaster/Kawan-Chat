import 'package:flutter/material.dart';

import '../../config/custom_color.dart';
import '../../config/custom_label.dart';
import '../../config/custom_text_style.dart';
import '../../utils/size_config.dart';
import '../widgets/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Init Size Config
    SizeConfig().init(context);
    return Scaffold(
      body: buildBody(),
    );
  }

  Container buildBody() {
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Image.asset(
            "assets/images/illustration_splash.png",
            height: 271,
          ),
          SizedBox(
            height: 42,
          ),
          Text(
            CustomLabel().splashLabel,
            textAlign: TextAlign.center,
            style:
                CustomTextStyle().heading2.copyWith(color: NeutralColor().dark),
          ),
          Spacer(),
          Text(
            "Terms & Privacy Policy",
            style: CustomTextStyle().body1.copyWith(color: NeutralColor().dark),
          ),
          SizedBox(
            height: 18,
          ),
          CustomButton(
            label: "Start Messaging",
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
