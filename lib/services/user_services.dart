import 'dart:io';

import 'package:chat_app/models/api_return_value.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserServices {
  // TODO: Day 2.8 - Inisialisasi Firebase Firestore
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static final CollectionReference userCollection =
      _firebaseFirestore.collection("users");

  // TODO: Day 2.10 - Inisialisasi Firebase Storage
  static final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  // TODO: Day 2.9 - Check apakah user sudah ada di firebase
  static Future<ApiReturnValue<UserModel>> checkUserExists(String uid) async {
    late ApiReturnValue<UserModel> result;
    DocumentSnapshot<Object?> snapshot =
        await userCollection.doc(uid).get().catchError((onError) {
      result = ApiReturnValue(isSuccess: false);
    });

    if (snapshot.exists) {
      result = ApiReturnValue(
          isSuccess: true,
          value: UserModel.fromJson(snapshot.data() as Map<String, dynamic>));
    } else {
      result = ApiReturnValue(isSuccess: false, message: "");
    }

    print("{ CHECK USER ISEXISTS ${result.isSuccess} }");

    return result;
  }

  // TODO: Day 2.12 - Menambahkan user di firebase
  static Future<ApiReturnValue<bool>> addUser(UserModel user) async {
    late ApiReturnValue<bool> result;
    ApiReturnValue<bool>? uploadImageStatus;
    if (user.imageUrl != "") {
      uploadImageStatus = await uploadImage(File(user.imageUrl));
    }

    if (uploadImageStatus == null) {
      await userCollection.doc(user.uid).set(user.toJson()).then((value) {
        result = ApiReturnValue(value: true, result: user.uid);
      }).catchError((onError) {
        result = ApiReturnValue(value: false, message: "${onError.message}");
      });
    } else if (uploadImageStatus.value!) {
      await userCollection
          .doc(user.uid)
          .set(UserModel(
                  uid: user.uid,
                  phoneNumber: user.phoneNumber,
                  firstName: user.firstName,
                  fullName: user.fullName,
                  lastName: user.lastName,
                  imageUrl: uploadImageStatus.result!)
              .toJson())
          .then((value) {
        result = ApiReturnValue(value: true, result: user.uid);
      }).catchError((onError) {
        result = ApiReturnValue(value: false, message: "${onError.message}");
      });
    } else {
      result = uploadImageStatus;
    }

    print("{ ADD USER ${result.value} }");

    return result;
  }

  // TODO: Day 2.11 - Upload gambar ke Firebase Storage
  static Future<ApiReturnValue<bool>> uploadImage(File image) async {
    late ApiReturnValue<bool> result;
    UploadTask uploadTask = firebaseStorage
        .ref()
        .child("images/${image.path.split('/').last}")
        .putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.catchError((onError) {
      return result =
          ApiReturnValue(value: false, message: "Failed to upload image");
    });

    await taskSnapshot.ref.getDownloadURL().then((value) {
      result = ApiReturnValue(value: true, result: value);
    });

    print("{ UPLOAD IMAGE $result }");

    return result;
  }

  // TODO: Day 2.13 - Daptkan user detail
  static Future<ApiReturnValue<UserModel>> getUserDetail(String uid) async {
    late ApiReturnValue<UserModel> result;
    await userCollection.doc(uid).get().then((value) {
      result = ApiReturnValue(
          isSuccess: true,
          value: UserModel.fromJson(value.data() as Map<String, dynamic>));
    }).catchError((onError) {
      result = ApiReturnValue(isSuccess: false, message: "");
    });

    print("{ GET USER DETAIL $result }");

    return result;
  }

  // TODO: Day 3.1 - Search User by name
  static Stream<QuerySnapshot> getListUserByName(
      {required String name, required String myName}) {
    return userCollection
        .where("full_name", isGreaterThanOrEqualTo: name, isNotEqualTo: myName)
        .snapshots();
  }
}