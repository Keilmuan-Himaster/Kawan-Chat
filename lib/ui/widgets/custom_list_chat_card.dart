import 'package:flutter/material.dart';

import '../../config/custom_color.dart';
import '../../config/custom_text_style.dart';
import '../../config/size_config.dart';
import '../../models/chat_room_model.dart';
import '../../utils/utils.dart';
import 'custom_profile_card.dart';

class CustomListChatCard extends StatelessWidget {
  const CustomListChatCard({
    Key? key,
    this.onTap,
    required this.chatRoom
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
            Row(
              children: [
                CustomProfileCard(
                  height: 48,
                  padding: 12,
                  imageUrl:chatRoom.userReceiver?.imageUrl,
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatRoom.userReceiver?.fullName ?? "-",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                     chatRoom.lastMessage ?? "-",
                      style: CustomTextStyle.metaData1
                          .copyWith(color: NeutralColor.disabled),
                    ),
                  ],
                )
              ],
            ),
            Text(
              Utils.timestampToDatetime(chatRoom.timestamp),
              style: CustomTextStyle.metaData1
                  .copyWith(color: NeutralColor.disabled),
            ),
          ],
        ),
      ),
    );
  }
}
