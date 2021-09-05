import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/helper/timestamp_to_string_datetime.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/ui/widgets/custom_box_shadow.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';


class CustomMessageCardItem extends StatelessWidget {
  const CustomMessageCardItem({Key? key, this.chat, required this.isMyMessage})
      : super(key: key);

  final ChatModel? chat;
  final bool isMyMessage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          (isMyMessage) ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.6),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: (isMyMessage) ? BrandColor().defaultColor : NeutralColor().white,
              boxShadow: [customBoxShadow()],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular((isMyMessage) ? 16 : 0),
                bottomRight: Radius.circular((isMyMessage) ? 0 : 16),
                topRight: Radius.circular(16),
              )),
          child: Column(
            crossAxisAlignment: (isMyMessage)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                chat?.content ?? "",
                style: CustomTextStyle().body2.copyWith(
                    color: (isMyMessage)
                        ? NeutralColor().white
                        : NeutralColor().active),
              ),
              SizedBox(
                height: 4,
              ),
              Text(timestampToDatetime(chat?.timestamp),
                  style: CustomTextStyle().body2.copyWith(
                      color: (isMyMessage)
                          ? NeutralColor().white
                          : NeutralColor().disabled,
                      fontFamily: "Lato",
                      fontSize: 10,
                      fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      ],
    );
  }
}
