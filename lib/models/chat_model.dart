import 'package:chat_app/models/message_reply_model.dart';

class ChatModel {
  MessageReplyModel? messageReply;
  String? message, timestamp, uidSender, uidReceiver;

  ChatModel(
      {this.message,
      this.timestamp,
      this.messageReply,
      this.uidSender,
      this.uidReceiver});

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
      messageReply: (json['message_replied'] == null)
          ? null
          : MessageReplyModel.fromJson(json['message_replied']),
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

  ChatModel copyWith({MessageReplyModel? messageReply}) => ChatModel(
      message: this.message,
      messageReply: messageReply,
      timestamp: this.timestamp,
      uidReceiver: this.uidReceiver,
      uidSender: this.uidSender);
}

final List<ChatModel> listChats = [
  ChatModel(
      message: "Test Dia Balas",
      messageReply: MessageReplyModel(
          message: ChatModel(
              message: "Test Saya Balas",
              messageReply: null,
              timestamp: "1631689790240",
              uidSender: "1",
              uidReceiver: "2")),
      timestamp: "1631689894652",
      uidSender: "2",
      uidReceiver: "1"),
  ChatModel(
      message: "Test Saya Balas",
      messageReply: MessageReplyModel(
          message: ChatModel(
              message: "Test Dia",
              messageReply: null,
              timestamp: "1631689786238",
              uidSender: "2",
              uidReceiver: "1"),
          timestampMessage: "1631689786238",
          userRepliedUid: "2"),
      timestamp: "1631689790240",
      uidSender: "1",
      uidReceiver: "2"),
  ChatModel(
      message: "Test Dia",
      messageReply: null,
      timestamp: "1631689786238",
      uidSender: "2",
      uidReceiver: "1"),
  ChatModel(
      message: "Test Saya",
      messageReply: null,
      timestamp: "1631689706233",
      uidSender: "1",
      uidReceiver: "2"),
];
