import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/ui/screens/detail_chat_screen.dart';
import 'package:chat_app/ui/widgets/custom_profile_card.dart';
import 'package:chat_app/utils/custom_navigator.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomListUserCard extends StatelessWidget {
  const CustomListUserCard({Key? key, this.onTap, required this.user})
      : super(key: key);

  final Function? onTap;
  final UserModel user;

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
          children: [
            CustomProfileCard(
              height: 48,
              padding: 12,
              imageUrl: user.imageUrl,
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  user.phoneNumber,
                  style: CustomTextStyle
                      .metaData1
                      .copyWith(color: NeutralColor.disabled),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
