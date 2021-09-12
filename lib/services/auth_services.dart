import 'package:chat_app/models/api_return_value.dart';
import 'package:chat_app/ui/screens/fill_profile_data_screen.dart';
import 'package:chat_app/ui/screens/verification_screen.dart';
import 'package:chat_app/ui/widgets/custom_dialog.dart';
import 'package:chat_app/ui/widgets/custom_toast.dart';
import 'package:chat_app/utils/custom_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class AuthServices {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future<void> verifyPhoneNumber(
      {required String phoneNumber, required BuildContext context}) async {
    ProgressDialog progressDialog = CustomDialog.customProgressDialog(context,
        message: "Sedang memverifikasi nomor");
    progressDialog.show();

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await firebaseAuth.signInWithCredential(phoneAuthCredential);

      print("{ PHONE VERIFY [VERIFICATION COMPLETED] }");

      CustomToast.showToast(
          message: "Phone number automatically verified and user signed");

      progressDialog.dismiss();

      CustomNavigator().startScreen(
          context,
          FillProfileDataScreen(
              uid: firebaseAuth.currentUser!.uid,
              phoneNumber: phoneNumber));
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {

      print("{ PHONE VERIFY FAILED [${authException.message}] }");

      String errorMessage = "";
      if (authException.code == 'invalid-phone-number') {
        errorMessage = 'The provided phone number is not valid.';
      } else if (authException.code == "too-many-requests") {
        errorMessage = 'Too many requests on this phone number.';
      } else {
        errorMessage = authException.message ?? "Error";
      }

      progressDialog.dismiss();

      CustomToast.showToast(message: errorMessage);
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      progressDialog.dismiss();

      print("{ PHONE VERIFY [CODE SEND] }");
      print("{ PHONE VERIFY FORCE RESENDING TOKEN [$forceResendingToken] }");

      CustomNavigator().startScreen(
          context,
          VerificationScreen(
              phoneNumber: "+62" + phoneNumber,
              verificationId: verificationId));
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      print("{ PHONE VERIFY [CODE AUTO RETRIEVAL TIME OUT] }");
      progressDialog.dismiss();
    };

    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }
}
