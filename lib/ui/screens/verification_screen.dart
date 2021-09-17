import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_label.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/ui/screens/fill_profile_data_screen.dart';
import 'package:chat_app/ui/widgets/custom_app_bar.dart';
import 'package:chat_app/ui/widgets/custom_numerical_keyboard.dart';
import 'package:chat_app/utils/screen_navigator.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key, required this.phoneNumber})
      : super(key: key);

  final String phoneNumber;

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  List<String?> codeVerification = [null, null, null, null, null, null];

  // change value [isExpired] from the result of signInWithPhoneNumber
  bool isExpired = false;

  void _onKeyboardTap(String value) {
    int index = codeVerification.indexOf(null);
    if (index != -1) {
      setState(() {
        codeVerification[index] = value;
      });
      if (!codeVerification.contains(null)) {
        // Code Verification filled
        ScreenNavigator.removeScreen(context, FillProfileDataScreen(phoneNumber: "",uid: "",));
      }
    } else {
      // Code Verification filled
      ScreenNavigator.removeScreen(context, FillProfileDataScreen(uid: "",phoneNumber: "",));
    }
  }

  void _onKeyboardBackspaceTap() {
    if (codeVerification.first != null) {
      int index = codeVerification.indexOf(null);
      if (index == -1) {
        codeVerification.last = null;
      } else {
        codeVerification[index - 1] = null;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: buildBody(),
    );
  }

  Column buildBody() {
    return Column(
      children: [
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
          child: Text(CustomLabel.verificationLabel,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2),
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
          child: Text(
              CustomLabel.verifitcaionDescription + " " + widget.phoneNumber,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2),
        ),
        SizedBox(
          height: 42,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: codeVerification
                  .asMap()
                  .map((key, value) => MapEntry(
                      key,
                      (value == null)
                          ? Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).splashColor,
                                  shape: BoxShape.circle),
                            )
                          : SizedBox(
                              height: 24,
                              width: 24,
                              child: Text(value,
                                  style: Theme.of(context).textTheme.subtitle1),
                            )))
                  .values
                  .toList()),
        ),
        Spacer(),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
            child: TextButton(
              onPressed: () {
                // TODO: Find the best way to handle this
                if (isExpired) {
                  // Code expired
                  ScreenNavigator.closeScreen(context);
                }
              },
              child: Text(
                "Resend Code",
                style: CustomTextStyle.subHeading2
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            )),
        SizedBox(
          height: 32,
        ),
        CustomNumericalKeyboard(
          onKeyboardTap: _onKeyboardTap,
          rightButtonFn: _onKeyboardBackspaceTap,
        )
      ],
    );
  }
}
