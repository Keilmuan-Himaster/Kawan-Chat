import 'package:bloc/bloc.dart';
import 'package:chat_app/models/api_return_value.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/user_services.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<ApiReturnValue<bool>> checkUserExists(String uid) async {
    ApiReturnValue<UserModel> result = await UserServices.checkUserExists(uid);

    if (result.value != null) {
      emit(UserLoaded(result.value!));

      return ApiReturnValue(value: true);
    } else {
      emit(UserLoadingFailed(result.message!));

      return ApiReturnValue(
        value: false,
      );
    }
  }

  Future<void> getUserDetail(String uid) async {
    ApiReturnValue<UserModel> result = await UserServices.getUserDetail(uid);

    if (result.value != null) {
      emit(UserLoaded(result.value!));
    } else {
      emit(UserLoadingFailed(result.message!));
    }
  }

  Future<ApiReturnValue<bool>> addUser(UserModel user) async {
    ApiReturnValue<bool> result = await UserServices.addUser(user);

    if (result.value!) {
      getUserDetail(result.result!);
    }

    return result;
  }
}
