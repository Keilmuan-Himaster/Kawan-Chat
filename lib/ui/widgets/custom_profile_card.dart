import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';

class CustomProfileCard extends StatelessWidget {
  const CustomProfileCard(
      {Key? key, this.imageUrl, required this.height, required this.padding, this.imageWidget})
      : super(key: key);

  final String? imageUrl;
  final double padding, height;
  final ImageProvider<Object>? imageWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          width: height,
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor, shape: BoxShape.circle),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: FadeInImage(
              placeholder: AssetImage(
                  (Theme.of(context).scaffoldBackgroundColor ==
                          NeutralColor().white)
                      ? "assets/icons/icon_person_black.png"
                      : "assets/icons/icon_person_white.png"),
              image: NetworkImage(imageUrl ?? ""),
            ),
          ),
        ),
       Container(
          height: height,
          width: height,
          decoration: BoxDecoration(
              color: NeutralColor().line.withOpacity(0),
              shape: BoxShape.circle),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: FadeInImage(
              placeholder: AssetImage(""),
              image: imageWidget ??  NetworkImage(imageUrl ?? ""),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
