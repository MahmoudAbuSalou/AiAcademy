import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              SizedBox(
                height: height,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: universityImages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: width * .03,
                      crossAxisSpacing: height * .02),
                  itemBuilder: (context, index) =>
                      //Fill ItemCard From University Model
                      ItemCard(
                    height: height,
                    width: width,
                    image: universityImages[index],
                    title: universityNames[index],
                    id: universityId[index],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
