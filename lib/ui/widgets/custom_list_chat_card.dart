import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/ui/screens/detail_chat_screen.dart';
import 'package:chat_app/ui/widgets/custom_profile_card.dart';
import 'package:chat_app/utils/screen_navigator.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';

// TODO: Day 3
class CustomListChatCard extends StatelessWidget {
  const CustomListChatCard({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScreenNavigator.startScreen(context, DetailChatScreen());
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
                  imageUrl: "",
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Athalia Putri",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Good morning, did you sleep well?",
                      style: CustomTextStyle.metaData1
                          .copyWith(color: NeutralColor.disabled),
                    ),
                  ],
                )
              ],
            ),
            Text(
              Utils.timestampToDatetime("1631689790240"),
              style: CustomTextStyle.metaData1
                  .copyWith(color: NeutralColor.disabled),
            ),
          ],
        ),
      ),
    );
  }
}
