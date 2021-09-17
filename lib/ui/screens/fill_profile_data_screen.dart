import 'dart:io';

import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/models/api_return_value.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/ui/screens/main_screen.dart';
import 'package:chat_app/ui/widgets/custom_app_bar.dart';
import 'package:chat_app/ui/widgets/custom_button.dart';
import 'package:chat_app/ui/widgets/custom_dialog.dart';
import 'package:chat_app/ui/widgets/custom_profile_card.dart';
import 'package:chat_app/ui/widgets/custom_text_field.dart';
import 'package:chat_app/ui/widgets/custom_toast.dart';
import 'package:chat_app/utils/custom_navigator.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/cubit/cubit.dart';

class FillProfileDataScreen extends StatefulWidget {
  const FillProfileDataScreen(
      {Key? key, required this.uid, required this.phoneNumber})
      : super(key: key);

  final String uid, phoneNumber;

  @override
  _FillProfileDataScreenState createState() => _FillProfileDataScreenState();
}

class _FillProfileDataScreenState extends State<FillProfileDataScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  final _picker = ImagePicker();
  File? selectedProfilePicture;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          appBar: CustomAppBar(),
          body: buildBody()),
    );
  }

  Padding buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              showImageActionSheet();
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomProfileCard(
                    height: 100,
                    padding: 24,
                    imageWidget: FileImage(File(selectedProfilePicture?.path ?? ""))),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: Theme.of(context).iconTheme.color, shape: BoxShape.circle),
                        child: Icon(
                          (selectedProfilePicture == null)
                              ? Icons.add
                              : Icons.edit,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          size: 18,
                        ))),
              ],
            ),
          ),
          SizedBox(
            height: 31,
          ),
          CustomTextField(
              controller: firstNameController,
              autofocus: true,
              hintText: "First Name (Required)"),
          SizedBox(
            height: 12,
          ),
          CustomTextField(
              controller: lastNameController, hintText: "Last Name (Optional)"),
          Spacer(),
          CustomButton(
              label: "Save",
              onTap: () async {
                if (firstNameController.text.trim() == "") {
                  CustomToast.showToast(message: "First name cannot be empty");
                } else {
                  ProgressDialog progressDialog =
                      CustomDialog.showProgressDialog(context,
                          message: "Sedang membuat akun");
                  progressDialog.show();

                  ApiReturnValue<bool> result = await context
                      .read<UserCubit>()
                      .addUser(UserModel(
                          uid: widget.uid,
                          phoneNumber: widget.phoneNumber,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          fullName: Utils.fullName(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text),
                          imageUrl: selectedProfilePicture?.path ?? ""));

                  progressDialog.dismiss();
                  if (result.value!) {
                    CustomNavigator().removeAllScreen(context, MainScreen());
                  } else {
                    CustomToast.showToast(
                        message: "Gagal membuat akun, silahkan coba kembali");
                  }
                }
              }),
          SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }

  void showImageActionSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Kamera", style: TextStyle(color: NeutralColor.weak),),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedImage =
                        await _picker.getImage(source: ImageSource.camera);
                    if (pickedImage != null) {
                      ImageProperties properties =
                          await FlutterNativeImage.getImageProperties(
                              pickedImage.path);
                      File compressedFile =
                          await FlutterNativeImage.compressImage(
                              pickedImage.path,
                              quality: 80,
                              targetWidth: 600,
                              targetHeight:
                                  (properties.height! * 600 / properties.width!)
                                      .round());
                      setState(() {
                        selectedProfilePicture = File(compressedFile.path);
                      });
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.perm_media),
                  title: Text("Galeri", style: TextStyle(color: NeutralColor.weak),),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedImage =
                        await _picker.getImage(source: ImageSource.gallery);
                    if (pickedImage != null) {
                      setState(() {
                        selectedProfilePicture = File(pickedImage.path);
                      });
                    }
                  },
                ),
              ],
            ));
  }
}
