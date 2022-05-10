import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';

import '../../models/user.dart';
import '../../shared/network/end_point.dart';

import '../../shared/network/remote/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(LoginInitial loginInitial) : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel ? userModel;
  void userLogin({required String userName, required password}) {
    emit(LoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'username': userName,
      'password': password,
    }).then((value) {
      print(value.data);

      userModel = UserModel.fromJson(value.data);



      emit(LoginSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());

      // String ERROR = exceptionsHandle(error: error);
      emit(LoginErrorState("الرجاء التحقق من الاتصال بالانترنت او المعلومات المدخلة"));
    });
  }

}
