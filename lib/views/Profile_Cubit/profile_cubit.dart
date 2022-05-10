import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academy/models/ProfileModel.dart';
import 'package:academy/models/ProfileModel.dart';
import 'package:academy/shared/network/local/cachehelper.dart';
import 'package:meta/meta.dart';

import '../../models/ProfileModel.dart';
import '../../models/ProfileModel.dart';
import '../../shared/network/end_point.dart';

import '../../shared/network/remote/dio_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(profileInitial) : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  List finished = [];
  List passed = [];
  List in_Progress = [];

 late ProfileModel profileModel;

  void getUserProfile() {
    emit(ProfileLoadingState());
    DioHelper.getData(url: PROFILE + CacheHelper.getData(key: 'user_id'),token: CacheHelper.getData(key: 'token'))
        .then((value) {

        profileModel = ProfileModel.fromJson(value.data['tabs']);
        print(profileModel.courses!.finished.length);
        // profileModel.courses?.finished.forEach((element) {
        //   print(element.id);
        //   print(element.title);
        //   print(element.expiration);
        //   print(element.graduation);
        //   print(" results : ${element.results}");
        //
        // });



      emit(ProfileSuccessState(profileModel));
    }).catchError((error) {
      print(error.toString());

      // String ERROR = exceptionsHandle(error: error);
      emit(ProfileErrorState("error"));
    });
  }
}
