import 'package:chat_app/models/api_return_value.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/chat_room_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static final CollectionReference chatRoomsCollection =
      firebaseFirestore.collection("chat_rooms");
  // FIXME: Fix this -> Search chat room by user phone number
  static Stream<QuerySnapshot<Object?>> getChatRooms(
      {required UserModel user}) {
    return chatRoomsCollection
        .doc(user.uid)
        .collection("chat_rooms")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

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

  static Future<ApiReturnValue<bool>> sendMessage(
      {required UserModel userMe,
      required UserModel userReceiver,
      required ChatModel chat}) async {
    late ApiReturnValue<bool> result;

    DocumentReference documentReference = chatRoomsCollection
        .doc(userMe.uid)
        .collection("chat_rooms")
        .doc(userReceiver.uid)
        .collection("chats")
        .doc(chat.timestamp);

    await firebaseFirestore
        .runTransaction((transaction) async =>
            transaction.set(documentReference, chat.toJson()))
        .then((value) {
      result = ApiReturnValue(
        value: true,
      );
    }).catchError((onError) {
      result = ApiReturnValue(value: false, message: "Failed send message");
    });

    print("{ SEND MESSAGE ${result.value} }");

    return result;
  }

  static Stream<QuerySnapshot<Object?>> getListMessages(
      {required UserModel userMe, required UserModel userReceiver}) {
    return chatRoomsCollection
        .doc(userMe.uid)
        .collection("chat_rooms")
        .doc(userReceiver.uid)
        .collection("chats")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  static Future<ApiReturnValue<bool>> updateLastMessage(
      {required UserModel userMe,
      required UserModel userReceiver,
      required ChatModel chat}) async {
    late ApiReturnValue<bool> result;
    await chatRoomsCollection
        .doc(userMe.uid)
        .collection("chat_rooms")
        .doc(userReceiver.uid)
        .update({
      "last_message": chat.message,
      "timestamp": chat.timestamp
    }).then((value) {
      result = ApiReturnValue(value: true);
    }).catchError((onError) {
      result =
          ApiReturnValue(value: false, message: "Failed update last message");
    });

    print("{ UPDATE LAST MESSAGE ${result.value} }");

    return result;
  }
}
