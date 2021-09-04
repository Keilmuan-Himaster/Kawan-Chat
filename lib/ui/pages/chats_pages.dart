import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/ui/widgets/custom_app_bar_title.dart';
import 'package:chat_app/ui/widgets/custom_text_field.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: CustomAppBarTitle(title: "Chats"),
          floating: true,
          elevation: 0,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
            child: CustomTextField(
                prefixIcon: Icon(
                  Icons.search,
                  color: NeutralColor().disabled,
                ),
                controller: searchController,
                hintText: "Search"),
          ),
          SizedBox(
            height: 16,
          ),
          ...List.generate(
              20,
              (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (index == 0)
                          ? SizedBox.shrink()
                          : Divider(
                              color: NeutralColor().line,
                              height: 0,
                            ),
                      InkWell(
                        onTap: () {},
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
                                        style: CustomTextStyle().body1.copyWith(
                                            color: NeutralColor().active),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Good morning, did you sleep well?",
                                        style: CustomTextStyle()
                                            .metaData1
                                            .copyWith(
                                                color: NeutralColor().disabled),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                "16.00",
                                style: CustomTextStyle()
                                    .metaData1
                                    .copyWith(color: NeutralColor().disabled),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
        ]))
      ],
    );
  }
}
