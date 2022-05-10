import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:academy/views/home%20page/pages/main_page.dart' as main;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




import '../../home page/pages/collage/collage.dart';
import '../../home page/pages/university/unvirsity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit (HomeState  initialState) : super(HomeInitial());
  static  HomeCubit get(context) => BlocProvider.of(context);
  bool netConnected=false;
  int currentIndex = 1;
  List<Widget> screen = [


    main.MainPage(),
    University(),
    Collage(),
  ];

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
