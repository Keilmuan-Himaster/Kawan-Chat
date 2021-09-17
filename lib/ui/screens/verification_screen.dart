import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_label.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/cubit/user_cubit/user_cubit.dart';
import 'package:chat_app/models/api_return_value.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/user_services.dart';
import 'package:chat_app/ui/screens/fill_profile_data_screen.dart';
import 'package:chat_app/ui/screens/main_screen.dart';
import 'package:chat_app/ui/widgets/custom_app_bar.dart';
import 'package:chat_app/ui/widgets/custom_dialog.dart';
import 'package:chat_app/ui/widgets/custom_numerical_keyboard.dart';
import 'package:chat_app/ui/widgets/custom_toast.dart';
import 'package:chat_app/utils/custom_navigator.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ndialog/ndialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen(
      {Key? key,
      required this.phoneNumber,
      required this.verificationId,
      this.code})
      : super(key: key);

  final String phoneNumber, verificationId;
  final String? code;

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  List<String?> codeVerification = [null, null, null, null, null, null];

  // change value [isExpired] from the result of signInWithPhoneNumber
  bool isExpired = false;

  // TODO: Find best practices for this code
  void _onKeyboardTap(String value) async {
    int index = codeVerification.indexOf(null);
    ApiReturnValue<bool>? result;
    ProgressDialog progressDialog = CustomDialog.showProgressDialog(context,
        message: "Sedang memverifikasi code");

    if (index != -1) {
      setState(() {
        codeVerification[index] = value;
      });
      if (!codeVerification.contains(null)) {
        // Code Verification filled
        progressDialog.show();
        result = await signInWithPhoneNumber();
        progressDialog.dismiss();
      }
    } else {
      // Code Verification filled
      progressDialog.show();
      result = await signInWithPhoneNumber();
      progressDialog.dismiss();
    }

    if (result != null) {
      if (result.isSuccess!) {
        ApiReturnValue<bool> userIsExists =
            await context.read<UserCubit>().checkUserExists(result.result!);

        if (userIsExists.value!) {
          CustomNavigator().removeAllScreen(context, MainScreen());
        } else {
          CustomNavigator().removeScreen(
              context,
              FillProfileDataScreen(
                phoneNumber: widget.phoneNumber,
                uid: result.result!,
              ));
        }
      } else {
        CustomToast.showToast(message: result.message);
      }
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

    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId, smsCode: code);

      final User user =
          (await firebaseAuth.signInWithCredential(credential)).user!;

      return ApiReturnValue(isSuccess: true, result: user.uid);
    } catch (e) {
      // TODO: Find how to handle error message code
      // session-expired -> for message if [code verification] is expired
      if (e.toString().contains("session-expired")) {
        setState(() {
          isExpired = true;
        });
      }
      return ApiReturnValue(isSuccess: false, message: e.toString());
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
                  CustomNavigator().closeScreen(context);
                }
              },
              child: Text(
                "Resend Code",
                style: CustomTextStyle.subHeading2.copyWith(
                    color: Theme.of(context).primaryColor),
              ),
            )),
        SizedBox(
          height: 20,
        ),
        CustomNumericalKeyboard(
          onKeyboardTap: _onKeyboardTap,
          rightButtonFn: _onKeyboardBackspaceTap,
        )
      ],
    );
  }
}
