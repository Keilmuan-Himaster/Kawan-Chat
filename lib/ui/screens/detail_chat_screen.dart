import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/services/chat_services.dart';
import 'package:chat_app/ui/widgets/custom_app_bar.dart';
import 'package:chat_app/ui/widgets/custom_message_card_item.dart';
import 'package:chat_app/ui/widgets/custom_text_field.dart';
import 'package:chat_app/ui/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/models/api_return_value.dart';

class DetailChatScreen extends StatefulWidget {
  const DetailChatScreen(
      {Key? key,
      required this.chatRoomId,
      required this.myPhoneNumber,
      required this.receiverPhoneNumber})
      : super(key: key);

  final String chatRoomId, myPhoneNumber, receiverPhoneNumber;

  @override
  _DetailChatScreenState createState() => _DetailChatScreenState();
}

class _DetailChatScreenState extends State<DetailChatScreen> {
  TextEditingController messageController = TextEditingController();

  int myId = 1;

  void hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        label: "Athalia Putri",
      ),
      backgroundColor: NeutralColor().offWhite,
      body: buildBody(),
    );
  }

  SafeArea buildBody() {
    return SafeArea(
      top: false,
      child: GestureDetector(
          onTap: () => hideKeyboard(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildListMessage(),
              buildButtonSendMessage(),
            ],
          )),
    );
  }

  Flexible buildListMessage() {
    return Flexible(
        child: StreamBuilder<QuerySnapshot>(
            stream: ChatServices.getListMessages(widget.chatRoomId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    physics: BouncingScrollPhysics(),
                    reverse: true,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.only(
                              top: 12, bottom: (index == 0) ? 20 : 0),
                          child: CustomMessageCardItem(
                            chat: ChatModel.fromJson(snapshot.data?.docs[index]
                                .data() as Map<String, dynamic>),
                            isMyMessage: ChatModel.fromJson(
                                        snapshot.data?.docs[index].data()
                                            as Map<String, dynamic>)
                                    .senderPhoneNumber ==
                                widget.myPhoneNumber,
                          ));
                    });
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                // TODO: Handle this error
                return Container();
              }
            }));
  }

  Container buildButtonSendMessage() {
    return Container(
      color: NeutralColor().white,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.add,
              color: NeutralColor().disabled,
              size: 20,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: CustomTextField(controller: messageController, hintText: ""),
          ),
          SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTap: () async {
              if (messageController.text.trim() != "") {
                ApiReturnValue<bool> result = await ChatServices.sendMessage(
                    chatRoomId: widget.chatRoomId,
                    chat: ChatModel(
                        content: messageController.text,
                        timestamp:
                            DateTime.now().millisecondsSinceEpoch.toString(),
                        senderPhoneNumber: widget.myPhoneNumber,
                        receiverPhoneNumber: widget.receiverPhoneNumber));

                if (result.value!) {
                  ChatServices.updateLastMessage(
                      chatRoomId: widget.chatRoomId,
                      chat: ChatModel(
                          content: messageController.text,
                          timestamp: DateTime.now()
                              .millisecondsSinceEpoch
                              .toString()));

                  messageController.clear();
                } else {
                  CustomToast.showToast(message: result.message);
                }
              }
            },
            child: ImageIcon(
              AssetImage("assets/icons/icon_send_message.png"),
              color: BrandColor().defaultColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
