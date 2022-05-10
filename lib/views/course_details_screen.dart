
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../components/const.dart';
import '../models/about_course_Model.dart';

// ignore: must_be_immutable
class CourseDetailsScreen extends StatelessWidget {
  AboutCourseModel aboutCourseModel;
  CourseDetailsScreen({Key? key,required this.aboutCourseModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CourseDetailsSection(aboutCourseModel:aboutCourseModel),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleText(title:'لمحة عن الكورس'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      aboutCourseModel.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: kFontFamily,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TitleText(title: 'تعريف التخصص'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      aboutCourseModel.content,
                      style: TextStyle(
                        fontSize: 35.sp,
                        fontFamily: kFontFamily,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                  // SizedBox(height:50,),

                ],
              ),
            ],
          ),
        ),
      ),
    );
    // ),
    // );
  }
}

/*
*
*
 */
class SubtitleText extends StatelessWidget {
  final String text;

  const SubtitleText({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          SvgPicture.asset('assets/svg/dot.svg'),
          const SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontFamily: kFontFamily,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CourseDetailsSection extends StatelessWidget {
  AboutCourseModel aboutCourseModel;
  CourseDetailsSection({
    Key? key,required this.aboutCourseModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleText(
          title: 'تفاصيل الكورس',
        ),
        CourseDetailsRow(
          iconUrl: 'assets/svg/video.svg',
          title: 'المقررات : ',
          value: aboutCourseModel.lesson,
        ),
        CourseDetailsRow(
          iconUrl: 'assets/svg/subject.svg',
          title: 'الإختبارات : ',
          value: aboutCourseModel.quiz,
        ),

        CourseDetailsRow(
          iconUrl: 'assets/svg/online-education.svg',
          title: 'عدد الطلاب : ',
          value: aboutCourseModel.count_students,
        ),
      ],
    );
  }
}

class TitleText extends StatelessWidget {
  final String title;

  const TitleText({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          '- ',
          style: TextStyle(
            fontSize: 30,
            color: Colors.red,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontFamily: kFontFamily,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            color: kSwatchColor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class CourseDetailsRow extends StatelessWidget {
  final String iconUrl;
  final String title;
  final dynamic value;

  const CourseDetailsRow(
      {Key? key,
        required this.iconUrl,
        required this.title,
        required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [

          const SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontFamily: kFontFamily,
              color: Colors.black.withOpacity(0.7),

            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 16,
              fontFamily: kFontFamily,
              color: Colors.black.withOpacity(0.7),
            ),

          ),
        ],
      ),
    );
  }
}
