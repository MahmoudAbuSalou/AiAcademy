import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../../components/components.dart';
import '../../../../components/const.dart';

import '../../../../models/category/university_model.dart';


class University extends StatelessWidget {
  const University({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(width * .03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  'الكليات الجامعية',
                  style: GoogleFonts.tajawal(
                    textStyle: TextStyle(
                      fontFamily: kFontFamily,
                      fontSize: kTitleSize,
                    ),
                  )
                ),
              ),
              SizedBox(
                height: height * .015,
              ),
              Container(

height: 4000.h,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: universityImages.length,

                  itemBuilder: (context, index) =>
                  //Fill ItemCard From University Model
                  ItemCard(
                    count: universityCount[index],
                    height: height,
                    width: width,
                    image: universityImages[index],
                    title: universityNames[index],
                    id: universityId[index],
                  ),
                  separatorBuilder:(context, index) =>Container(
                    height: 50.h,
                  ) ,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
