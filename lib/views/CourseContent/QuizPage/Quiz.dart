import 'dart:async';

import 'package:academy/shared/components/components.dart';
import 'package:academy/shared/components/constants.dart';
import 'package:academy/views/CourseContent/QuizPage/quizCubit/quiz_cubit.dart';

import 'package:academy/views/course_info.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../components/components.dart';
import '../../../components/const.dart';

class QuizPage extends StatefulWidget {
  QuizPage({required this.id}) : super();
  final String id;


  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {



  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => QuizCubit()
            ..getQuiz(id: widget.id, context: context)
            ..startTimer(),
          child: BlocConsumer<QuizCubit, QuizState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              var cubit = QuizCubit.get(context);

              if (cubit.test) {
                //QuizInProgress
                if ((cubit.quiz.results?.result != null && cubit.quiz.results?.status == 'started' )|| cubit.inProgress || cubit.Review) {
                  //To Show Review Screen
                  if (cubit.Review) {
                    return ConditionalBuilder(
                      condition: true,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              MyAppBar(title: 'التقييم'),
                              SizedBox(
                                height: 25.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                width: width,
                                height: 100.h,
                                child: Row(
                                  children: [
                                    SvgPicture.asset('images/post-it.svg'),
                                    SizedBox(
                                      width: width * .015,
                                    ),
                                    Text(
                                      ' راجع أجوبتك لاكتساب المعرفة ',
                                      style: TextStyle(
                                        fontFamily: kFontFamily,
                                        fontSize: 40.sp,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 40.h,
                              ),

                              SizedBox(
                                height: 40.h,
                              ),
                              //QuestionsBuilder
                              Container(
                                height: (cubit.quiz.questions != null)
                                    ? cubit.quiz.questions.length * 580.h - 80.h
                                    : 500.h,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  primary: false,
                                  itemCount: cubit.quiz.questions.length,
                                  itemBuilder: (context, index) {
                                    String x =
                                        cubit.quiz.questions[index].title;

                                    return Column(
                                      children: [
                                        question(
                                          answers: cubit
                                              .quiz.questions[index].options,
                                          count: index + 1,
                                          questionTitle: x,
                                          type:
                                              cubit.quiz.questions[index].type,
                                          point:
                                              cubit.quiz.questions[index].point,
                                          idQues:
                                              cubit.quiz.questions[index].id,
                                          Review: true,
                                        ),
                                        if (index !=
                                            cubit.quiz.questions.length - 1)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 100.w),
                                            child: Container(
                                              height: 2.h,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.sp),
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        if (index !=
                                            cubit.quiz.questions.length - 1)
                                          SizedBox(
                                            height: 30.h,
                                          )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  //To Show Questions Screen 'Quiz'
                  else {
                    return ConditionalBuilder(
                      condition: true,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              MyAppBar(title: 'التقييم'),
                              SizedBox(
                                height: 25.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                width: width,
                                height: 100.h,
                                //color: Colors.grey,
                                child: Row(
                                  children: [
                                    SvgPicture.asset('images/post-it.svg'),
                                    SizedBox(
                                      width: width * .015,
                                    ),
                                    Text(
                                      ' لقد أكملت المقرر ، تحقق من فهمك ',
                                      style: TextStyle(
                                        fontFamily: kFontFamily,
                                        fontSize: 40.sp,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 40.h,
                              ),

                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25.w),
                                    child: const Icon(
                                      Icons.timer_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    formatTime(cubit.start),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 50.sp),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              //QuestionsBuilder
                              Container(
                                height: (cubit.quiz.questions != null)
                                    ? cubit.quiz.questions.length * 580.h - 40.h
                                    : 500.h,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  primary: false,
                                  itemCount: cubit.quiz.questions.length,
                                  itemBuilder: (context, index) {
                                    String x =
                                        cubit.quiz.questions[index].title;

                                    return Column(
                                      children: [
                                        question(
                                          answers: cubit
                                              .quiz.questions[index].options,
                                          count: index + 1,
                                          questionTitle: x,
                                          type:
                                              cubit.quiz.questions[index].type,
                                          point:
                                              cubit.quiz.questions[index].point,
                                          idQues:
                                              cubit.quiz.questions[index].id,
                                          Review: false,
                                        ),
                                        if (index !=
                                            cubit.quiz.questions.length - 1)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 100.w),
                                            child: Container(
                                              height: 2.h,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.sp),
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        if (index !=
                                            cubit.quiz.questions.length - 1)
                                          SizedBox(
                                            height: 30.h,
                                          )
                                      ],
                                    );
                                  },
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(bottom: 50.h),
                                child: Transform.scale(
                                  scaleX: 4.w,
                                  scaleY: 4.h,
                                  child: BorderedButton(
                                      title: 'انهاء الاختبار',
                                      color: kSwatchColor,
                                      onPress: () {
                                        cubit.finishQuiz(widget.id, context);
                                      }),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }
                //toStartQuiz
                else if (cubit.quiz.results?.result == null) {
                  return ConditionalBuilder(
                    builder: (context) => Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                              child: MyAppBar(
                            title: '${cubit.quiz.title}',
                          )),
                          SizedBox(height: 100.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50.0.w),
                            child: Text(
                              'الاختبار',
                              style: GoogleFonts.tajawal(
                                  textStyle: TextStyle(
                                      fontSize: 80.sp,
                                      fontWeight: FontWeight.bold,
                                      color: kSwatchColor)),
                              // textDirection: TextDirection.rtl,
                            ),
                          ),
                          SizedBox(
                            height: 70.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              children: [
                                ListTile(
                                    Icon(
                                      Icons.menu_book,
                                      color: kSwatchColor,
                                    ),
                                    'الأسئلة : ${cubit.quiz.questions.length} '),
                                ListTile(
                                    Icon(
                                      Icons.timer,
                                      color: kSwatchColor,
                                    ),
                                    'المدة : ${cubit.quiz.duration} '),
                                ListTile(
                                    Icon(
                                      Icons.network_cell_outlined,
                                      color: kSwatchColor,
                                    ),
                                    '  علامة النجاح:${cubit.quiz.results!.passingGrade}  '), /*${cubit.quiz.results!.passingGrade}*/
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100.h,
                          ),
                          Center(
                            child: FlatButton(
                              onPressed: () {
                                cubit.startQuiz(widget.id, context);

                                cubit.changeScreen();
                              },
                              child: Text(
                                'بدء',
                                style: GoogleFonts.tajawal(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 45.sp,
                                        fontWeight: FontWeight.bold)),
                              ),
                              color: kSwatchColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    condition: cubit.test,
                  );
                }
                //ResultQuiz
                else if (cubit.quiz.results?.status == 'completed') {
                  var finalResult = cubit.quiz.results!.result;
                  finalResult!.passingGrade =
                      cubit.convert(finalResult.passingGrade!);

                  return Column(
                    children: [
                      MyAppBar(
                        title: 'نتيجة الاختبار',
                      ),
                      SizedBox(
                        height: 200.h,
                      ),
                      Transform.scale(
                        scaleX: 5.w,
                        scaleY: 5.h,
                        child: CircularPercentIndicator(
                          radius: 45.0,
                          lineWidth: 8.0,
                          percent: (finalResult.resul! / 100),
                          center: Text("${finalResult.resul!.ceil()}%"),
                          progressColor: kSwatchColor,
                        ),
                      ),
                      SizedBox(
                        height: 200.h,
                      ),
                      Container(
                        width: 800.w,
                        height: 150.h,
                        decoration: BoxDecoration(
                            color: ((finalResult.resul!) >=
                                    int.parse(finalResult.passingGrade!))
                                ? Colors.green
                                : Colors.red,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(50.sp)),
                        child: Center(
                          child: Text(
                            ((finalResult.resul!) >=
                                    int.parse(finalResult.passingGrade!))
                                ? 'لقد نجحت'
                                : 'لقد أخفقت ',
                            style: GoogleFonts.tajawal(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 70.sp,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 200.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Time Spend',
                                  style: GoogleFonts.tajawal(fontSize: 50.sp),
                                ),
                                Spacer(),
                                Text(
                                  '${finalResult.timeSpend}',
                                  style: GoogleFonts.tajawal(fontSize: 50.sp),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 75.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Points',
                                  style: GoogleFonts.tajawal(fontSize: 50.sp),
                                ),
                                Spacer(),
                                Text(
                                  '${finalResult.userMark}',
                                  style: GoogleFonts.tajawal(fontSize: 50.sp),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 75.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  'الأسئلة',
                                  style: GoogleFonts.tajawal(fontSize: 50.sp),
                                ),
                                Spacer(),
                                Text(
                                  '${finalResult.questionCount}',
                                  style: GoogleFonts.tajawal(fontSize: 50.sp),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 75.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Correct',
                                  style: GoogleFonts.tajawal(fontSize: 50.sp),
                                ),
                                Spacer(),
                                Text(
                                  '${finalResult.questionCorrect}',
                                  style: GoogleFonts.tajawal(fontSize: 50.sp),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 75.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Wrong',
                                  style: GoogleFonts.tajawal(fontSize: 50.sp),
                                ),
                                Spacer(),
                                Text(
                                  '${finalResult.questionWrong}',
                                  style: GoogleFonts.tajawal(fontSize: 50.sp),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 75.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Skipped',
                                  style: GoogleFonts.tajawal(fontSize: 50.sp),
                                ),
                                Spacer(),
                                Text(
                                  '${finalResult.questionEmpty}',
                                  style: GoogleFonts.tajawal(fontSize: 50.sp),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (cubit.quiz.results?.retakeCount > 0 &&
                                  cubit.quiz.results?.retaken <
                                      cubit.quiz.results?.retakeCount)
                              ? Padding(
                                  padding: EdgeInsets.only(right: 40.w),
                                  child: FlatButton(
                                    color: kSwatchColor,
                                    onPressed: () {
                                      cubit.storeAnswers?.clear();
                                      cubit.changeScreen();
                                      cubit.startTimer();
                                      cubit.startQuiz(widget.id, context);
                                    },
                                    child: Text(
                                      'إعادة ${cubit.quiz.results?.retakeCount - cubit.quiz.results?.retaken}',
                                      style: GoogleFonts.tajawal(
                                          color: Colors.white, fontSize: 50.sp),
                                    ),
                                  ),
                                )
                              : Container(),
                          (cubit.quiz.results?.reviewQuestions == true)
                              ? Padding(
                                  padding: EdgeInsets.only(right: 100.w),
                                  child: FlatButton(
                                    onPressed: () {
                                      cubit.fillReviewPage();
                                      cubit.moveToReview();
                                    },
                                    color: kSwatchColor,
                                    child: Text(
                                      'مراجعة',
                                      style: GoogleFonts.tajawal(
                                          color: Colors.white, fontSize: 50.sp),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  );
                }
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ListTile(Widget icon, String Title) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 10.w,
            ),
            Text(
              Title,
              style: GoogleFonts.tajawal(
                  textStyle:
                      TextStyle(fontSize: 35.sp, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
