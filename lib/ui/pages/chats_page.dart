import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/ui/widgets/custom_app_bar_title.dart';
import 'package:chat_app/ui/widgets/custom_list_chat_card.dart';
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

  bool isSearching = false;

  void hideKeyboard() {
    setState(() {
      isSearching = false;
      searchController.text = "";
    });
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // hideKeyboard();
      },
      child: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: <Widget>[
          SliverAppBar(
            leadingWidth: 10,
            title: CustomAppBarTitle(title: "Chats"),
            floating: true,
            elevation: 0,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      prefixIcon: Icon(
                        Icons.search,
                        color: NeutralColor().disabled,
                      ),
                      controller: searchController,
                      hintText: "Search",
                      onTap: () {
                        setState(() {
                          isSearching = true;
                        });
                      },
                    ),
                  ),
                  (isSearching)
                      ? Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: GestureDetector(
                            onTap: () {
                              hideKeyboard();
                            },
                            child: Text("Cancel"),
                          ),
                        )
                      : SizedBox.shrink()
                ],
              ),
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
                        CustomListChatCard(),
                      ],
                    )),
          ]))
        ],
      ),
    );
  }
}
