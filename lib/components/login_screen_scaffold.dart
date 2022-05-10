import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

class LoginScreenScaffold extends StatelessWidget {
  final Widget child;

  const LoginScreenScaffold({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(

          image:
              DecorationImage(image: AssetImage('images/bg_login.png')),
        ),
        child: DelayedDisplay(
          delay: Duration(milliseconds: 150),

          slidingBeginOffset: Offset(0, 1),
          slidingCurve: Curves.easeInOutSine,
          child: Container(
            margin: EdgeInsets.only(top: size.height * 0.25),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: child,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
