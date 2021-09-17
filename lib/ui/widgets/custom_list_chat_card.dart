import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/ui/screens/detail_chat_screen.dart';
import 'package:chat_app/utils/custom_navigator.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomListChatCard extends StatelessWidget {
  const CustomListChatCard({
    Key? key, this.onTap,
  }) : super(key: key);

  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomNavigator().startScreen(context, DetailChatScreen());
        if (onTap != null) {
          onTap!();
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 6,
            horizontal: SizeConfig.defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/examples/avatar_1.png",
                  height: 48,
                  width: 48,
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Athalia Putri",
                      style: CustomTextStyle
                          .body1
                          .copyWith(
                              color: NeutralColor.active),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Good morning, did you sleep well?",
                      style: CustomTextStyle
                          .metaData1
                          .copyWith(
                              color:
                                  NeutralColor.disabled),
                    ),
                  ],
                )
              ],
            ),
            Text(
              "16.00",
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
