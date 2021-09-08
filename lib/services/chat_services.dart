import 'package:chat_app/models/api_return_value.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/chat_room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static final CollectionReference chatRoomsCollection =
      firebaseFirestore.collection("chat_rooms");
  // FIXME: Fix this -> Search chat room by user phone number
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
    } else {
      await chatRoomsCollection
          .doc(chatRoomId)
          .set(chatRoomModel.toJson())
          .then((value) {
        result = ApiReturnValue(value: true);
      }).catchError((onError) {
        result =
            ApiReturnValue(value: false, message: "Failed create room message");
      });
    }

    print("{ CREATE CHAT ROOM ${result.value}}");

    return result;
  }

  static Future<ApiReturnValue<bool>> sendMessage(
      {required String chatRoomId, required ChatModel chat}) async {
    late ApiReturnValue<bool> result;

    DocumentReference documentReference = chatRoomsCollection
        .doc(chatRoomId)
        .collection("chats")
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

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

  static Stream<QuerySnapshot<Object?>> getListMessages(String chatRoomId) {
    return chatRoomsCollection
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  static Future<ApiReturnValue<bool>> updateLastMessage(
      {required String chatRoomId, required ChatModel chat}) async {
    late ApiReturnValue<bool> result;
    await chatRoomsCollection.doc(chatRoomId).update({
      "last_message": chat.content,
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