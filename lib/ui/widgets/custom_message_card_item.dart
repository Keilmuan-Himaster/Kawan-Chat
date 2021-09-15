import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/helper/timestamp_to_string_datetime.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/ui/widgets/custom_box_shadow.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomMessageCardItem extends StatelessWidget {
  const CustomMessageCardItem(
      {Key? key, this.chat, required this.isMyMessage, this.userReciever})
      : super(key: key);

  final ChatModel? chat;
  final bool isMyMessage;
  final UserModel? userReciever;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          (isMyMessage) ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.6),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: (isMyMessage)
                  ? Theme.of(context).cardColor
                  : Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular((isMyMessage) ? 16 : 0),
                bottomRight: Radius.circular((isMyMessage) ? 0 : 16),
                topRight: Radius.circular(16),
              )),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: (isMyMessage && chat?.messageReply == null)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                (chat?.messageReply != null)
                    ? IntrinsicHeight(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).splashColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Container(
                                  width: 4,
                                  decoration: BoxDecoration(
                                    color: (isMyMessage)
                                        ? Theme.of(context).iconTheme.color
                                        : Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      bottomLeft: Radius.circular(4),
                                    ),
                                  )),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (isMyMessage)
                                            ? "You"
                                            : userReciever?.fullName ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      ),
                                      Text(
                                          chat?.messageReply?.message
                                                  ?.message ??
                                              "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(fontSize: 10)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: (isMyMessage)
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat?.message ?? "",
                        style: CustomTextStyle.body2.copyWith(
                            color: (isMyMessage)
                                ? NeutralColor.white
                                : Theme.of(context).iconTheme.color),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(timestampToDatetime(chat?.timestamp),
                          style: CustomTextStyle.body2.copyWith(
                              color: (isMyMessage)
                                  ? NeutralColor.white
                                  : NeutralColor.disabled,
                              fontFamily: "Lato",
                              fontSize: 10,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
