import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:chat_app/cubit/cubit.dart';
import 'package:chat_app/helper/full_name.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/user_services.dart';
import 'package:chat_app/ui/widgets/custom_app_bar_title.dart';
import 'package:chat_app/ui/widgets/custom_list_chat_card.dart';
import 'package:chat_app/ui/widgets/custom_list_user_card.dart';
import 'package:chat_app/ui/widgets/custom_text_field.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  TextEditingController searchController = TextEditingController();

  bool isSearching = false;

  // List user stream
  Stream<QuerySnapshot>? userStream;

  void hideKeyboard() {
    setState(() {
      isSearching = false;
      searchController.text = "";
    });
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void initState() {
    if (context.read<UserCubit>().state is UserInitial) {
      context
          .read<UserCubit>()
          .getUserDetail(FirebaseAuth.instance.currentUser!.uid);
    }
    super.initState();
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
                      onChanged: () {
                        setState(() {
                          userStream = UserServices.getListUserByName(
                              name: searchController.text.toLowerCase(),
                              myName: fullName(firstName: (context.read<UserCubit>().state
                                      as UserLoaded)
                                  .user
                                  .firstName, lastName: (context.read<UserCubit>().state
                                      as UserLoaded)
                                  .user
                                  .lastName));
                        });
                      },
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
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  if (isSearching) {
                    return StreamBuilder<QuerySnapshot>(
                        stream: userStream,
                        builder: (context, snapshot) {
                          print(snapshot.hasData);
                          print(userStream);
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
                                    );
                                  });
                            } else {
                              // TODO: Handle if data []
                              return Container();
                            }
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            // TODO: Handle this error
                            return Container();
                          }
                        });
                  } else {
                    return Container();
                  }
                } else if (state is UserLoadingFailed) {
                  // TODO: Handle this error
                  return Container();
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
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
