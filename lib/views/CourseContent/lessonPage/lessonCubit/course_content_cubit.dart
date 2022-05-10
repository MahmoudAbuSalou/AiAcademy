import 'dart:convert';

import 'package:academy/shared/components/components.dart';
import 'package:academy/shared/components/constants.dart';
import 'package:academy/shared/network/local/cachehelper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../models/courses/CourceWatchModel.dart';
import '../../../../shared/network/remote/ExceptionHandler.dart';
import '../../../../shared/network/remote/dio_helper.dart';
part  'course_content_state.dart';




class CourseContentCubit extends Cubit<CourseContentState> {
  CourseContentCubit() : super(CourseContentInitial());
  static CourseContentCubit get(context) => BlocProvider.of(context);
  bool test=false;

  late CourseWatchModel  course;
  List<BottomNavigationBarItem> list = [
    BottomNavigationBarItem(icon: Icon(Icons.video_call_outlined), label: "الفيديوهات"),
    BottomNavigationBarItem(icon: Icon(Icons.list), label: "الملحقات"),

  ];
  int currentIndex = 0;
  void getCourseWatchCubit( {required String id,required context}){
    print(id);
    emit(GetDataLoadingWatchCourse());
    DioHelper.getData(url: 'learnpress/v1/lessons/$id',token: CacheHelper.getData(key: 'token'))
        .then((value) {
       print(value.data);
      course = CourseWatchModel.fromJson(value.data);

      course.getLinkVideos(course.links);
      course.linkvideo.forEach((e)=>print(e));
      course.getLinkPdfs(course.links);





      //print(" CourseLink: ${course.linkvideo[1]}");
      //  print(" CoursePdfLink: ${course.linkPdf[1]}");
      test=true;
      emit(GetDataSuccessWatchCourse());
    }).catchError((error) {
      showToast(msg: 'عذراً لا يمكنك رؤية المحتوى', state: ToastState.ERROR);

      Navigator.of(context).pop();
      print(error.toString());
      emit(GetDataErrorWatchCourse());
    });



  }
  void finishLesson({required String id,required token}) {
    print(id);
    //مكتمل
    emit(loadingFinishLesson());
    DioHelper.postData(url: 'learnpress/v1/lessons/finish?id=$id', data: {


    },token: token,).then((value) {

      showToast(msg: value.data['message'] , state:ToastState.SUCCESS);
      print(value.data);





      emit(SuccessFinishLesson());
    }).catchError((error) {
      showToast(msg: 'لا يمكنك إنهاء هذا الكورس ', state:ToastState.ERROR);

      String ERROR = exceptionsHandle(error: error);
      emit(ErrorFinishLesson());
    });
  }
  void finishCourse({required String id,required token}) {

    emit(loadingFinishCourse());
    DioHelper.postData(url:'learnpress/v1/courses/finish?id=$id' /*'/wp-json/learnpress/v1/courses/finish?id=105110'*/, data: {


    },token: token).then((value) {
      print(value.data);





      emit(SuccessFinishCourse());
    }).catchError((error) {
      print(error.toString());

      String ERROR = exceptionsHandle(error: error);
      emit(ErrorFinishCourse());
    });
  }
  void changeBottomNavigationBar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavigationBar());
  }

}
