import 'dart:ffi';

import 'package:academy/shared/components/components.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../components/components.dart';
import '../../../components/const.dart';
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

//List Of Info That i show It In Carsoul Slider
 List <Widget> Univ=[
  UniversityContainer(name: 'ادارة أعمال', color: Color(0xff32504F),icon: SvgPicture.asset('images/portfolio.svg',color: Colors.white,),),
  UniversityContainer(name: 'الحقوق', color: Color(0xff0096B1),icon: SvgPicture.asset('images/justice.svg',color: Colors.white)),
  UniversityContainer(name: 'هندسة', color: Color(0xffE2498A),icon: SvgPicture.asset('images/connection.svg',color: Colors.white)),
  UniversityContainer(name: 'الصحة', color: Color(0xff0096B1),icon: SvgPicture.asset('images/pharmacy.svg',color: Colors.white)),
  UniversityContainer(name: 'العلوم', color: Color(0xff562DD4),icon: SvgPicture.asset('images/microscope.svg',color: Colors.white)),
  UniversityContainer(name: 'الصحافة', color: Color(0xffFFB606),icon: SvgPicture.asset('images/journalism.svg',color: Colors.white)),
  UniversityContainer(name: 'الاداب', color: Color(0xffFF067D),icon: SvgPicture.asset('images/literature.svg',color: Colors.white)),
  UniversityContainer(name: 'العلوم السياسية', color: Color(0xffF4B110),icon: SvgPicture.asset('images/political-science.svg',color: Colors.white)),
  UniversityContainer(name: 'الفنون', color: Color(0xff32504F),icon: SvgPicture.asset('images/art-studies.svg',color: Colors.white)),
  UniversityContainer(name: 'الدراسات الاسلامية', color: Color(0xff0096B1),icon: SvgPicture.asset('images/quran.svg',color: Colors.white)),
  UniversityContainer(name: 'التربية', color: Color(0xff562DD4),icon: SvgPicture.asset('images/education.svg',color: Colors.white)),
];

 //List Of Main Sections In Main Page
List <Widget>  Speci=[

];
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
     width = MediaQuery.of(context).size.width;
    var size=MediaQuery.of(context).size;
    Speci.clear();
    Speci.add(ItemCard(title: 'درجة الدكتوراة', id: 40, height: height-200.h, width: width/1.2,image: 'https://aiacademy.info/wp-content/uploads/2020/04/imageedit_1_2935186286-768x512.webp',),);
    Speci.add(ItemCard(title: 'درجة الماجيستير', id: 42, height: height-200.h, width: width/1.2,image: 'https://aiacademy.info/wp-content/uploads/2020/07/imageedit_3_2634596191-768x512.webp',),);
    Speci.add(ItemCard(title: 'درجة البكالوريوس', id: 32, height: height-200.h, width: width/1.2,image: 'https://aiacademy.info/wp-content/uploads/2020/04/imageedit_9_8887104436-768x512.webp',),);
    return  SingleChildScrollView(

      child: Padding(
        padding: EdgeInsets.all(size.width*kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: AutoSizeText('مرحبا بك',style: TextStyle(fontSize: kTitleSize),),
                ),
                SizedBox(width: 5,),
                if(CacheHelper.getData(key: 'user_display_name')!=null)
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: AutoSizeText('${CacheHelper.getData(key: 'user_display_name')}',style: TextStyle(fontFamily: kFontFamily,color: kSwatchColor,fontSize: kTitleSize),),
                ),
              ],
            ),

            SizedBox(height: size.height*.025,),

            Row(
              children: [
                FittedBox(child: AutoSizeText('أبرز ',style: TextStyle(fontSize: kTitleSize),),),
                FittedBox(child: AutoSizeText('التخصصات',style: TextStyle(fontSize: kTitleSize,color: kSwatchColor,fontWeight: FontWeight.bold),),)
              ],
            ),

            Container(
              width: size.width,
              height: 160,
              child: CarouselSlider(

                items: Univ,
                  options: CarouselOptions(
                    height: 250,

                    viewportFraction: 0.3,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 1000),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,

                    scrollDirection: Axis.horizontal,
                  )
              ),

            ),
            SizedBox(height: size.height*.005,),
            Row(
              children: [
                FittedBox(child: AutoSizeText('الدرجات ',style: TextStyle(fontSize: kTitleSize),),),
                FittedBox(child: AutoSizeText('الجامعية',style: TextStyle(fontSize: kTitleSize,color: kSwatchColor,fontWeight: FontWeight.bold),),)
              ],
            ),


            SizedBox(
              height: 20.h,
            ),

            Container(

              padding: EdgeInsets.symmetric(horizontal: 2.w),


              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:Speci,
              )

            ),

          ],
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
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: new BorderRadius.circular(10.0),
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