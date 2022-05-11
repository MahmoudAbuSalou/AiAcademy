import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academy/shared/components/components.dart';
import 'package:academy/shared/network/local/cachehelper.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/const.dart';
import '../models/ProfileModel.dart';
import 'Profile_Cubit/profile_cubit.dart';
import 'course_info.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  /// state of user courses
  List textItems = ["الكل", "الغير منتهية", "المنتهية", "نجاح", "فشل"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) =>ProfileCubit(ProfileInitial())..getUserProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          ProfileCubit cubit = ProfileCubit.get(context);



          return ConditionalBuilder(
              condition: cubit.show,
              fallback: (context) => const Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  )),
              builder: (context) {
                return Scaffold(
                  // appBar: AppBar(),
                  appBar:const PreferredSize(
                    preferredSize: Size.fromHeight(200),
                    child: MyAppBar(title: "الملف الشخصي"),

                  ),
                  body: SingleChildScrollView(

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            textDirection: TextDirection.rtl,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ...List.generate(
                                5,
                                    (index) => AppBarItem(
                                  title: textItems[index],
                                  onPress: () {

                                      selectedIndex = index;
                                      cubit.changeScreen(index);

                                  },
                                  isSelected: selectedIndex == index,
                                ),
                              ),
                            ],
                          ),
                        ),
                       getCoursesInfo(cubit.profileModel.courses!,

                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  Widget getCoursesInfo(Courses course) {

    List allCourse = [...course.finished, ...course.in_Progress];

    /// get course that user not passed
    List failed = allCourse
        .where((item) =>
    (item.graduation != "passed" && item.graduation != "in-progress"))
        .toList();
    List <Widget>Screens=[
     AllCourses(course: allCourse), // index = 0
     AllCourses(course: course.in_Progress), // index = 1
     AllCourses(course: course.finished),

      AllCourses(course:course.passed),
     AllCourses(course: failed)
    ];


     return Container(
       child: Screens[selectedIndex],
     );
    // return IndexedStack(
    //   index: selectedIndex,
    //
    //   children: [
    //     AllCourses(course: allCourse), // index = 0
    //     AllCourses(course: course.in_Progress), // index = 1
    //      AllCourses(course: course.finished),
    //
    //     AllCourses(course: course.passed),
    //     AllCourses(course: failed),
    //   ],
    // );
  }
}

class AppBarItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  // ignore: prefer_typing_uninitialized_variables
  final onPress;

  const AppBarItem(
      {Key? key,
        required this.title,
        required this.onPress,
        required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: onPress,
        child: Column(
          children: [
            // ignore: avoid_unnecessary_containers
            Container(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.tajawal(
                    textStyle: const TextStyle(
                      color: kSecondaryColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: kFontFamily,
                    ),
                  )
                ),
              ),
            ),
            if (isSelected)
              Container(
                height: 3,
                width: 45,
                color: kSwatchColor,
                margin: const EdgeInsets.only(top: 3),
              ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AllCourses extends StatelessWidget {
  List<dynamic>? course;

  AllCourses({Key? key,  this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     print('here');
    return ListView.builder(
clipBehavior: Clip.antiAliasWithSaveLayer,
      itemCount: course!.length,
      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => CourseItemCard(
        id: course![index]?.id,
        imageUrl: '',
        title: course![index]?.title,
        endTime: course![index]?.endTime,

        Expiration_time: course![index]?.expiration,
        results: course![index]?.results,
      ),
    );
  }
}

// ignore: must_be_immutable
class CourseItemCard extends StatelessWidget {
  final String imageUrl;
  final String id;
  final String title;
  dynamic endTime;
  // ignore: non_constant_identifier_names
  final dynamic Expiration_time;
  final dynamic results;

  CourseItemCard({
    Key? key,
    required this.id,
    required this.title,
    required this.results,
    required this.endTime,
    // ignore: non_constant_identifier_names
    required this.Expiration_time,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        navigatorTo(context, CourseInfo(id: id.toString()));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, right: 15, left: 20),
        width: size.width,
        height: size.height * 0.25,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(

          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: size.width * 0.33,

              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: [
                      const SizedBox(height: 3),
                      Expanded(
                        child: Center(
                          child: Container(
                            padding: const EdgeInsetsDirectional.only(start: 5),
                            child: Text(
                              title,
                              maxLines: 1,
                              style: GoogleFonts.tajawal(
                                textStyle: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: kSwatchColor,
                                  fontSize: 16,
                                  fontFamily: kFontFamily,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsetsDirectional.only(
                              start: 10, top: 7, bottom: 8),
                          child: Text(
                            "النتيجة:" "%$results ",
                            style: GoogleFonts.tajawal(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding:
                          const EdgeInsetsDirectional.only(start: 8, bottom: 12),
                          height: 30,
                          child: endTime is! String
                              ?  Text("تاريخ الانتهاء: _",style: GoogleFonts.tajawal(),)
                              : AutoSizeText(
                            "تاريخ الانتهاء : " "${endTime.substring(0, 10)}",
                            maxLines: 2
                              ,style: GoogleFonts.tajawal(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            width: double.infinity,
                            padding: const EdgeInsetsDirectional.only(start: 2),
                            height: 30,
                            child: Expiration_time is! String ?
                             Text("تاريخ الصلاحية: _",style: GoogleFonts.tajawal(),)
                                :AutoSizeText(
                              "تاريخ الصلاحية: "
                                  "${Expiration_time.substring(0, 10)}",
                              maxLines: 2,style: GoogleFonts.tajawal(),
                            )),
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoursesCountContainer extends StatelessWidget {
  final int count;
  final String title;

  const CoursesCountContainer(
      {Key? key, required this.count, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xff32504F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
                child: Text(
                  count.toString(),
                  style: GoogleFonts.tajawal(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )
                  )
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: AutoSizeText(
              title,
              textDirection: TextDirection.rtl,
              maxLines: 2,
              style:GoogleFonts.tajawal(
                textStyle:  const TextStyle(
                  color: Color(0xff32504F),
                  fontFamily: kFontFamily,
                  fontSize: 14,
                ),
              )

            ),
          ),
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  final String title;

  const MyAppBar({Key? key, required this.title}) : super(key: key);

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
                  style: GoogleFonts.tajawal(
                    textStyle: const TextStyle(
                      color: kPrimaryColor,
                      fontSize: 18,
                      fontFamily: kFontFamily,
                    ),
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
