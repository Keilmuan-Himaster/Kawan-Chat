class ChatModel {
  String? content, timestamp, receiverPhoneNumber, senderPhoneNumber;

  ChatModel(
      {this.senderPhoneNumber,
      this.content,
      this.receiverPhoneNumber,
      this.timestamp});

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
      senderPhoneNumber: json['sender_phone_number'],
      receiverPhoneNumber: json['receiver_phone_number'],
      timestamp: json['timestamp'],
      content: json['content']);

  Map<String, dynamic> toJson() => {
        "sender_phone_number": senderPhoneNumber,
        "receiver_phone_number": receiverPhoneNumber,
        "timestamp": timestamp,
        "content": content
      };
}

// final List<ChatModel> listChats = [
//   ChatModel(
//       receiverId: 30,
//       senderId: 1,
//       content: "Makan Bang",
//       timestamp: "1625949197055"),
//   ChatModel(
//       receiverId: 30,
//       senderId: 1,
//       content: "Makan Bang 2 kali",
//       timestamp: "1625949204372"),
//   ChatModel(
//       receiverId: 1,
//       senderId: 30,
//       content: "Makan Bang",
//       timestamp: "1625950341280"),
//   ChatModel(
//       receiverId: 30,
//       senderId: 1,
//       content: "Makan Bang",
//       timestamp: "1625950433135"),
//   ChatModel(
//       receiverId: 30,
//       senderId: 1,
//       content: "Makan Bang",
//       timestamp: "1625949197055"),
//   ChatModel(
//       receiverId: 30,
//       senderId: 1,
//       content: "Makan Bang 2 kali",
//       timestamp: "1625949204372"),
//   ChatModel(
//       receiverId: 1,
//       senderId: 30,
//       content: "Makan Bang",
//       timestamp: "1625950341280"),
//   ChatModel(
//       receiverId: 30,
//       senderId: 1,
//       content: "Makan Bang",
//       timestamp: "1625950433135"),
//   ChatModel(
//       receiverId: 30,
//       senderId: 1,
//       content: "Makan Bang",
//       timestamp: "1625949197055"),
//   ChatModel(
//       receiverId: 30,
//       senderId: 1,
//       content: "Makan Bang 2 kali",
//       timestamp: "1625949204372"),
//   ChatModel(
//       receiverId: 1,
//       senderId: 30,
//       content: "Makan Bang",
//       timestamp: "1625950341280"),
//   ChatModel(
//       receiverId: 30,
//       senderId: 1,
//       content: "Makan Bang",
//       timestamp: "1625950433135"),
//   ChatModel(
//       receiverId: 30,
//       senderId: 1,
//       content: "Makan Bang",
//       timestamp: "1625949197055"),
//   ChatModel(
//       receiverId: 30,
//       senderId: 1,
//       content: "Makan Bang 2 kali",
//       timestamp: "1625949204372"),
//   ChatModel(
//       receiverId: 1,
//       senderId: 30,
//       content: "Makan Bang",
//       timestamp: "1625950341280"),
//   ChatModel(
//       receiverId: 30,
//       senderId: 1,
//       content: "Makan Bang",
//       timestamp: "1625950433135"),
// ];
