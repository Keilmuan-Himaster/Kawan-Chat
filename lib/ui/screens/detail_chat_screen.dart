import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/ui/widgets/custom_app_bar.dart';
import 'package:chat_app/ui/widgets/custom_message_card_item.dart';
import 'package:chat_app/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

class DetailChatScreen extends StatefulWidget {
  const DetailChatScreen({Key? key}) : super(key: key);

  @override
  _DetailChatScreenState createState() => _DetailChatScreenState();
}

class _DetailChatScreenState extends State<DetailChatScreen> {
  TextEditingController messageController = TextEditingController();
  final focusNode = FocusNode();

  int myId = 1;

  // TODO: Day 4
  bool replyMessage = false;

  void hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        label: "Athalia Putri",
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
                      replyToMessage();
                      focusNode.requestFocus();
                    },
                    child: CustomMessageCardItem(
                      chat: listChats[index],
                      isMyMessage: listChats[index].senderId == myId,
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
          (replyMessage)
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
                                  "You",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                ),
                                Text("Makan bang",
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
                onTap: () {},
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

  void replyToMessage() {
    setState(() {
      replyMessage = true;
    });
  }

  void cancelReply() {
    setState(() {
      replyMessage = false;
    });
  }
}
