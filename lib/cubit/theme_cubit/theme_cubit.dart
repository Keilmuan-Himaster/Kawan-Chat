import 'package:bloc/bloc.dart';
import 'package:chat_app/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(
    ThemeConfig.lightTheme
  ));

  void changeTheme (ThemeData themeData) {
    emit(ThemeState(themeData));
  }
}