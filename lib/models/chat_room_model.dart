import 'package:chat_app/models/user_model.dart';

class ChatRoomModel {
  List<UserModel>? users;
  String? lastMessage, timestamp;

  ChatRoomModel({this.lastMessage, this.timestamp, this.users});

  factory ChatRoomModel.fromjson(Map<String, dynamic> json) => ChatRoomModel(
      users: (json['users'] == null)
          ? null
          : (json['users'] as Iterable)
              .map((e) => UserModel.fromJson(e))
              .toList(),
      lastMessage: json['last_message'] ?? "",
      timestamp: json['timestamp'] ?? "");

  Map<String, dynamic> toJson() => {
        "users": users?.map((e) => e.toJson()).toList(),
        "last_message": lastMessage,
        "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      };
}
