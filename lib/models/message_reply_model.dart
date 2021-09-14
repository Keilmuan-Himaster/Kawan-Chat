import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/user_model.dart';

class MessageReplyModel {
  String? userRepliedUid, timestampMessage;

  MessageReplyModel({this.timestampMessage, this.userRepliedUid});

  factory MessageReplyModel.fromJson(Map<String, dynamic> json) =>
      MessageReplyModel(
        userRepliedUid: json["user_replied_uid"],
        timestampMessage: json['timestamp_message'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user_replied_uid": userRepliedUid,
        "timestamp_message": timestampMessage,
      };
}