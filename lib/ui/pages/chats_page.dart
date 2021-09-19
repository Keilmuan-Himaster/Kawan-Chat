import 'package:chat_app/cubit/cubits.dart';
import 'package:chat_app/models/api_return_value.dart';
import 'package:chat_app/services/chat_services.dart';
import 'package:chat_app/services/user_services.dart';
import 'package:chat_app/ui/widgets/custom_dialog.dart';
import 'package:chat_app/ui/widgets/custom_list_user_card.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  // TODO: Day 3.5 - Deklarasi variabel UserStream untuk pencarian user
  Stream<QuerySnapshot>? userStream;

  @override
  void initState() {
    // TODO: Day 2.17 - Dapatkan detail User detail
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
                        // TODO: Day 3.6 - Update UserStream Pencarian User
                        setState(() {
                          userStream = UserServices.getListUserByName(
                              name: searchController.text.toLowerCase(),
                              myName: (context.read<UserCubit>().state
                                      as UserLoaded)
                                  .user
                                  .fullName);
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
            // TODO: Day 3.7 - UserCubit, Stream Pencarian User / List Chats Room
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  if (isSearching) {
                    return StreamBuilder<QuerySnapshot>(
                        // FIXME: Don't use stream, maybe can user cubit to catch the return value
                        stream: userStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.docs.length > 0) {
                              return ListView.builder(
                                  itemCount: snapshot.data?.docs.length,
                                  shrinkWrap: true,
                                  itemBuilder: (_, index) {
                                    return CustomListUserCard(
                                      user: UserModel.fromJson(
                                          snapshot.data?.docs[index].data()
                                              as Map<String, dynamic>),
                                      onTap: () async {
                                        // Create database for me as sender
                                        ApiReturnValue<bool> result =
                                            await ChatServices.createChatRoom(
                                                user: state.user,
                                                chatRoomModel: ChatRoomModel(
                                                    userReceiver: UserModel
                                                        .fromJson(snapshot.data
                                                                ?.docs[index]
                                                                .data()
                                                            as Map<String,
                                                                dynamic>)));
                                        if (result.value!) {
                                          ScreenNavigator.startScreen(
                                              context,
                                              DetailChatScreen(
                                                userMe: state.user,
                                                userReceiver:
                                                    UserModel.fromJson(snapshot
                                                            .data?.docs[index]
                                                            .data()
                                                        as Map<String,
                                                            dynamic>),
                                              ));
                                          // Write data for receiver
                                          ChatServices.createChatRoom(
                                              user: UserModel.fromJson(snapshot
                                                      .data?.docs[index]
                                                      .data()
                                                  as Map<String, dynamic>),
                                              chatRoomModel: ChatRoomModel(
                                                  userReceiver: state.user));
                                        } else {
                                          CustomDialog.showToast(
                                              message: result.message);
                                        }
                                      },
                                    );
                                  });
                            } else {
                              // TODO: Handle if data []
                              return Container();
                            }
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox(
                              height: SizeConfig.screenHeight * 0.8,
                              child: Center(
                                  child: CustomDialog
                                      .showCircularProgressIndicator()),
                            );
                          } else {
                            // TODO: Handle this error
                            return Container();
                          }
                        });
                  } else {
                    return StreamBuilder<QuerySnapshot>(
                        stream: ChatServices.getChatRooms(user: state.user),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != null) {
                              if (snapshot.data!.docs.length > 0) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (_, index) {
                                      return CustomListChatCard(
                                        chatRoom: ChatRoomModel.fromJson(
                                            snapshot.data?.docs[index].data()
                                                as Map<String, dynamic>),
                                        onTap: () {
                                          ScreenNavigator.startScreen(
                                              context,
                                              DetailChatScreen(
                                                userMe: state.user,
                                                userReceiver:
                                                    UserModel.fromJson(snapshot
                                                                    .data?.docs[
                                                                index]
                                                            ["user_receiver"]
                                                        as Map<String,
                                                            dynamic>),
                                              ));
                                        },
                                      );
                                    });
                              } else {
                                // TODO: Handle if data []
                                return Container();
                              }
                            } else {
                              // TODO: Handle if data null
                              return Container();
                            }
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox(
                              height: SizeConfig.screenHeight * 0.8,
                              child: Center(
                                  child: CustomDialog
                                      .showCircularProgressIndicator()),
                            );
                          } else {
                            // TODO: Handle this error
                            return Container();
                          }
                        });
                  }
                } else if (state is UserLoadingFailed) {
                  // TODO: Handle this error
                  return Container();
                } else {
                  return SizedBox(
                    height: SizeConfig.screenHeight * 0.8,
                    child: Center(
                        child: CustomDialog.showCircularProgressIndicator()),
                  );
                }
              },
            )
          ]))
        ],
      ),
    );
  }
}
