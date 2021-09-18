import 'package:flutter/material.dart';

import '../../config/custom_color.dart';
import '../../config/custom_label.dart';
import '../../config/size_config.dart';
import '../../utils/screen_navigator.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Init Size Config
    SizeConfig().init(context);
    return Scaffold(
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
            onTap: () => ScreenNavigator.startScreen(context, LoginScreen()),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
