import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/cubit/cubit.dart';
import 'package:chat_app/helper/full_name.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/ui/widgets/custom_app_bar_title.dart';
import 'package:chat_app/ui/widgets/custom_profile_card.dart';
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
                return buildProfileCard(context: context,user: state.user);
              } else if (state is UserLoadingFailed) {
                return buildProfileCard(context: context,);
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
            context: context,
            iconName: "icon_person_black.png",
            label: "Account",
          ),
          buildMoreListCard(
            context: context,
            iconName: "icon_chat.png",
            label: "Chats",
          ),
          Divider(
            color: Theme.of(context).accentColor,
          ),
          buildMoreListCard(
            context: context,
            iconName: "icon_apperance.png",
            label: "Apperance",
          ),
          buildMoreListCard(
            context: context,
            iconName: "icon_notification.png",
            label: "Notification",
          ),
          buildMoreListCard(
            context: context,
            iconName: "icon_privacy.png",
            label: "Privacy",
          ),
          buildMoreListCard(
            context: context,
            iconName: "icon_data_usage.png",
            label: "Data Usage",
          ),
          Divider(
            color: Theme.of(context).accentColor,
          ),
          buildMoreListCard(
            context: context,
            iconName: "icon_help.png",
            label: "Help",
          ),
          buildMoreListCard(
            context: context,
            iconName: "icon_email.png",
            label: "Invite Your Friends",
          ),
        ])),
      ],
    );
  }

  InkWell buildProfileCard({UserModel? user, required BuildContext context}) {
    return buildContainerCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomProfileCard(
                  height: 50,
                  padding: 13,
                  imageUrl: user?.imageUrl,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.fullName ?? "",
                      style: Theme.of(context).textTheme.bodyText1
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
            buildIconNext(context),
          ],
        ),
        onTap: () {});
  }

  InkWell buildMoreListCard(
      {required String iconName,
      required String label,
      Function? onTap,
      required BuildContext context}) {
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
                  color: Theme.of(context).iconTheme.color,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            buildIconNext(context),
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

  Icon buildIconNext(BuildContext context) => Icon(
        Icons.chevron_right,
        color: Theme.of(context).iconTheme.color
      );
}
