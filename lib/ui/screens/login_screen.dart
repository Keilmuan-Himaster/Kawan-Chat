import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_label.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/ui/screens/verification_screen.dart';
import 'package:chat_app/ui/widgets/custom_app_bar.dart';
import 'package:chat_app/ui/widgets/custom_button.dart';
import 'package:chat_app/ui/widgets/custom_text_field.dart';
import 'package:chat_app/ui/widgets/custom_toast.dart';
import 'package:chat_app/utils/custom_navigator.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();

  void _onKeyboardTap(String value) {
    setState(() {
      phoneNumberController.text = phoneNumberController.text + value;
    });
  }

  void _onKeyboardBackspaceTap() {
    if (phoneNumberController.text.length > 0) {
      setState(() {
        phoneNumberController.text = phoneNumberController.text
            .substring(0, phoneNumberController.text.length - 1);
      });
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
            CustomLabel().loginLabel,
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
            CustomLabel().loginDescription,
            textAlign: TextAlign.center,
            style:
                CustomTextStyle().body2.copyWith(color: NeutralColor().active),
          ),
        ),
        SizedBox(
          height: 42,
        ),
        Container(
          height: 36,
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                    color: NeutralColor().offWhite,
                    borderRadius: BorderRadius.circular(4)),
                child: Row(
                  children: [
                    Image.asset("assets/images/flag_id.png"),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "+62",
                      style: CustomTextStyle()
                          .body1
                          .copyWith(color: NeutralColor().disabled),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                  child: CustomTextField(
                controller: phoneNumberController,
                hintText: "Phone Number",
                readOnly: true,
              ))
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
          child: CustomButton(
              label: "Continue",
              onTap: () {
                if (phoneNumberController.text.trim().length > 0) {
                  CustomNavigator().startScreen(
                      context,
                      VerificationScreen(
                        phoneNumber: "+62" + phoneNumberController.text,
                      ));
                } else {
                  CustomToast.showToast(message: "Masukan nomor dengan benar!");
                }
              }),
        ),
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
