import 'dart:io';

import 'package:academy/shared/network/local/cachehelper.dart';
import 'package:academy/shared/network/remote/dio_helper.dart';
import 'package:academy/views/profile_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:meta/meta.dart';
import 'package:academy/views/home%20page/pages/main_page.dart' as main;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




import '../../../models/category/collages_models.dart';
import '../../../models/category/university_model.dart';
import '../../home page/pages/collage/collage.dart';
import '../../home page/pages/university/unvirsity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit (HomeState  initialState) : super(HomeInitial());
  static  HomeCubit get(context) => BlocProvider.of(context);
  //To Storage State Of Network
  bool netConnected=false;
  //To Storage Index Screen The Screen I need Show It from Nav bar
  int currentIndex = 1;

  //List Of Screens That I will Choose Show It From nav Bar
  List<Widget> screen = [


     main.MainPage(),
    University(),
    Collage(),
  ];
  bool test=false;
  void getCount(){
    emit(GetDataLoadingAcademyProgrammes());
    collageId.forEach((element) {
      print(element);
      DioHelper.getData(url: 'wp/v2/course_category/${element}?v=123123').then((value) {

        collageCount.add(value.data['count']);


        emit(GetDataSuccessAcademyProgrammes());
      }).catchError((err){
        print(err.toString());
        emit(GetDataErrorAcademyProgrammes());
      });


    },);
    universityId.forEach((element) {
      print(element);
      DioHelper.getData(url: 'wp/v2/course_category/${element}?v=123123').then((value) {
        universityCount.add(value.data['count']);


        emit(GetDataSuccessAcademyProgrammes());
      }).catchError((err){
        print(err.toString());
        emit(GetDataErrorAcademyProgrammes());
      });


    },);

       test=true;
  }


  void changBottomBar(int index) {

    currentIndex = index;
    emit(ChangBottomBarIconState());

  }
  void checkNet()async{
    emit(Net());
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        netConnected=true;
        emit(Net());
      }
    } on SocketException catch (_) {
      netConnected=false;
      emit(Net());
    }
  }


}
