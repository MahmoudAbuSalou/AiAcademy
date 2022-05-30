import 'package:academy/shared/components/components.dart';
import 'package:academy/views/course_info.dart';
import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../views/home page/coursesCubit/courses_cubit.dart';
import 'const.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class MyAppBar extends StatelessWidget {
  String title;

  bool BoolNextPage;
  String id;
  MyAppBar({
    Key? key,
    required this.BoolNextPage,
    required this.id,

    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height * 0.11,
        decoration: const BoxDecoration(
          color: kSwatchColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontFamily: kFontFamily,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                onPressed: () {
                  (BoolNextPage)?
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).pop();
                  }):
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CourseInfo(id: id),));
                  });
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BorderedButton extends StatelessWidget {
  final String title;
  final Color color;
  final onPress;

  const BorderedButton(
      {Key? key,
      required this.title,
      required this.color,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,

      margin: EdgeInsets.symmetric(horizontal: 4),
      child: RaisedButton(
        onPressed: onPress,
        splashColor: color,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(color: color, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: FittedBox(
            child: Text(
              title,
              style: GoogleFonts.tajawal(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,

                )
              ),
            ),
          ),
        ),
        //color: Colors.white,
      ),
    );
  }
}

class Course extends StatelessWidget {
  const Course({
    Key? key,
    required this.width,
    required this.height,
    required this.courseImage,
    required this.rate,
    required this.courseName,
    required this.coursePrice,
    required this.courseCommentsCount,
    required this.courseStudentsCount,
    required this.platformImage,
    required this.platformName,
    required this.tag,
    required this.onTap,
  }) : super(key: key);

  final double width;
  final double height;
  final  rate;
  final VoidCallback onTap;
  final String courseImage,
      platformImage,
      platformName,
      courseName,
      coursePrice,
      courseCommentsCount,
      courseStudentsCount,
      tag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(width * .03),
        height: height * .40,
        width: width * .43,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9.0),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: kSecondaryColor,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Hero(
                    tag: tag,
                    child: Container(
                      height: height * .130,
                      width: width,
                      child: FancyShimmerImage(
                        boxFit: BoxFit.cover,
                        imageUrl: courseImage,
                        errorWidget: Image.network(
                            'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
                      ),


                    ),
                  ),

                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.all(width * .03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width * .45,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height:100.h,
                          child: Text(
                            courseName,
                            maxLines: 2,
                            style: GoogleFonts.tajawal(
                              textStyle: TextStyle(
                                  fontSize: 36.sp,
                                  fontFamily: kFontFamily,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis)
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        FittedBox(
                          child: Text(
                            coursePrice.toString(),
                            style:GoogleFonts.tajawal(
                              textStyle:  TextStyle(
                                fontSize: 40.sp,
                                fontFamily: kFontFamily,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            )
                          ),
                        ),
                        SizedBox(
                          height: 35.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 4),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                minRadius: 40.r,

                                backgroundImage: NetworkImage(platformImage),
                              ),
                            ),
                            //comments

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.group),
                                FittedBox(
                                  child: Text(
                                    '(${courseStudentsCount})',
                                    style:GoogleFonts.tajawal(
                                      textStyle:  TextStyle(
                                        fontSize: 30.sp,
                                        fontFamily: kFontFamily,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 31.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  platformName,
                                  maxLines: 2,
                                  style: GoogleFonts.tajawal(
                                    textStyle: TextStyle(
                                        fontSize: 20.sp,

                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        color: Colors.blueGrey,
                                        overflow: TextOverflow.ellipsis),
                                  )
                                ),
                              ),
                            ),

                            Padding(
                              padding:  EdgeInsets.only(left: 5.w),
                              child: RatingBar.builder(
                                initialRating: rate+0.0,
                                minRating: rate+0.0,
                                itemSize: 30.r,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                maxRating: rate+0.0,
                                ignoreGestures: true,
                                itemCount: 5,
                                itemPadding:
                                 EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: kSwatchColor,
                                ),
                                onRatingUpdate: (rating) {


                                  print(rating);
                                },
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  MyButton({
    Key? key,
    required this.height,
    required this.width,
    required this.title,
    required this.onTap,
    required this.loadSubscribeCourse,
  }) : super(key: key);

  final double height;
  final double width;
  final String title;
  final String loadSubscribeCourse;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          height: height.h,
          width: width.w,
          decoration: BoxDecoration(
            color: kSwatchColor,
            borderRadius: BorderRadius.circular(9.0),
          ),
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: loadSubscribeCourse == 'load'
                  ? Container(
                      height: 50.h,
                      width: 50.h,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: kFontFamily,
                      ),
                    )),
        ));
  }
}

