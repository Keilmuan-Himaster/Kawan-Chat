import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_label.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/models/api_return_value.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/ui/screens/fill_profile_data_screen.dart';
import 'package:chat_app/ui/widgets/custom_app_bar.dart';
import 'package:chat_app/ui/widgets/custom_toast.dart';
import 'package:chat_app/utils/custom_navigator.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen(
      {Key? key, required this.phoneNumber, required this.verificationId, this.code})
      : super(key: key);

  final String phoneNumber, verificationId;
  final String? code;

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  List<String?> codeVerification = [null, null, null, null, null, null];

  void _onKeyboardTap(String value) async {
    int index = codeVerification.indexOf(null);
    ApiReturnValue<bool> result = ApiReturnValue(isSuccess: false);
    if (index != -1) {
      setState(() {
        codeVerification[index] = value;
      });
      if (!codeVerification.contains(null)) {
        // Code Verification filled
        // TODO: Set loading indicator
        result = await signInWithPhoneNumber();
      }
    } else {
      // Code Verification filled
      // TODO: Set loading indicator
      result = await signInWithPhoneNumber();
    }

    if (result.isSuccess!) {
      CustomNavigator().removeScreen(context, FillProfileDataScreen(
        phoneNumber: widget.phoneNumber,
        uid: result.result!,
      ));
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

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  // TODO: Find best practice for this code
  Future<ApiReturnValue<bool>> signInWithPhoneNumber() async {
    String code = "";
    for (var i in codeVerification) {
      code += i ?? "";
    }
    // TODO: Is it correct to handle this errors?
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId, smsCode: code);

      final User user =
          (await firebaseAuth.signInWithCredential(credential)).user!;

      CustomToast.showToast(message: "Successfully signed in UID: ${user.uid}");

      return ApiReturnValue(isSuccess: true, result: user.uid);
    } catch (e) {
      CustomToast.showToast(message: "Failed to sign in: $e");

      return ApiReturnValue(isSuccess: false, message: e.toString());
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
