import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

        child: Column(
          children: [
            Container(child: Image.asset('images/logoUp.png' ),
            height:700.h,
            ),
            Expanded(
              child: DelayedDisplay(
                delay: Duration(milliseconds: 150),

                slidingBeginOffset: Offset(0, 1),
                slidingCurve: Curves.easeInOutSine,
                child: Container(
                  margin: EdgeInsets.only(top: 0),
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
          ],
        ),
      ),
    ));
  }
}
