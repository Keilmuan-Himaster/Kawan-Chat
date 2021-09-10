import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/user_model.dart';

class MessageReplyModel {
  UserModel? userReply;
  ChatModel? message;

  MessageReplyModel({this.message, this.userReply});

  factory MessageReplyModel.fromJson(Map<String, dynamic> json) =>
      MessageReplyModel(
        userReply: json['user_reply'],
        message: json['message'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user_reply": userReply?.toJson(),
        "message": message,
      };
}