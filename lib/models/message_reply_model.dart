import 'chat_model.dart';

class MessageReplyModel {
  String? userRepliedUid, timestampMessage;
  ChatModel? message;

  MessageReplyModel({this.timestampMessage, this.userRepliedUid, this.message});

  factory MessageReplyModel.fromJson(Map<String, dynamic> json) =>
      MessageReplyModel(
        userRepliedUid: json["user_replied_uid"],
        message: (json['message'] == null) ? null : ChatModel.fromJson(json['message']),
        timestampMessage: json['timestamp_message'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user_replied_uid": userRepliedUid,
        "timestamp_message": timestampMessage,
        "message": message?.copyWith(
          messageReply: null
        ).toJson()
      };
}
