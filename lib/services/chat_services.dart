import 'package:chat_app/models/api_return_value.dart';
import 'package:chat_app/models/chat_room_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static final CollectionReference chatRoomsCollection =
      _firebaseFirestore.collection("chat_rooms");

  static Stream<QuerySnapshot<Object?>> getChatRooms(String myPhoneNumber) {
    return chatRoomsCollection
        .orderBy("timestamp", descending: true)
        .where("phone_number", arrayContains: myPhoneNumber)
        .snapshots();
  }

  static Future<ApiReturnValue<bool>> createChatRoom(
      {required String chatRoomId,
      required ChatRoomModel chatRoomModel}) async {
    ApiReturnValue<bool> result =
        ApiReturnValue(value: false, message: "Failed create room message");
    DocumentSnapshot snapshot = await chatRoomsCollection.doc(chatRoomId).get();

    if (snapshot.exists) {
      result = ApiReturnValue(value: true);
      print("Exists");
    } else {
      await chatRoomsCollection
          .doc(chatRoomId)
          .set(chatRoomModel.toJson())
          .then((value) {
        result = ApiReturnValue(value: true);
      }).catchError((onError) {
        print("errorss $onError");
        result =
            ApiReturnValue(value: false, message: "Failed create room message");
      });
    }

    print("{ CREATE CHAT ROOM ${result.value}}");

    return result;
  }
}