class ItemCard extends StatelessWidget {
  ItemCard(
      {Key? key,
      required this.height,
        required this.count,
      required this.width,
      required this.image,
      required this.title,
      required this.id})
      : super(key: key);

  final double height;
  final double width;
  final String image, title;
  final int count;
  final int id;

  @override
  Widget build(BuildContext context) {


    return OpenContainer(
      //the Card Of Collage or University
      closedBuilder: (context, action) => SizedBox(
        height:500.h,
        width: width * .35,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 50.h,top: 15.h),
              height: 500.h,
              width: 400.w,
              child: FancyShimmerImage(
                boxFit: BoxFit.fill,
                imageUrl: image,
                errorWidget: Image.network(
                    'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.h,),
              Text(title,style: GoogleFonts.tajawal(
              fontSize: 50.sp,
                fontWeight: FontWeight.bold,
                color: kSwatchColor
              ),),
                SizedBox(height: 140.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Iconsax.archive_book,color: kSwatchColor,),
                  SizedBox(width: 20.w,),
                  Text('محاضرات و دورات عددها',style: GoogleFonts.tajawal(fontWeight: FontWeight.bold,fontSize: 40.sp,color: kSwatchColor),),
                  SizedBox(width: 20.w,),
                  Text(count.toString(),style: GoogleFonts.tajawal(fontWeight: FontWeight.bold,fontSize: 40.sp,color: kSwatchColor),),

                ],
              ),
                SizedBox(height: 20.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 55.w),
                  child: Container(
                    color: kSwatchColor,
                    height: 75.h,
                    width: 500.w,

                    margin: EdgeInsets.only(bottom: 50.h,top: 50.h),
                    child: Container(

                      child: Center(

                        child: Text(
                            'عرض التفاصيل',
                            style: GoogleFonts.tajawal(
                              textStyle: TextStyle(

                                color: kPrimaryColor,
                                fontSize: 55.sp,
                              ),
                            )
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
      //Content Of Collage or University [ Courses  ]
      openBuilder: (context, action) => BlocProvider(
        create: (context) => CoursesCubit()..getCourseData(id),
        child: BlocConsumer<CoursesCubit, CoursesState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = CoursesCubit.get(context);
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyAppBar(title: title,BoolNextPage: true,id: '0'),

                  Expanded(
                    child: ConditionalBuilder(
                        condition: state is! GetDataLoadingAcademyCourses,
                        builder: (context) =>
                            //Pagination : Wrap Grid View With SmartRefresher
                            SmartRefresher(
                              controller: cubit.refreshController,
                              enablePullUp: true,
                              enablePullDown: false,
                              footer: CustomFooter(
                                builder: (BuildContext context,LoadStatus? mode){
                                  Widget body ;
                                  if(mode==LoadStatus.idle){
                                    body =  Text(" ",style: GoogleFonts.tajawal(),);
                                  }
                                  else if(mode==LoadStatus.loading){
                                    body =  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("جاري التحميل ...  ",style: GoogleFonts.tajawal(),),
                                        CupertinoActivityIndicator()
                                      ],
                                    );
                                  }
                                  else if(mode == LoadStatus.failed){
                                    body =   CupertinoActivityIndicator(color: Colors.red,);
                                  }
                                  else if(mode == LoadStatus.canLoading){
                                    body = Text("");
                                  }
                                  else{
                                    body = Text("No more Data");
                                  }
                                  return Container(
                                    height: 55.0,
                                    child: Center(child:body),
                                  );
                                }
                              ),
                              onLoading: () {
                                cubit.getCourseData(id);
                              },
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics:

                                    const BouncingScrollPhysics(),
                                itemCount: cubit.courses.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: height * .37,
                                  mainAxisSpacing: width * .03,

                                ),
                                itemBuilder: (context, index) => Course(
                                  width: width,
                                  rate: cubit.courses[index].rate,
                                  height: height,
                                  courseImage: cubit.courses[index].image,
                                  platformImage: cubit.courses[index].avatar,
                                  courseName: cubit.courses[index].name,
                                  coursePrice: '\$' +
                                      cubit.courses[index].price.toString(),

                                  courseCommentsCount: '0',
                                  courseStudentsCount: cubit
                                      .courses[index].count_students
                                      .toString(),
                                  platformName: cubit.courses[index].nameOwner,
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => CourseInfo(
                                        id: cubit.courses[index].id.toString(),
                                      ),
                                    ));
                                  },
                                  tag: '1',
                                ),
                              ),
                            ),
                        fallback: (context) => Column(
                              children: [
                                SizedBox(
                                  height: 200.h,
                                ),
                                Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            )),
                  ),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
class Courses extends StatelessWidget {

  Courses(
      {Key? key,


        required this.title,
        required this.id,
        required this.height,
        required this.width,

      })
      : super(key: key);

  final double height;
  final double width;
  final String title;
  final String id;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CoursesCubit()..getCourseData(int.parse(id)),
        child: BlocConsumer<CoursesCubit, CoursesState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = CoursesCubit.get(context);

            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyAppBar(title: title,BoolNextPage: true,id: '0'),

                  Expanded(
                    child: ConditionalBuilder(
                        condition: state is! GetDataLoadingAcademyCourses,
                        builder: (context) =>
                        //Pagination : Wrap Grid View With SmartRefresher
                        SmartRefresher(
                          controller: cubit.refreshController,
                          enablePullUp: true,
                          footer: CustomFooter(
                              builder: (BuildContext context,LoadStatus? mode){
                                Widget body ;
                                if(mode==LoadStatus.idle){
                                  body =  Text(" ",style: GoogleFonts.tajawal(),);
                                }
                                else if(mode==LoadStatus.loading){
                                  body =  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("جاري التحميل ...  ",style: GoogleFonts.tajawal(),),
                                      CupertinoActivityIndicator()
                                    ],
                                  );
                                }
                                else if(mode == LoadStatus.failed){
                                  body =   CupertinoActivityIndicator(color: Colors.red,);
                                }
                                else if(mode == LoadStatus.canLoading){
                                  body = Text("");
                                }
                                else{
                                  body = Text("No more Data");
                                }
                                return Container(
                                  height: 55.0,
                                  child: Center(child:body),
                                );
                              }
                          ),
                          enablePullDown: false,
                          onLoading: () {
                            cubit.getCourseData(int.parse(id));
                          },
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics:

                            const BouncingScrollPhysics(),
                            itemCount: cubit.courses.length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: height * .37,
                              mainAxisSpacing: width * .03,

                            ),
                            itemBuilder: (context, index) => Course(
                              width: width,
                              rate: cubit.courses[index].rate,
                              height: height,
                              courseImage: cubit.courses[index].image,
                              platformImage: cubit.courses[index].avatar,
                              courseName: cubit.courses[index].name,
                              coursePrice: '\$' +
                                  cubit.courses[index].price.toString(),

                              courseCommentsCount: '0',
                              courseStudentsCount: cubit
                                  .courses[index].count_students
                                  .toString(),
                              platformName: cubit.courses[index].nameOwner,
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => CourseInfo(
                                    id: cubit.courses[index].id.toString(),
                                  ),
                                ));
                              },
                              tag: '1',
                            ),
                          ),
                        ),
                        fallback: (context) => Column(
                          children: [
                            SizedBox(
                              height: 200.h,
                            ),
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        )),
                  ),

                ],
              ),
            );
          },
        ),
      ) ,
    );
  }
}