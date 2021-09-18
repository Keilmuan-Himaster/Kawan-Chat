import 'package:flutter/material.dart';

import '../../config/custom_color.dart';
import '../../config/custom_text_style.dart';
import '../../config/size_config.dart';
import '../../models/user_model.dart';
import 'custom_profile_card.dart';

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