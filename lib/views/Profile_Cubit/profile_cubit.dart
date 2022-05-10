// ignore: slash_for_doc_comments
/**
 *  - this cubit use in profile_Screen
 *  - this cubit responsible to get profiles of user and courses that enrolled
 * **/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academy/models/ProfileModel.dart';
import 'package:academy/shared/network/local/cachehelper.dart';
import 'package:meta/meta.dart';
import '../../models/ProfileModel.dart';
import '../../shared/network/end_point.dart';
import '../../shared/network/remote/dio_helper.dart';
part 'profile_state.dart';



class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(profileInitial) : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  /// model of profile
 late ProfileModel profileModel;

  void getUserProfile() {
    emit(ProfileLoadingState());
    DioHelper.getData(url: PROFILE + CacheHelper.getData(key: 'user_id'),token: CacheHelper.getData(key: 'token'))
        .then((value) {
 /// convert json to class model
        profileModel = ProfileModel.fromJson(value.data['tabs']);

      emit(ProfileSuccessState(profileModel));
    }).catchError((error) {
      emit(ProfileErrorState("error"));
    });
  }
}
