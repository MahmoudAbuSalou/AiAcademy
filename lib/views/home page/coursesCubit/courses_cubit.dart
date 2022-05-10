import 'dart:convert';

import 'package:academy/models/courses/course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../shared/network/end_point.dart';
import '../../../../../shared/network/remote/dio_helper.dart';
part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesInitial());

  static CoursesCubit get(context) => BlocProvider.of(context);
  late List<courseModel> courses = [];

  int countPagination = 1;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  dynamic temp;


  void getCourseData(int id) async{


    if(countPagination==1){
      emit(GetDataLoadingAcademyCourses());
    }


    DioHelper.getData(url: coursesById + '${id}&page=$countPagination')
        .then((value) {

      for (int i = 0; i < value.data.length; i++) {
        courses.add(courseModel.fromJson(value.data[i]));
      }

      countPagination++;

      refreshController.loadComplete();

      emit(GetDataSuccessAcademyCourses());
    }).catchError((error) {
      print(error);
      refreshController.loadFailed();
      emit(GetDataErrorAcademyCourses());
    });
  }
}


