
import 'package:academy/components/const.dart';
import 'package:academy/shared/components/components.dart';
import 'package:academy/views/HomeLayout/home_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';


import '../login_screen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then(
          (value) =>navigatorToNew(context, HomePage()),

    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.orange.shade400,kSwatchColor, kSwatchColor.withOpacity(0.8),kSwatchColor.withOpacity(0.7),],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter
          ),
        ),
        child: Center(
          child: Image.asset('images/logoUp.png',

          width: 700.w,
            height: 700.h,
          ),
        ),
      )
    );
  }
}

