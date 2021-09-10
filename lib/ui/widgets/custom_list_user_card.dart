import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/helper/full_name.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomListUserCard extends StatelessWidget {
  const CustomListUserCard({
    Key? key,
    this.onTap,
    required this.user,
  }) : super(key: key);

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
            Image.asset(
              "assets/examples/avatar_1.png",
              height: 48,
              width: 48,
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName(
                        firstName: user.firstName, lastName: user.lastName),
                    style: CustomTextStyle()
                        .body1
                        .copyWith(color: NeutralColor().active),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "${user.phoneNumber}",
                    style: CustomTextStyle()
                        .metaData1
                        .copyWith(color: NeutralColor().disabled),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
