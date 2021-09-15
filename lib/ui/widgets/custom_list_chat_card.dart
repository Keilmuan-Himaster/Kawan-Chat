import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/models/chat_room_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/ui/widgets/custom_profile_card.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomListChatCard extends StatelessWidget {
  const CustomListChatCard({
    Key? key,
    this.onTap,
    required this.chatRoom,
  }) : super(key: key);

  final Function? onTap;
  final ChatRoomModel chatRoom;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 6, horizontal: SizeConfig.defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  CustomProfileCard(
                    height: 48,
                    padding: 12,
                    imageUrl: chatRoom.userReceiver?.imageUrl,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chatRoom.userReceiver?.fullName ?? "",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          chatRoom.lastMessage ?? "-",
                          style: CustomTextStyle
                              .metaData1
                              .copyWith(color: NeutralColor.disabled),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Text(
             Utils.timestampToDatetime(chatRoom.timestamp),
              style: CustomTextStyle
                  .metaData1
                  .copyWith(color: NeutralColor.disabled),
            ),
          ],
        ),
      ),
    );
  }
}
