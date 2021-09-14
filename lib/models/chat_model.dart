import 'package:chat_app/models/chat_room_model.dart';
import 'package:chat_app/models/message_reply_model.dart';
import 'package:chat_app/models/user_model.dart';

class ChatModel {
  MessageReplyModel? messageReply;
  String? message, timestamp, uidSender, uidReceiver;

  ChatModel({this.message, this.timestamp, this.messageReply, this.uidSender, this.uidReceiver});

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
      messageReply: (json['message_replied'] == null) ? null : MessageReplyModel.fromJson(json['message_replied']),
      message: json['message'] ?? "",
      uidReceiver: json['uid_receiver'],
      uidSender: json['uid_sender'],
      timestamp: json['timestamp'] ?? "");

  Map<String, dynamic> toJson() => {
        "message_replied": messageReply?.toJson(),
        "message": message,
        "uid_sender": uidSender,
        "uid_receiver": uidReceiver,
        "timestamp": timestamp,
      };
}