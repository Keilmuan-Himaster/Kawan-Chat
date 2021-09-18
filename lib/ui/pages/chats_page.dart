import 'package:chat_app/cubit/cubits.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/custom_color.dart';
import '../../config/size_config.dart';
import '../../models/chat_room_model.dart';
import '../../models/user_model.dart';
import '../../utils/screen_navigator.dart';
import '../screens/detail_chat_screen.dart';
import '../widgets/custom_app_bar_title.dart';
import '../widgets/custom_list_chat_card.dart';
import '../widgets/custom_text_field.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  TextEditingController searchController = TextEditingController();

  bool isSearching = false;

  // TODO: Day 3 - Deklarasi variabel UserStream untuk pencarian user

  @override
  void initState() {
    // TODO: Day 2.15 - Dapatkan detail User detail
    if (context.read<UserCubit>().state is UserInitial) {
      context
          .read<UserCubit>()
          .getUserDetail(FirebaseAuth.instance.currentUser!.uid);
    }
    super.initState();
  }

  void hideKeyboard() {
    setState(() {
      isSearching = false;
      searchController.text = "";
    });
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard();
      },
      child: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: <Widget>[
          SliverAppBar(
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
                        color: NeutralColor.disabled,
                      ),
                      controller: searchController,
                      hintText: "Search",
                      onTap: () {
                        setState(() {
                          isSearching = true;
                        });
                      },
                      onChanged: () {
                        // TODO: Day 3 - Update UserStream Pencarian User
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
            // TODO: Day 3 - UserCubit, Stream Pencarian User / List Chats Room
            ...List.generate(
                20,
                (index) => Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (index == 0)
                              ? SizedBox.shrink()
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.defaultMargin),
                                  child: Divider(
                                    color: Theme.of(context).accentColor,
                                    height: 0,
                                  ),
                                ),
                          CustomListChatCard(
                            chatRoom: chatRoomMock,
                            onTap: () => ScreenNavigator.startScreen(
                                context,
                                DetailChatScreen(
                                  userMe: userMock,
                                  userReceiver: chatRoomMock.userReceiver!,
                                )),
                          ),
                        ],
                      ),
                    )),
          ]))
        ],
      ),
    );
  }
}
