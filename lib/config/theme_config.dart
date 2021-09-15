import 'package:chat_app/config/custom_color.dart';
import 'package:chat_app/config/custom_text_style.dart';
import 'package:flutter/material.dart';

// [heading] change to [headline]
// [subheading] change to [subtitle]
// [body] change to [bodytext]
// [metadata] change to [headline4]
class ThemeConfig {
  static final ThemeData lightTheme = ThemeData(
      fontFamily: "Mulish",
      appBarTheme: AppBarTheme(
          backgroundColor: NeutralColor.white,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: NeutralColor.active)),
      scaffoldBackgroundColor: NeutralColor.white,
      textTheme: TextTheme(
        headline1:
            CustomTextStyle.heading1.copyWith(color: NeutralColor.active),
        headline2: CustomTextStyle.heading2.copyWith(
              color: NeutralColor.active,
            ),
        subtitle1: CustomTextStyle
            .subHeading1
            .copyWith(color: NeutralColor.active),
        subtitle2: CustomTextStyle
            .subHeading2
            .copyWith(color: NeutralColor.active),
        bodyText1:
            CustomTextStyle.body1.copyWith(color: NeutralColor.active),
        bodyText2:
            CustomTextStyle.body2.copyWith(color: NeutralColor.active),
        headline4:
            CustomTextStyle.metaData1.copyWith(color: NeutralColor.active),
        headline5:
            CustomTextStyle.metaData2.copyWith(color: NeutralColor.active),
        headline6:
            CustomTextStyle.metaData3.copyWith(color: NeutralColor.active),
      ),
      iconTheme: IconThemeData(color: NeutralColor.active),
      primaryColorLight: NeutralColor.offWhite,
      primaryColorDark: NeutralColor.active,
      accentColor: NeutralColor.offWhite,
      primaryColor: BrandColor.defaultColor,

      splashColor: NeutralColor.line,

      cardColor: BrandColor.defaultColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: BrandColor.defaultColor)));

  static final ThemeData darkTheme = ThemeData(
      fontFamily: "Mulish",
      appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
          backgroundColor: NeutralColor.active,
          iconTheme: IconThemeData(color: NeutralColor.offWhite)),
      scaffoldBackgroundColor: NeutralColor.active,
      textTheme: TextTheme(
        headline1:
            CustomTextStyle.heading1.copyWith(color: NeutralColor.offWhite),
        headline2: CustomTextStyle.heading2.copyWith(
              color: NeutralColor.offWhite,
            ),
        subtitle1: CustomTextStyle
            .subHeading1
            .copyWith(color: NeutralColor.offWhite),
        subtitle2: CustomTextStyle
            .subHeading2
            .copyWith(color: NeutralColor.offWhite),
        bodyText1:
            CustomTextStyle.body1.copyWith(color: NeutralColor.offWhite),
        bodyText2:
            CustomTextStyle.body2.copyWith(color: NeutralColor.offWhite),
        headline4: CustomTextStyle
            .metaData1
            .copyWith(color: NeutralColor.offWhite),
        headline5: CustomTextStyle
            .metaData2
            .copyWith(color: NeutralColor.offWhite),
        headline6: CustomTextStyle
            .metaData3
            .copyWith(color: NeutralColor.offWhite),
      ),
      iconTheme: IconThemeData(color: NeutralColor.offWhite),
      primaryColorLight: NeutralColor.offWhite,
      primaryColorDark: NeutralColor.active,
      accentColor: NeutralColor.dark,
      splashColor: NeutralColor.dark,
      primaryColor: NeutralColor.offWhite,
      cardColor: BrandColor.darkMode,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: BrandColor.darkMode)));
}
