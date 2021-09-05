import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/ui/widgets/custom_app_bar.dart';
import 'package:chat_app/ui/widgets/custom_message_card_item.dart';
import 'package:chat_app/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class DetailChatScreen extends StatefulWidget {
  const DetailChatScreen({Key? key}) : super(key: key);

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
        child: ListView.builder(
            itemCount: listChats.length,
            physics: BouncingScrollPhysics(),
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return Padding(
                  padding:
                      EdgeInsets.only(top: 12, bottom: (index == 0) ? 20 : 0),
                  child: CustomMessageCardItem(
                    chat: listChats[index],
                    isMyMessage: listChats[index].senderId == myId,
                  ));
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
            onTap: () {},
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
