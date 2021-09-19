import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

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
        child: ListView.builder(
            itemCount: listChats.length,
            physics: BouncingScrollPhysics(),
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return Padding(
                  padding:
                      EdgeInsets.only(top: 12, bottom: (index == 0) ? 20 : 0),
                  child: SwipeTo(
                    onRightSwipe: () {
                      replyToMessage(listChats[index]);
                      focusNode.requestFocus();
                    },
                    child: CustomMessageCardItem(
                      userReceiver: widget.userReceiver,
                      chat: listChats[index],
                      isMyMessage:
                          listChats[index].uidSender == widget.userMe.uid,
                    ),
                  ));
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
