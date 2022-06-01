import 'package:academy/components/const.dart';
import 'package:academy/shared/components/components.dart';
import 'package:academy/views/Profile_Cubit/profile_cubit.dart';
import 'package:academy/views/course_info.dart';
import 'package:academy/views/web_view/web_view.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../shared/network/local/cachehelper.dart';
import '../../CourseInfoCubit/CourseInfo_cubit.dart';
import 'lessonCubit/course_content_cubit.dart';

class WatchCourse extends StatelessWidget {
  //To Store id of lesson
  String id;

  //To Store id of course , I will use it to Finish Course
  String finishId;

  //To Store Id Of Video when i show it in Full Mode 'Horizintal'
  int globalIndex = 1;

  WatchCourse({required this.id, required this.finishId,required this.context1}) : super();
final context1;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CourseContentCubit()..getCourseWatchCubit(id: id, context: context),
      child: BlocConsumer<CourseContentCubit, CourseContentState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = CourseContentCubit.get(context);

          return Directionality(
            textDirection: TextDirection.ltr,
            //Full Mode In YouTube
            child: (MediaQuery.of(context).orientation == Orientation.landscape)
                ? WillPopScope(
                    //To Prevent User from back if Dir is Horizintal
                    onWillPop: () async => false,
                    child: Scaffold(
                      body: Container(
                        child: YoutubePlayer(
                          controller: YoutubePlayerController(
                            initialVideoId: cubit.course.linkvideo[globalIndex],
                            flags: YoutubePlayerFlags(
                              autoPlay: false,
                              mute: false,
                            ),
                          ),
                          showVideoProgressIndicator: true,
                        ),
                      ),
                    ),
                  )

                //Normal Mode
                : WillPopScope(
              onWillPop:() async {
                Navigator.of(context).pop();

                return true;
              },
                  child: Scaffold(
                      appBar: AppBar(),
                      body: ConditionalBuilder(
                        condition: cubit.test,
                        builder: (context) {
                          //currentIndex==0 ===> This Page For Showing Videos
                          if (cubit.currentIndex == 0) {
                            // ignore: sized_box_for_whitespace
                            return Container(
                              height: MediaQuery.of(context).size.height,
                              // Subtracting 1 from length of List 'linkvideo' because index 0 contain unUseful Data
                              child: (cubit.course.linkvideo.length - 1 == 0)
                                  ? Center(
                                      child: Text(
                                        'عذراً لا يوجد محتوى في هذا القسم تحقق من قسم الملحقات',
                                        style: GoogleFonts.tajawal(
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          //List Of Videos
                                          //
                                         if (cubit.course.linkvideo.length -
                                              1==1)
                                           SizedBox(height: 250.h,),
                                          Container(

                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.all(16.h),
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, index) {
                                                //For Full Mode
                                                //adding 1 to Index For start from 1 instead of 0 because index 0 contain unUseful Data
                                                globalIndex = index + 1;

                                                return Padding(
                                                  padding: EdgeInsets.all(25.h),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.grey,
                                                            width: 8.w,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(4.h),
                                                          child: YoutubePlayer(
                                                            controller:
                                                                YoutubePlayerController(
                                                              initialVideoId: cubit
                                                                      .course
                                                                      .linkvideo[
                                                                  index + 1],
                                                              flags:
                                                                  YoutubePlayerFlags(
                                                                autoPlay: false,
                                                                mute: false,
                                                              ),
                                                            ),
                                                            showVideoProgressIndicator:
                                                                true,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 150.h,
                                                      ),
                                                      if (index != cubit.course.linkvideo.length - 2)
                                                        myDriver(),
                                                    ],
                                                  ),
                                                );
                                              },
                                              itemCount:
                                                  cubit.course.linkvideo.length -
                                                      1,
                                            ),
                                          ),

                                          //Buttons Of Finish Course And Finish Lesson
                                          Container(
                                            height: 120.h,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 50.w),
                                              child: Row(
                                                children: [
                                                  if (cubit.course.can_finish_course == true)
                                                    Expanded(
                                                      child: FlatButton(
                                                        onPressed: () {
                                                          // ignore: avoid_single_cascade_in_expression_statements
                                                          AwesomeDialog(
                                                            context: context,
                                                            dialogType:
                                                                DialogType.QUESTION,
                                                            animType: AnimType
                                                                .BOTTOMSLIDE,
                                                            buttonsTextStyle: GoogleFonts.tajawal(
                                                                fontSize: 40.sp,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.white

                                                            ),
                                                            descTextStyle: GoogleFonts.tajawal(
                                                                fontSize: 40.sp,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.black

                                                            ),
                                                            titleTextStyle: GoogleFonts.tajawal(
                                                                fontSize: 50.sp,
                                                                fontWeight: FontWeight.bold,
                                                                color: kSwatchColor

                                                            ),
                                                            title: 'تحقق',
                                                            desc:
                                                                'هل أنت متأكد أنك تريد إنهاء هذه الدورة',
                                                            btnCancelOnPress: () {},
                                                            btnOkOnPress: () {
                                                              cubit.finishCourse(
                                                                  id: finishId,
                                                                  token: CacheHelper
                                                                      .getData(
                                                                          key:
                                                                              'token'));
                                                            },
                                                          )..show();


                                                        },
                                                        child: Text('إنهاء الدورة',style: GoogleFonts.tajawal(fontWeight: FontWeight.bold),),
                                                        color: kSwatchColor,
                                                      ),
                                                    ),
                                                  if (cubit.course.can_finish_course == true)
                                                    SizedBox(width: 20.w),
                                                Expanded(
                                                    child: FlatButton(
                                                      onPressed: () {
                                                        // ignore: avoid_single_cascade_in_expression_statements
                                                        AwesomeDialog(
                                                          context: context,
                                                          dialogType:
                                                              DialogType.QUESTION,
                                                          buttonsTextStyle: GoogleFonts.tajawal(
                                                              fontSize: 40.sp,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white

                                                          ),
                                                          descTextStyle: GoogleFonts.tajawal(
                                                              fontSize: 40.sp,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black

                                                          ),
                                                          titleTextStyle: GoogleFonts.tajawal(
                                                              fontSize: 50.sp,
                                                              fontWeight: FontWeight.bold,
                                                              color: kSwatchColor

                                                          ),
                                                          animType:
                                                              AnimType.BOTTOMSLIDE,
                                                          title: 'تحقق',
                                                          desc:
                                                              'هل أنت متأكد أنك أكملت هذه الدورة',
                                                          btnCancelOnPress: () {},
                                                          btnOkOnPress: () {
                                                            cubit.finishLesson(
                                                                id: id,
                                                                token: CacheHelper
                                                                    .getData(
                                                                        key:
                                                                            'token'));
                                                            ReviewCubit cubit1=ReviewCubit.get(context1);
                                                           cubit1.refreshScreen();
                                                          },
                                                        )..show();
                                                      },
                                                      child: (cubit.course.status ==
                                                              'completed')
                                                          ? Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [



                                                              SizedBox(width: 10.w,),
                                                              Text(
                                                                  ' مكتمل',
                                                                  style: GoogleFonts
                                                                      .tajawal(
                                                                    fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
                                                        SizedBox(width: 10.w,),
                                                        Icon(Icons.check_circle,color: Colors.blueAccent,)
                                                            ],
                                                          )
                                                          : Center(
                                                            child: Text(
                                                                ' مكتمل',
                                                                style: GoogleFonts
                                                                    .tajawal(),
                                                              ),
                                                          ),
                                                      color: kSwatchColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                            );
                          }
                          //currentIndex==1 ===> This Page For Showing Pdfs And Links Of Playlists
                          else {
                            return SingleChildScrollView(
                                child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  //List Of Pdfs
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: ExpansionTile(
                                      title: Text(
                                        'الملفات الملحقة :',
                                        style: GoogleFonts.tajawal(),
                                        textDirection: TextDirection.rtl,
                                      ),

                                      children: [
                                        (  cubit.course.linkPdf.length - 1==0)?Container(
                                          padding: EdgeInsets.symmetric(vertical: 20),
                                          child: Text('لا يوجد ملفات ملحقة',style: GoogleFonts.tajawal(
                                            fontWeight: FontWeight.w500,

                                          ),),
                                        ) :   Container(
                                          height: 800.h,
                                          width: double.infinity,
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: ListView.separated(
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 25.h,
                                                        horizontal: 35.w),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 0.2,
                                                        color: Colors.black26,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 15.w,
                                                        ),
                                                        Expanded(
                                                          //Adding one for index to start 1 instead 0 because index 0 contain unUseful Data
                                                          child: Text(
                                                            '${cubit.course.linkPdf[index + 1].substring(cubit.course.linkPdf[index + 1].lastIndexOf('uploads') + 16, cubit.course.linkPdf[index + 1].indexOf('.pdf'))}',
                                                            style: GoogleFonts
                                                                .tajawal(
                                                                    textStyle:
                                                                        const TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              color: Colors.black,
                                                              //   fontSize: 35.sp
                                                            )),
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //Go To WebView Page
                                                  onTap: () async {
                                                    await launch(
                                                        cubit.course
                                                            .linkPdf[index + 1],
                                                        forceSafariVC: false,
                                                        forceWebView: false);
                                                  },
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) => Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 100.w),
                                                child: Container(
                                                  height: 20.h,
                                                ),
                                              ),
                                              itemCount:
                                                  cubit.course.linkPdf.length - 1,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: 50.h,
                                  ),

                                  //List Of Additional Files and Links
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        ExpansionTile(
                                          title: Text(
                                            'قوائم التشغيل الملحقة',
                                            style: GoogleFonts.tajawal(),
                                            textDirection: TextDirection.rtl,
                                          ),
                                          children: [
                                            (   cubit.course.list.length==0)?Container(
                                              padding: EdgeInsets.symmetric(vertical: 20),
                                              child: Text('لا يوجد ملفات ملحقة',style: GoogleFonts.tajawal(
                                                fontWeight: FontWeight.w500,

                                              ),),
                                            ) :
                                            Container(
                                              height: 400.h,
                                              width: double.infinity,
                                              child: Directionality(
                                                textDirection: TextDirection.rtl,
                                                child: ListView.separated(
                                                  itemBuilder: (context, index) {
                                                    return InkWell(
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                vertical: 20.h,
                                                                horizontal: 35.w),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            width: 0.2,
                                                            color: Colors.black26,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'قائمة التشغيل',
                                                              style: GoogleFonts
                                                                  .tajawal(
                                                                textStyle:
                                                                    TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: Colors
                                                                      .black,
                                                                  //   fontSize: 35.sp
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 15.w,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      onTap: () async {
                                                        await launch(
                                                            'https://www.youtube.com/watch' +
                                                                cubit.course
                                                                    .list[index],
                                                            forceSafariVC: false,
                                                            forceWebView: false);
                                                      },
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) => Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 100.w),
                                                    child: Container(
                                                      height: 20.h,
                                                    ),
                                                  ),
                                                  itemCount:
                                                      cubit.course.list.length,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: 200.h,
                                  ),
                                  //Buttons Of Finish Course And Finish Lesson
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 50.w),
                                    child: Row(
                                      children: [
                                        if (cubit.course.can_finish_course ==
                                            true)
                                          Expanded(
                                            child: MaterialButton(
                                              onPressed: () {
                                                // ignore: avoid_single_cascade_in_expression_statements
                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType: DialogType.QUESTION,
                                                  animType: AnimType.BOTTOMSLIDE,
                                                  title: 'تحقق',
                                                  buttonsTextStyle: GoogleFonts.tajawal(
                                                      fontSize: 40.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white

                                                  ),
                                                  descTextStyle: GoogleFonts.tajawal(
                                                      fontSize: 40.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black

                                                  ),
                                                  titleTextStyle: GoogleFonts.tajawal(
                                                      fontSize: 50.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: kSwatchColor

                                                  ),
                                                  desc:
                                                      'هل أنت متأكد أنك تريد إنهاء هذه الدورة',
                                                  btnCancelOnPress: () {},
                                                  btnOkOnPress: () {
                                                    cubit.finishCourse(
                                                        id: finishId,
                                                        token: CacheHelper.getData(
                                                            key: 'token'));
                                                  },
                                                )..show();
                                              },
                                              child: Text('إنهاء الدورة',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.tajawal(

                                                      fontWeight: FontWeight.bold)),
                                              color: kSwatchColor,
                                            ),
                                          ),
                                         SizedBox(width: 50.w,),
                                        Expanded(
                                          child: MaterialButton(
                                            onPressed: () {
                                              // ignore: avoid_single_cascade_in_expression_statements
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.QUESTION,
                                                animType: AnimType.BOTTOMSLIDE,
                                                title: 'تحقق',
                                                buttonsTextStyle: GoogleFonts.tajawal(
                                                    fontSize: 40.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white

                                                ),
                                                descTextStyle: GoogleFonts.tajawal(
                                                    fontSize: 40.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black

                                                ),
                                                titleTextStyle: GoogleFonts.tajawal(
                                                    fontSize: 50.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: kSwatchColor

                                                ),
                                                desc:
                                                    'هل أنت متأكد أنك أكملت هذه الدورة',
                                                btnCancelOnPress: () {},
                                                btnOkOnPress: () {
                                                  cubit.finishLesson(
                                                      id: id,
                                                      token: CacheHelper.getData(
                                                          key: 'token'));
                                                },
                                              )..show();
                                            },
                                            child: (cubit.course.status ==
                                                    'completed')
                                                ? Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        ' مكتمل',

                                                        style: GoogleFonts.tajawal(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                      SizedBox(
                                                        width: 20.w,
                                                      ),
                                                      Icon(
                                                        Icons.check_circle,
                                                        color: Colors.blueAccent,
                                                      ),
                                                    ],
                                                  )
                                                : Text(
                                                    ' مكتمل',
                                                    style: GoogleFonts.tajawal(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                            color: kSwatchColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ));
                          }
                        },
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      bottomNavigationBar: Container(
                        height: 200.h,
                        child: BottomNavigationBar(
                          selectedLabelStyle:
                              GoogleFonts.tajawal(fontWeight: FontWeight.w800),
                          unselectedLabelStyle:
                              GoogleFonts.tajawal(fontWeight: FontWeight.w600),
                          unselectedItemColor: Colors.grey,
                          currentIndex: cubit.currentIndex,
                          onTap: (index) {
                            cubit.changeBottomNavigationBar(index);
                          },
                          items: cubit.list,
                        ),
                      ),
                    ),
                ),
          );
        },
      ),
    );
  }
}
