import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/cubit/cubit.dart';
import 'package:chat_app/helper/full_name.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/ui/widgets/custom_app_bar_title.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          elevation: 0,
          leadingWidth: 10,
          title: CustomAppBarTitle(
            title: "More",
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: 8,
          ),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                return buildProfileCard(user: state.user);
              } else if (state is UserLoadingFailed) {
                return buildProfileCard();
              } else {
                return SizedBox(
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
          buildMoreListCard(
            iconName: "icon_person_black.png",
            label: "Account",
          ),
          buildMoreListCard(
            iconName: "icon_chat.png",
            label: "Chats",
          ),
          Divider(
            color: NeutralColor().line,
          ),
          buildMoreListCard(
            iconName: "icon_apperance.png",
            label: "Apperance",
          ),
          buildMoreListCard(
            iconName: "icon_notification.png",
            label: "Notification",
          ),
          buildMoreListCard(
            iconName: "icon_privacy.png",
            label: "Privacy",
          ),
          buildMoreListCard(
            iconName: "icon_data_usage.png",
            label: "Data Usage",
          ),
          Divider(
            color: NeutralColor().line,
          ),
          buildMoreListCard(
            iconName: "icon_help.png",
            label: "Help",
          ),
          buildMoreListCard(
            iconName: "icon_email.png",
            label: "Invite Your Friends",
          ),
        ])),
      ],
    );
  }

  InkWell buildProfileCard({UserModel? user}) {
    return buildContainerCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          color: NeutralColor().line, shape: BoxShape.circle),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: FadeInImage(
                          placeholder:
                              AssetImage("assets/icons/icon_person_black.png"),
                          image: NetworkImage(user?.imageUrl ?? ""),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: NeutralColor().line.withOpacity(0),
                          shape: BoxShape.circle),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: FadeInImage(
                          placeholder: AssetImage(""),
                          image: NetworkImage(user?.imageUrl ?? "",),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.fullName ?? "",
                      style: CustomTextStyle()
                          .body1
                          .copyWith(color: NeutralColor().active),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      user?.phoneNumber ?? "-",
                      style: CustomTextStyle()
                          .metaData1
                          .copyWith(color: NeutralColor().disabled),
                    ),
                  ],
                )
              ],
            ),
            buildIconNext(),
          ],
        ),
        onTap: () {});
  }

  InkWell buildMoreListCard(
      {required String iconName, required String label, Function? onTap}) {
    return buildContainerCard(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageIcon(
                  AssetImage(
                    "assets/icons/$iconName",
                  ),
                  size: 24,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  label,
                  style: CustomTextStyle()
                      .body1
                      .copyWith(color: NeutralColor().active),
                ),
              ],
            ),
            buildIconNext(),
          ],
        ));
  }

  InkWell buildContainerCard({required Widget child, Function? onTap}) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 8, horizontal: SizeConfig.defaultMargin),
          child: child),
    );
  }

  Icon buildIconNext() => Icon(
        Icons.chevron_right,
        color: NeutralColor().active,
      );
}
