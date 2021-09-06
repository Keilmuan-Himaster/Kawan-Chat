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

    print("{ ADD USER ${result.isSuccess} }");

    return result;
  }

  static Future<ApiReturnValue<bool>> checkUserExists(String uid) async {
    late ApiReturnValue<bool> result;
    DocumentSnapshot<Object?> snapshot =
        await userCollection.doc(uid).get().catchError((onError) {
      result = ApiReturnValue(isSuccess: false);
    });

    if (snapshot.exists) {
      result = ApiReturnValue(isSuccess: true);
    } else {
      result = ApiReturnValue(isSuccess: false);
    }

    print("{ CHECK USER ISEXISTS ${result.isSuccess} }");

    return result;
  }
}
