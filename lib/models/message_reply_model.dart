import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/user_model.dart';

class MessageReplyModel {
  UserModel? userReply;
  String? timestampMessage;

  MessageReplyModel({this.timestampMessage, this.userReply});

  factory MessageReplyModel.fromJson(Map<String, dynamic> json) =>
      MessageReplyModel(
        userReply: (json['user'] == null) ? null : UserModel.fromJson(json['user']),
        timestampMessage: json['timestamp_message'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user": userReply?.toJson(),
        "timestamp_message": timestampMessage,
      };
}