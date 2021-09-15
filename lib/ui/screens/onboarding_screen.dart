import 'package:chat_app/ui/screens/login_screen.dart';
import 'package:chat_app/utils/custom_navigator.dart';
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
      // backgroundColor: NeutralColor.white,
      body: buildBody(context),
    );
  }

  Container buildBody(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Image.asset(
            Theme.of(context).scaffoldBackgroundColor == NeutralColor.white ? "assets/images/illustration_splash_light.png" : "assets/images/illustration_splash_dark.png",
            height: 271,
          ),
          SizedBox(
            height: 42,
          ),
          Text(
            CustomLabel.splashLabel,
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.headline2,
          ),
          Spacer(),
          Text(
            "Terms & Privacy Policy",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 18,
          ),
          CustomButton(
            label: "Start Messaging",
            onTap: () => CustomNavigator().startScreen(context, LoginScreen()),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
