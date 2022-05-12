import 'dart:ffi';

import 'package:academy/shared/components/components.dart';
import 'package:academy/views/course_info.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../components/components.dart';
import '../../../components/const.dart';
import '../../../components/loggin_text_field.dart';
import '../../../shared/network/local/cachehelper.dart';
import '../../Search/SearchScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  var height=0.0;var width=0.0;



  //List Of Main Sections In Main Page
  List <Widget>  Speci=[

  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    var size=MediaQuery.of(context).size;
    TextEditingController search = TextEditingController();
    Speci.clear();
    Speci.add(_degreeCard(title: 'درجة الدكتوراة',id:40.toString(),image: 'https://aiacademy.info/wp-content/uploads/2020/04/imageedit_1_2935186286-768x512.webp'),);
    Speci.add(_degreeCard(title: 'درجة الماجيستير',id:42.toString(),image: 'https://aiacademy.info/wp-content/uploads/2020/07/imageedit_3_2634596191-768x512.webp',),);
    Speci.add(_degreeCard(title: 'درجة البكالوريوس',id:32.toString(),image: 'https://aiacademy.info/wp-content/uploads/2020/04/imageedit_9_8887104436-768x512.webp'),);
    return  SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(size.width*kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SearchScreen(),));
                },
                child: TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.text,

                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: kFontFamily,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    filled: true,
                    fillColor: Colors.white,

                    prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(Icons.search,color: Colors.black54,)
                    ),
                    hintText: 'بحث',
                    hintStyle:  TextStyle(
                      color: kSwatchColor,

                      fontSize: 50.sp,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 40.h,),
            Row(
              children: [
                FittedBox(child: AutoSizeText('الدرجات ',style: GoogleFonts.tajawal(
                  textStyle: TextStyle(fontSize: kTitleSize)
                ),),),
                FittedBox(child: AutoSizeText('الجامعية',style: GoogleFonts.tajawal(
                  textStyle: TextStyle(fontSize: kTitleSize,color: kSwatchColor,fontWeight: FontWeight.bold),)
                ),)
              ],
            ),
            Container(

                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:Speci
                )

            ),

          ],
        ),
      ),
    );
  }
  Widget _degreeCard({required String image,required String title,required String id,}){
    return  InkWell(
      onTap: (){
        navigatorTo(context, Courses(title: title, id: id, height: height, width: width));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100.w,vertical: 30.h),
        child: Container(

          height: 500.h,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,

                )
              ],
              borderRadius: BorderRadius.only(topRight: Radius.circular(40.r), topLeft:Radius.circular(40.r),bottomLeft: Radius.circular(40.r),bottomRight: Radius.circular(40.r)),

              color: Colors.white,
              border: Border.all (color:kSwatchColor)
          ),

          child: Column(
            children:[
              Container(


                height: 70.h,
                width: double.infinity,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: kFontFamily,
                      color: const Color(0xff0B0742),
                      fontSize: 40.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
             
              Expanded(
                child: FancyShimmerImage(
                  boxFit: BoxFit.fitHeight,
                  imageUrl:image ,
                  errorWidget: Image.network(
                      'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}



class SearchTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10.0),
      ),

    );
  }
  Widget _degreeCard({required String img,required String title}){
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.w,vertical: 40.h),
      child: Container(

        height: 500.h,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,

              )
            ],
            borderRadius: BorderRadius.only(topRight: Radius.circular(40.r), topLeft:Radius.circular(40.r)),

            color: Colors.white,
            border: Border.all (color:kSwatchColor)
        ),

        child: Column(
          children:[
            Container(


              height: 70.h,
              width: double.infinity,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: kFontFamily,
                    color: const Color(0xff0B0742),
                    fontSize: 40.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Divider(color:kSwatchColor,height: 3.h),
            Expanded(
              child: FancyShimmerImage(
                boxFit: BoxFit.fill,
                imageUrl:img ,
                errorWidget: Image.network(
                    'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
class Collage extends StatelessWidget{
  Collage({Key? key,required this.image,required this.name,required this.onPressed}) : super(key: key);
  Function() onPressed;
  String image;
  String name;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover
                ),
              ),
            ),
          ),
          FittedBox(
            child: AutoSizeText(name,style: TextStyle(fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }

}
class Course extends StatelessWidget{
  Course({Key? key,required this.image,required this.name,required this.onPressed}) : super(key: key);
  Function() onPressed;
  String image;
  String name;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover
                ),
              ),
            ),
          ),
          FittedBox(
            child: AutoSizeText(name,style: TextStyle(fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }

}
class UniversityContainer extends StatelessWidget{
  const UniversityContainer({Key? key, required this.name, required this.color, required this.icon}) : super(key: key);
  final String name;
  final Color color;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width/2,
            height: 100,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(child: icon),
          ),
          FittedBox(
            child: AutoSizeText(name),
          )
        ],
      ),
    );
  }

}