
import 'package:academy/shared/components/components.dart';
import 'package:academy/views/HomeLayout/home_page.dart';
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
        height: height,
        width: width,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'images/1.jpg',
              ),
              fit: BoxFit.fill,
              filterQuality: FilterQuality.high,
              isAntiAlias: true,
            )),
      ),
    );
  }
}
