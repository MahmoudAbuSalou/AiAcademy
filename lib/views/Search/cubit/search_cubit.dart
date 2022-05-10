import 'package:academy/shared/network/remote/ExceptionHandler.dart';

import 'package:academy/views/Search/cubit/search_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/courses/course.dart';
import '../../../shared/network/end_point.dart';
import '../../../shared/network/remote/dio_helper.dart';



class SearchCubit extends Cubit<SearchStates> {
  SearchCubit( ) : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);


  late List <courseModel> courses=[];

  //Api Search
  void getSearchData({required String text}) {
    courses.clear();

    emit(GetDataLoadingSearchState());
    DioHelper.getData(url: Search+text, )
        .then((value) {
          courses.clear();
          print(value.data);
          for(int i=0;i<value.data.length;i++){
            courses.add(courseModel.fromJson(value.data[i]));
          }

      emit(GetDataSuccessSearchState());
    }).catchError((error) {
      print(error.toString());
      final Error=exceptionsHandle(error: error);
      emit(GetDataErrorSearchState());
    });
  }

}

