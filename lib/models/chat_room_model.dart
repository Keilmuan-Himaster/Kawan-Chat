import 'package:chat_app/models/user_model.dart';

class ChatRoomModel {
  UserModel? userReceiver;
  String? lastMessage, timestamp;

  ChatRoomModel({this.timestamp, this.userReceiver, this.lastMessage});

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) => ChatRoomModel(
      userReceiver: (json['user_receiver'] == null)
          ? null
          : UserModel.fromJson(json['user_receiver']),
      lastMessage: json['last_message'] ?? "",
      timestamp: json['timestamp'] ?? "");

  Map<String, dynamic> toJson() => {
        "user_receiver": userReceiver?.toJson(),
        "last_message": lastMessage,
        "timestamp":
            timestamp ?? DateTime.now().millisecondsSinceEpoch.toString(),
      };
}

final ChatRoomModel chatRoomMock = ChatRoomModel(
    lastMessage: "Makan Bang",
    timestamp: "1631689894652",
    userReceiver: UserModel(
        uid: "2",
        phoneNumber: "0909090",
        firstName: "",
        fullName: "Penerima Pesan",
        lastName: "Pesan",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/chat-app-18b71.appspot.com/o/images%2Fimage_picker7848020227438484439.jpg?alt=media&token=9c0f2185-39f7-4e11-916b-4ac52e692cf8"));
