import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/ui/screens/main_screen.dart';
import 'package:chat_app/ui/widgets/custom_app_bar.dart';
import 'package:chat_app/ui/widgets/custom_button.dart';
import 'package:chat_app/ui/widgets/custom_text_field.dart';
import 'package:chat_app/utils/screen_navigator.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class FillProfileDataScreen extends StatefulWidget {
  const FillProfileDataScreen({Key? key}) : super(key: key);

  @override
  _FillProfileDataScreenState createState() => _FillProfileDataScreenState();
}

class _FillProfileDataScreenState extends State<FillProfileDataScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          appBar: CustomAppBar(),
          backgroundColor: NeutralColor.white,
          body: buildBody()),
    );
  }

  Padding buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: NeutralColor.offWhite,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "assets/icons/icon_person_black.png",
                ),
              ),
              Positioned(bottom: 0, right: 0, child: Icon(Icons.add_circle)),
            ],
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
            onTap: () => ScreenNavigator.removeAllScreen(context, MainScreen()),
          ),
          SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }
}
