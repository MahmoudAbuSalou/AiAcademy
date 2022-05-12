import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../style/colors.dart';


ThemeData lightThem = ThemeData(
    primarySwatch: Colors.blue,








    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black)

    ),








    scaffoldBackgroundColor: Colors.white,











    appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,


      iconTheme: IconThemeData(color: Colors.black),
      //To Editing On Design The  area at the top ِ ِِAppBar
      backwardsCompatibility: false,
      //Design of  The  area at the top ِ ِِAppBar
      systemOverlayStyle: SystemUiOverlayStyle(
        //Color of The  area at the top ِ ِِAppBar
        statusBarColor: Colors.white,
        //Color of Icons in The  area at the top ِ ِِAppBar   [   Dark     Light]
        statusBarIconBrightness: Brightness.dark,
      ),

      //Design of Title In App Bar
      titleTextStyle: TextStyle(
          fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),


      backgroundColor: Colors.white,
      elevation: 0,
    ),






    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.deepOrange,
    ),










    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 20.0,
        selectedItemColor: defaultColor,
        backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey

    ));

ThemeData darkThem = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF262424),








  primarySwatch: Colors.blue,








  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(color: Colors.white),
    backwardsCompatibility: false,
    titleTextStyle: TextStyle(
        fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor:  Color(0xFF262424), //HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    color: Color(0xFF262424),
    //HexColor('333739'),
    elevation: 0,
  ),








  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),









  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    selectedItemColor: Colors.deepOrange,
    backgroundColor: Color(0xFF262424),
    unselectedItemColor: Colors.grey
  ),









  textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white)),







);
