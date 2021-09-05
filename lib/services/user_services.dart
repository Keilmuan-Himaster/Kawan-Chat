import 'package:chat_app/models/api_return_value.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static final CollectionReference userCollection =
      _firebaseFirestore.collection("users");

  static Future<ApiReturnValue<bool>> addUser(UserModel user) async {
    // TODO: Upload Image
    late ApiReturnValue<bool> result;
    await userCollection.doc(user.uid).set(user.toJson()).then((value) {
      result = ApiReturnValue(isSuccess: true);
    }).catchError((onError) {
      result = ApiReturnValue(isSuccess: false, message: "${onError.message}");
    });

    return result;
  }
}
