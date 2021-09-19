import 'package:chat_app/models/api_return_value.dart';
import 'package:chat_app/models/chat_room_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  // TODO: Day 3.2 - Inisialisasi Firebase Firestore
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static final CollectionReference chatRoomsCollection =
      firebaseFirestore.collection("chat_rooms");

  // TODO: Day 3.3 - Dapatkan list chats room
  static Stream<QuerySnapshot<Object?>> getChatRooms(
      {required UserModel user}) {
    return chatRoomsCollection
        .doc(user.uid)
        .collection("chat_rooms")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  // TODO: Day 3.4 - Bikin Chat Room
  static Future<ApiReturnValue<bool>> createChatRoom(
      {required UserModel user, required ChatRoomModel chatRoomModel}) async {
    ApiReturnValue<bool> result =
        ApiReturnValue(value: false, message: "Failed create room message");
    DocumentSnapshot snapshot = await chatRoomsCollection
        .doc(user.uid)
        .collection("chat_rooms")
        .doc(chatRoomModel.userReceiver?.uid)
        .get();

    if (snapshot.exists) {
      result = ApiReturnValue(value: true);
    } else {
      await chatRoomsCollection
          .doc(user.uid)
          .collection("chat_rooms")
          .doc(chatRoomModel.userReceiver?.uid)
          .set(chatRoomModel.toJson())
          .then((value) {
        result = ApiReturnValue(value: true);
      }).catchError((onError) {
        print("{ ERROR CREATE CHAT ROOM $onError }");
        result =
            ApiReturnValue(value: false, message: "Failed create room message");
      });
    }

    print("{ CREATE CHAT ROOM ${result.value}}");

    return result;
  }

  // TODO: Day 4 - Dapatkan List messages

  // TODO: Day 4 - Kirim Chat

  // TODO: Day 4 - Update last message
}
