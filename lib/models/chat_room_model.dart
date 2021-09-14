import 'package:chat_app/models/user_model.dart';

class ChatRoomModel {
  UserModel? userReceiver;
  String? lastMessage, timestamp;

  ChatRoomModel({this.lastMessage, this.timestamp, this.userReceiver});

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) => ChatRoomModel(
      userReceiver: (json['user_receiver'] == null) ? null : UserModel.fromJson(json['user_receiver']),
      lastMessage: json['last_message'] ?? "",
      timestamp: json['timestamp'] ?? "");

  Map<String, dynamic> toJson() => {
        "user_receiver": userReceiver?.toJson(),
        "last_message": lastMessage,
        "timestamp": timestamp ?? DateTime.now().millisecondsSinceEpoch.toString(),
      };
}
