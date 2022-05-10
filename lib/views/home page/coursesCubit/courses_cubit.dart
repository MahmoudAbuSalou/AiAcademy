import 'dart:convert';

import 'package:academy/models/courses/course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../shared/network/end_point.dart';
import '../../../../../shared/network/remote/dio_helper.dart';
part 'courses_state.dart';
/*
this Class is Used for:
 1-get Courses inside collages and university
 Note: Pagination is Here And Components in components.dart (Class Item Card)



 */
class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesInitial());

  static CoursesCubit get(context) => BlocProvider.of(context);
  late List<courseModel> courses = [];
   //Store Num Of Page of Data To Pagination
  int countPagination = 1;
  //Controller For Pagination
  RefreshController refreshController = RefreshController(initialRefresh: false);


  //Api Fetch Data From Back With Pagination
  void getCourseData(int id) async{


    if(countPagination==1){
      emit(GetDataLoadingAcademyCourses());
    }


    DioHelper.getData(url: coursesById + '${id}&page=$countPagination')
        .then((value) {

      for (int i = 0; i < value.data.length; i++) {
        courses.add(courseModel.fromJson(value.data[i]));
      }


      //Add One To countPagination For Fetch Data From Next Page
      countPagination++;

      //that Refer To The Data is Downloaded In Right Way
      refreshController.loadComplete();

      emit(GetDataSuccessAcademyCourses());
    }).catchError((error) {

      refreshController.loadFailed();
      emit(GetDataErrorAcademyCourses());
    });
  }
}


