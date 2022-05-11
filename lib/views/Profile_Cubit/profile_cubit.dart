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
import '../../models/about_course_Model.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/end_point.dart';
import '../../shared/network/remote/dio_helper.dart';
part 'profile_state.dart';



class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(profileInitial) : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  /// model of profile
 late ProfileModel profileModel;

  void getUserProfile() {
    IdsOfCoursesImages=[];
    emit(ProfileLoadingState());
    DioHelper.getData(url: PROFILE + CacheHelper.getData(key: 'user_id'),token: CacheHelper.getData(key: 'token'))
        .then((value) {
 /// convert json to class model
        profileModel = ProfileModel.fromJson(value.data['tabs']);
        //Call Images Of Coureces
      //  getImages();
      emit(ProfileSuccessState(profileModel));
    }).catchError((error) {
      emit(ProfileErrorState("error"));
    });
  }
  List Images=[];
  late AboutCourseModel aboutCourseModel;
  void getImages(){

    emit(downloadImageLoadingState());
    IdsOfCoursesImages.forEach((id){
      print(id);
      DioHelper.getData(
          url: 'learnpress/v1/courses/$id',
          token: CacheHelper.getData(key: 'token'))
          .then((value) {
        aboutCourseModel=value.data;
        Images.add(aboutCourseModel.image);

        emit(downloadImageSuccessState());
      }).catchError((error) {
        emit(downloadImageErrorState());
      });

    });

  }

}


