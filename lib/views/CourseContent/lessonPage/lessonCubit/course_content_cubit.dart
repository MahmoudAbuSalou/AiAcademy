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

/*
this class is used for:
1-get lesson [ Videos + Pdfs + Playlists  ]
2-Finish Lesson + Finish Course



 */


class CourseContentCubit extends Cubit<CourseContentState> {
  CourseContentCubit() : super(CourseContentInitial());

  static CourseContentCubit get(context) => BlocProvider.of(context);
  //Useful For Conditional builder in Class (WatchCourse) in File (lessonContent) For Show
  bool test=false;

 //To Storage Course Model
  late CourseWatchModel  course;

  //List of Titels and Icons that i use it in bottom Nav Bar In  Class (WatchCourse) in File (lessonContent)
  List<BottomNavigationBarItem> list = [
    BottomNavigationBarItem(icon: Icon(Icons.video_call_outlined), label: "الفيديوهات"),
    BottomNavigationBarItem(icon: Icon(Icons.list), label: "الملحقات"),

  ];
  //Index For show page that i need it from Nav Bar
  int currentIndex = 0;

  //Api for get Data of Course
  void getCourseWatchCubit( {required String id,required context}){
    print(id);
    emit(GetDataLoadingWatchCourse());
    DioHelper.getData(url: 'learnpress/v1/lessons/$id',token: CacheHelper.getData(key: 'token'))
        .then((value) {

       print(value.data);

       //Parsing
      course = CourseWatchModel.fromJson(value.data);

      //Call getLinkVideos : it will extract links of Videos From ContentHtml (links) in Model
      course.getLinkVideos(course.links);
      course.linkvideo.forEach((e)=>print(e));
       //Call getLinkPdfs : it will extract links of Pdfs From ContentHtml (links) in Model
      course.getLinkPdfs(course.links);





    //Change value of test for Show
      test=true;
      emit(GetDataSuccessWatchCourse());
    }).catchError((error) {
      showToast(msg: 'عذراً لا يمكنك رؤية المحتوى', state: ToastState.ERROR);

      Navigator.of(context).pop();
      print(error.toString());
      emit(GetDataErrorWatchCourse());
    });



  }


  //Api for Finis Lesson
  void finishLesson({required String id,required token}) {
    print(id);
    //مكتمل
    emit(loadingFinishLesson());
    DioHelper.postData(url: 'learnpress/v1/lessons/finish?id=$id', data: {


    },token: token,).then((value) {
        //Show Message that Backend return it for me (if SUCCESS)
      showToast(msg: value.data['message'] , state:ToastState.SUCCESS);
      print(value.data);





      emit(SuccessFinishLesson());
    }).catchError((error) {
      showToast(msg: 'لا يمكنك إنهاء هذا الكورس ', state:ToastState.ERROR);

      String ERROR = exceptionsHandle(error: error);
      emit(ErrorFinishLesson());
    });
  }


  // Api for Finish Course
  void finishCourse({required String id,required token}) {

    emit(loadingFinishCourse());
    DioHelper.postData(url:'learnpress/v1/courses/finish?id=$id' , data: {


    },token: token).then((value) {






      emit(SuccessFinishCourse());
    }).catchError((error) {
      print(error.toString());

      String ERROR = exceptionsHandle(error: error);
      emit(ErrorFinishCourse());
    });
  }

  //To Change State Of Page
  void changeBottomNavigationBar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavigationBar());
  }

}
