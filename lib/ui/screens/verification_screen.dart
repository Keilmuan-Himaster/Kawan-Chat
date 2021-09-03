import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_label.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/ui/widgets/custom_app_bar.dart';
import 'package:chat_app/utils/custom_navigator.dart';
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

  void _onKeyboardTap(String value) {
    int index = codeVerification.indexOf(null);
    if (index != -1) {
      setState(() {
        codeVerification[index] = value;
      });
    } else {
      // Code Verification filled
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
      backgroundColor: NeutralColor().white,
      body: buildBody(),
    );
  }

  Column buildBody() {
    return Column(
      children: [
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
          child: Text(
            CustomLabel().verificationLabel,
            textAlign: TextAlign.center,
            style: CustomTextStyle()
                .heading2
                .copyWith(color: NeutralColor().active),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
          child: Text(
            CustomLabel().verifitcaionDescription + " " + widget.phoneNumber,
            textAlign: TextAlign.center,
            style:
                CustomTextStyle().body2.copyWith(color: NeutralColor().active),
          ),
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
                                  color: NeutralColor().line,
                                  shape: BoxShape.circle),
                            )
                          : SizedBox(
                              height: 24,
                              width: 24,
                              child: Text(
                                value,
                                style: CustomTextStyle().subHeading1.copyWith(
                                      color: NeutralColor().active,
                                    ),
                              ),
                            )))
                  .values
                  .toList()),
        ),
        Spacer(),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
            child: Text(
              "Resend Code",
              style: CustomTextStyle()
                  .subHeading2
                  .copyWith(color: BrandColor().defaultColor),
            )),
        SizedBox(
          height: 32,
        ),
        Container(
          color: NeutralColor().offWhite,
          child: NumericKeyboard(
              onKeyboardTap: _onKeyboardTap,
              textColor: NeutralColor().active,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              rightIcon: Icon(
                Icons.backspace,
                color: NeutralColor().active,
              ),
              rightButtonFn: () => _onKeyboardBackspaceTap()),
        )
      ],
    );
  }
}
