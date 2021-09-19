import 'package:chat_app/config/size_config.dart';
import 'package:chat_app/models/api_return_value.dart';
import 'package:chat_app/models/message_reply_model.dart';
import 'package:chat_app/services/chat_services.dart';
import 'package:chat_app/ui/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../config/custom_color.dart';
import '../../models/chat_model.dart';
import '../../models/user_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_message_card_item.dart';
import '../widgets/custom_text_field.dart';

class DetailChatScreen extends StatefulWidget {
  const DetailChatScreen({
    Key? key,
    required this.userMe,
    required this.userReceiver,
  }) : super(key: key);

  final UserModel userMe, userReceiver;

  @override
  _DetailChatScreenState createState() => _DetailChatScreenState();
}

class _DetailChatScreenState extends State<DetailChatScreen> {
  TextEditingController messageController = TextEditingController();
  final focusNode = FocusNode();

  ChatModel? replyMessage;

  void hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        label: widget.userReceiver.fullName,
      ),
      backgroundColor: Theme.of(context).accentColor,
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
        // TODO: Day 4.4 - Menampilkan List Chat
        child: StreamBuilder<QuerySnapshot>(
            stream: ChatServices.getListMessages(
                userMe: widget.userMe, userReceiver: widget.userReceiver),
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
                          child: SwipeTo(
                            onRightSwipe: () {
                              replyToMessage(ChatModel.fromJson(
                                  snapshot.data?.docs[index].data()
                                      as Map<String, dynamic>));
                              focusNode.requestFocus();
                            },
                            child: CustomMessageCardItem(
                              userReceiver: widget.userReceiver,
                              chat: ChatModel.fromJson(
                                  snapshot.data?.docs[index].data()
                                      as Map<String, dynamic>),
                              isMyMessage: ChatModel.fromJson(
                                          snapshot.data?.docs[index].data()
                                              as Map<String, dynamic>)
                                      .uidSender ==
                                  widget.userMe.uid,
                            ),
                          ));
                    });
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: SizeConfig.screenHeight * 0.8,
                  child: Center(
                      child: CustomDialog.showCircularProgressIndicator()),
                );
              } else {
                // TODO: Handle this error
                return Container();
              }
            }));
  }

  Container buildButtonSendMessage() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Column(
        children: [
          (replyMessage != null)
              ? Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: BrandColor.defaultColor,
                                      width: 4))),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (replyMessage?.uidSender == widget.userMe.uid)
                                      ? "You"
                                      : widget.userReceiver.fullName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                ),
                                Text(replyMessage!.message ?? "",
                                    style:
                                        Theme.of(context).textTheme.bodyText2)
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => cancelReply(),
                            child: Icon(
                              Icons.close_outlined,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : SizedBox(),
          Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: CustomTextField(
                    focusNode: focusNode,
                    controller: messageController,
                    hintText: ""),
              ),
              SizedBox(
                width: 12,
              ),
              GestureDetector(
                onTap: () async {
                  //TODO: Day 4.5 Button send message
                  if (messageController.text.trim() != "") {
                    DateTime date = DateTime.now();
                    // write message for me as sender
                    ApiReturnValue<bool> result =
                        await ChatServices.sendMessage(
                            userMe: widget.userMe,
                            userReceiver: widget.userReceiver,
                            chat: ChatModel(
                                message: messageController.text,
                                timestamp:
                                    date.millisecondsSinceEpoch.toString(),
                                messageReply: (replyMessage == null)
                                    ? null
                                    : MessageReplyModel(
                                        message: replyMessage,
                                        timestampMessage:
                                            replyMessage?.timestamp,
                                        userRepliedUid:
                                            (replyMessage?.uidSender ==
                                                    widget.userMe.uid)
                                                ? widget.userMe.uid
                                                : widget.userReceiver.uid),
                                uidSender: widget.userMe.uid,
                                uidReceiver: widget.userReceiver.uid));

                    // write for receiver
                    ChatServices.sendMessage(
                        userMe: widget.userReceiver,
                        userReceiver: widget.userMe,
                        chat: ChatModel(
                            message: messageController.text,
                            timestamp: date.millisecondsSinceEpoch.toString(),
                            messageReply: (replyMessage == null)
                                ? null
                                : MessageReplyModel(
                                    message: replyMessage,
                                    timestampMessage: replyMessage?.timestamp,
                                    userRepliedUid: (replyMessage?.uidSender ==
                                            widget.userMe.uid)
                                        ? widget.userMe.uid
                                        : widget.userReceiver.uid),
                            uidSender: widget.userMe.uid,
                            uidReceiver: widget.userReceiver.uid));

                    cancelReply();

                    if (result.value!) {
                      // write for me as sender
                      ChatServices.updateLastMessage(
                          userMe: widget.userMe,
                          userReceiver: widget.userReceiver,
                          chat: ChatModel(
                              message: messageController.text,
                              timestamp:
                                  date.millisecondsSinceEpoch.toString()));

                      // write for receiver
                      ChatServices.updateLastMessage(
                          userMe: widget.userReceiver,
                          userReceiver: widget.userMe,
                          chat: ChatModel(
                              message: messageController.text,
                              timestamp:
                                  date.millisecondsSinceEpoch.toString()));

                      messageController.clear();
                    } else {
                      CustomDialog.showToast(message: result.message);
                    }
                  }
                },
                child: ImageIcon(
                  AssetImage("assets/icons/icon_send_message.png"),
                  color: BrandColor.defaultColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void replyToMessage(ChatModel chat) {
    setState(() {
      replyMessage = chat;
    });
  }

  void cancelReply() {
    setState(() {
      replyMessage = null;
    });
  }
}
