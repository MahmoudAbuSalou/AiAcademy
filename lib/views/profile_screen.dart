import 'package:academy/views/Profile_Cubit/imageCubit/cubit_image_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academy/shared/components/components.dart';
import 'package:academy/shared/network/local/cachehelper.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/const.dart';
import '../models/ProfileModel.dart';
import 'Profile_Cubit/profile_cubit.dart';
import 'course_info.dart';

class ProfileScreen extends StatefulWidget {


  bool homepage;

  ProfileScreen({Key? key, required this.homepage}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  /// state of user courses
  List textItems = ["الكل", "الغير منتهية", "المنتهية", "نجاح", "فشل"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return BlocProvider(
      create: (context) =>  ProfileCubit(ProfileInitial())..getUserProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          ProfileCubit cubit = ProfileCubit.get(context);


          return ConditionalBuilder(
              condition: cubit.show,
              fallback: (context) =>
              const Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  )),
              builder: (context) {
                return Scaffold(
                  // appBar: AppBar(),
                  appBar: (widget.homepage) ? PreferredSize(
                      preferredSize: Size.fromHeight(0),
                      child: Container()) : const PreferredSize(
                    preferredSize: Size.fromHeight(200),
                    child: MyAppBar(title: "الملف الشخصي"),

                  ),
                  body: Column(
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
                                  (index) =>
                                  AppBarItem(
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
                      Expanded(
                        child: SingleChildScrollView(
                          child: getCoursesInfo(cubit.profileModel.courses!,

                          ),
                        ),
                      ),
                    ],
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
    List <Widget>Screens = [
      AllCourses(course: allCourse), // index = 0
      AllCourses(course: course.in_Progress), // index = 1
      AllCourses(course: course.finished),

      AllCourses(course: course.passed),
      AllCourses(course: failed)
    ];


    return Container(
      child: Screens[selectedIndex],
    );
  }
}

class AppBarItem extends StatelessWidget {
  final String title;
  final bool isSelected;

  // ignore: prefer_typing_uninitialized_variables
  final onPress;

  const AppBarItem({Key? key,
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

  AllCourses({Key? key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60.h),
      child: ListView.separated(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) =>
            CourseItemCard(
              id: course![index]?.id,
              imageUrl: '',
              title: course![index]?.title,
              endTime: course![index]?.endTime,

              Expiration_time: course![index]?.expiration,
              results: course![index]?.results,
            ),
        separatorBuilder: (context, index) =>
            Container(

              height: 35.h,
            ),
        itemCount: course!.length,),
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
    var size = MediaQuery
        .of(context)
        .size;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>CourseInfo(id: id.toString()) ,));

      },
      child: BlocProvider(
        create: (context) =>
        ImageCubit()
          ..getProfileImage(id: id),
        child: BlocConsumer<ImageCubit, ImageState>(
          listener: (context, state) {},
          builder: (context, state) {
            ImageCubit cubit = ImageCubit.get(context);

            return Container(

              margin: const EdgeInsets.only(bottom: 5, right: 15, left: 20),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: size.width,
              height: size.height * 0.2,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 8),
                  ),
                ],
                border: Border.all(color:kSwatchColor,width: 1),

              ),

              child: Row(

                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: cubit.loadImage ? FancyShimmerImage(
                        imageUrl: cubit.aboutCourseModel.image,
                        boxFit: BoxFit.fill,
                        errorWidget: Image.network(
                            'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
                      ) : Container(),

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
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 5),
                                  child: Text(
                                      title,
                                      maxLines: 2,
                                      style: GoogleFonts.tajawal(
                                        textStyle: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.blueGrey,
                                          fontSize: 40.sp,
                                          fontFamily: kFontFamily,
                                          fontWeight: FontWeight.bold,
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
                                    start: 10, top: 0, bottom: 0),
                                child: Row(

                                  children: [
                                    SvgPicture.asset(
                                      'images/result.svg',
                                      width: 60.w,
                                      height: 60.h,

                                    ),
                                    SizedBox(width: 20.w,),

                                    Text(
                                      "النتيجة : " "%$results ",
                                      style: GoogleFonts.tajawal(
                                        fontSize: 35.sp

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding:
                                const EdgeInsetsDirectional.only(
                                    start: 8, bottom: 8),
                                height: 30,
                                child: endTime is! String
                                    ? Row(
                                  children: [
                                    Icon(Icons.done, color: Colors.blueGrey,),
                                    SizedBox(width: 20.w,),
                                    AutoSizeText("تاريخ الانتهاء : _",
                                      style: GoogleFonts.tajawal(
                                          fontSize: 35.sp
                                      ),),
                                  ],
                                )
                                    : Row(
                                  children: [
                                    Icon(Icons.done, color: Colors.blueGrey,),
                                    SizedBox(width: 20.w,),
                                    AutoSizeText(
                                      "تاريخ الانتهاء : " "${endTime.substring(
                                          0, 10)}",
                                      maxLines: 2
                                      , style: GoogleFonts.tajawal(
                                        fontSize: 35.sp
                                    ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 8),
                                  height: 25,
                                  child: Expiration_time is! String ?
                                  Row(
                                    children: [
                                      Icon(Icons.timer_off_sharp,
                                        color: Colors.blueGrey,),
                                      SizedBox(width: 20.w,),
                                      Text("تاريخ الصلاحية : _",
                                        style: GoogleFonts.tajawal(fontSize: 35.sp
                                        ),),
                                    ],
                                  )
                                      : Row(
                                    children: [
                                      Icon(Icons.timer_off_sharp,
                                        color: Colors.blueGrey,),
                                      SizedBox(width: 20.w,),
                                      AutoSizeText(
                                        "تاريخ الصلاحية : "
                                            "${Expiration_time.substring(
                                            0, 10)}",
                                        maxLines: 2, style: GoogleFonts.tajawal(
                                          fontSize: 35.sp
                                      ),
                                      ),
                                    ],
                                  )),
                            )
                          ]),
                    ),
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


class MyAppBar extends StatelessWidget {
  final String title;

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
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




