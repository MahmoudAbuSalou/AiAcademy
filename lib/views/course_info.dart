// ignore_for_file: prefer_is_empty, sized_box_for_whitespace
// ignore: slash_for_doc_comments
/**
 * - this page responsible for display:
 *   - 1- course lessons UI
 *   - 2- course details UI
 *   - 2- course review UI
 *   - 2- add comment and rating UI
 * **/
import 'package:academy/models/lessons.dart';
import 'package:academy/shared/network/local/cachehelper.dart';
import 'package:academy/views/course%20register/course_register.dart';
import 'package:academy/views/login_screen.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/components.dart';
import '../components/const.dart';
import '../components/custom_image.dart';

import '../models/review_model.dart';
import '../shared/components/components.dart';
import 'CourseContent/QuizPage/Quiz.dart';
import 'CourseContent/lessonPage/lessonContent.dart';

import 'CourseInfoCubit/CourseInfo_cubit.dart';
import 'CourseInfoCubit/CourseInfo_state.dart';
import 'course_details_screen.dart';

// ignore: must_be_immutable
class CourseInfo extends StatefulWidget {
  String id;

  CourseInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<CourseInfo> createState() => _CourseInfoState();
}

class _CourseInfoState extends State<CourseInfo> {
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      /// Call Function from class ReviewCubit  When page is Build
      create: (context) => ReviewCubit()
        ..getCourseInfo(
          id: widget.id,
        )
        ..getLessons(id: widget.id)
        ..getReviewCubit(id: widget.id),
      child: BlocConsumer<ReviewCubit, ReviewState>(
          listener: (context, state) {},
          builder: (context, state) {
            ReviewCubit reviewCubit = ReviewCubit.get(context);
            return RefreshIndicator(
                onRefresh: () async {
                  reviewCubit.getLessons(id: widget.id);
                  reviewCubit.getReviewCubit(id: widget.id);
                  reviewCubit.getCourseInfo(id: widget.id);
                },
                child: Scaffold(
                  backgroundColor: Colors.grey,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: reviewCubit.loadInfo == false ||
                            reviewCubit.loadLessons == false
                        ? Container()
                        : reviewCubit.lessonsModel.sections![0].items[0]
                                        .locked ==
                                    false ||
                                reviewCubit.aboutCourseModel.status ==
                                    'finished'
                            ? Container()
                            : reviewCubit.aboutCourseModel.price > 0
                                ? MyButton(
                                    height: 100,
                                    loadSubscribeCourse:
                                        reviewCubit.loadSubscribeCourse,
                                    title: 'أشترك الأن',
                                    width: size.width,
                                    onTap: () {
                                      CacheHelper.getData(key: 'token') == null
                                          ? navigatorTo(context, LoginScreen())
                                          : navigatorTo(
                                              context,
                                              CourseRegister(
                                                  name: reviewCubit
                                                      .aboutCourseModel.name,
                                                  img: reviewCubit
                                                      .aboutCourseModel.image,
                                                  price: reviewCubit
                                                      .aboutCourseModel.price));
                                    })
                                : MyButton(
                                    height: 100,
                                    loadSubscribeCourse:
                                        reviewCubit.loadSubscribeCourse,
                                    title: 'أشترك مجاني',
                                    width: size.width,
                                    onTap: () {
                                      CacheHelper.getData(key: 'token') == null
                                          ? navigatorTo(context, LoginScreen())
                                          : reviewCubit.subscribeCourse(
                                              id: widget.id);
                                    }),
                  ),
                  body: SafeArea(
                    child: Stack(
                      children: [
                        // cover Image
                        (reviewCubit.loadInfo)
                            ? Container(
                                width: size.width,
                                height: size.height * 0.35,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                ),
                                child: FancyShimmerImage(
                                  imageUrl: reviewCubit.aboutCourseModel.image,
                                  errorWidget: Image.network(
                                      'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
                                ),
                              )

                            : Container(
                                width: double.maxFinite,

                                child:FancyShimmerImage(
                                  imageUrl:
                                      'https://i.pinimg.com/originals/07/59/47/075947cd7ad84c38a558070e233808b5.gif',
                                  errorWidget: Image.network(
                                      'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
                                  boxFit: BoxFit.cover,
                                ),

                              ),
                        Column(
                          children: [


                            Expanded(

                              child: Container(
                                height: size.height - 40.h,
                                child: SingleChildScrollView(
                                  child: Container(
                                    width: size.width,
                                    height: size.height,
                                    margin:
                                        EdgeInsets.only(top: size.height * 0.3),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(32),
                                        topRight: Radius.circular(32),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 40, right: 40, left: 40),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomTabBarButton(
                                                title: 'المنهاج',
                                                isActive:
                                                    reviewCubit.activeTabBar ==
                                                        1,
                                                onPress: () {
                                                  reviewCubit
                                                      .ChangeActiveTabBar(1);
                                                },
                                              ),
                                              CustomTabBarButton(
                                                title: 'نبذة عن البرنامج',
                                                isActive:
                                                    reviewCubit.activeTabBar ==
                                                        0,
                                                onPress: () {
                                                  reviewCubit
                                                      .ChangeActiveTabBar(0);

                                                },
                                              ),
                                              CustomTabBarButton(
                                                title: 'التقييمات',
                                                isActive:
                                                    reviewCubit.activeTabBar ==
                                                        2,
                                                onPress: () {
                                                  reviewCubit
                                                      .ChangeActiveTabBar(2);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey.withOpacity(0.6),
                                          thickness: 1.3,
                                          height: 0,
                                        ),
                                        if (reviewCubit.activeTabBar == 0)
                                          reviewCubit.loadInfo == true
                                              ? CourseDetailsScreen(
                                                  aboutCourseModel: reviewCubit
                                                      .aboutCourseModel)
                                              : Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                    ],
                                                  ),
                                                ),
                                        if (reviewCubit.activeTabBar == 1)
                                          reviewCubit.loadLessons == true
                                              ? getCourseContent(
                                                  reviewCubit: reviewCubit,
                                                  autoGenerate:
                                                      reviewCubit.lessonsModel)
                                              : Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                    ],
                                                  ),
                                                ),


                                        if (reviewCubit.activeTabBar == 2)
                                          CacheHelper.getData(key: 'token') ==
                                                  null
                                              ? Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Center(
                                                          child: Text(
                                                              'يرجى الاشتراك اولا لرؤية التعليقات')),
                                                    ],
                                                  ),
                                                )
                                              : reviewCubit.loadReview == true
                                                  ? getReviews(reviewCubit)
                                                  : Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: const [
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                        ],
                                                      ),
                                                    ),

                                      
                                        const SizedBox(
                                          height: 60,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
  ///  function to display Review  UI
  Expanded getReviews(ReviewCubit? reviewCubit) {
    return Expanded(

      /// condition to check if  reviews list contain review or not
      child: reviewCubit!.reviewModel.reviews.length > 0
      /// if true
          ? SingleChildScrollView(
              child: Column(
                children: [
                  // ignore: unnecessary_null_comparison

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reviewCubit.reviewModel.reviews.length,
                    itemBuilder: (context, index) => CustomerReview(
                        reviewModel: reviewCubit.reviewModel.reviews[index]),
                  )
                ],
              ),
            )
      /// else false
          : Padding(
              padding: const EdgeInsets.only(bottom: 30),
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: const Center(
                  child: Text(
                    "لا يوجد تعليقات ",
                    style: TextStyle(
                      fontFamily: 'NotoKufiArabic',
                    ),
                  ),
                ),
              ),
            ),
    );
  }
   ///  function to display Lessons UI
  Expanded getCourseContent(
      {ReviewCubit? reviewCubit, AutoGenerate? autoGenerate}) {
    var size = MediaQuery.of(context).size;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const TitleWithDotIcon(
              title: 'المقررات',
              fontSize: 18,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: autoGenerate!.sections!.length,
              itemBuilder: (context, index) => ExpansionTile(
                tilePadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          autoGenerate.sections![index].title,
                          style: TextStyle(fontSize: 40.sp),
                        ),
                        autoGenerate.checkEnrolled(
                                    autoGenerate.sections![index].items) ==
                                false
                            ? Text(
                                '${autoGenerate.getReviewCount(autoGenerate.sections![index].items)}/${autoGenerate.sections![index].items.length}',
                                style: const TextStyle(
                                  fontFamily: kFontFamily,
                                  color: kSwatchColor,
                                ),
                              )
                            : Text(
                                '${autoGenerate.sections![index].items.length}',
                                style: const TextStyle(
                                  fontFamily: kFontFamily,
                                  color: kSwatchColor,
                                ),
                              )
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: autoGenerate.checkCompleted(
                                        autoGenerate.sections![index].items) ==
                                    true
                                ? const Color(0xff00B706)
                                : Colors.red,
                          ),
                        ),
                        /// function to check if section is complete or not
                        autoGenerate.checkCompleted(
                                    autoGenerate.sections![index].items) ==
                                true
                            ? const Text(
                                ' مكتمل',
                                style: TextStyle(
                                  color: Color(0xff00B706),
                                  fontSize: 12,
                                ),
                              )
                            : const Text(
                                'غير مكتمل',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
                /// loop lessons and Quiz inside Sections
                children: autoGenerate.sections![index].items
                    .asMap()
                    .map(
                      (i, e) => MapEntry(
                          i,
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.2,
                                  color: Colors.black26,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /// number of lessons or Quiz
                                  Text(
                                    '  ${index + 1}.${i + 1}',
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  /// determinate tape of item ( lessons or Quiz)
                                  e.type == 'lp_lesson'
                                      ? const Text(
                                          ' المقرر :',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              overflow: TextOverflow.ellipsis),
                                          maxLines: 1,
                                        )
                                      : const Text(
                                          'الإختبار :',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              overflow: TextOverflow.ellipsis),
                                          maxLines: 1,
                                        ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  /// name of item
                                  Expanded(
                                    child: Text(
                                      e.title,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.black,
                                        //   fontSize: 35.sp
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  /// check if lessons or Quiz is locked or passed or failed
                                  e.locked == true
                                      ? const Icon(
                                          Icons.lock,
                                          color: Colors.black45,
                                          size: 20,
                                        )
                                      : e.status == 'completed' &&
                                              e.type == 'lp_lesson'
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.green,
                                              size: 20,
                                            )
                                          : e.graduation == 'failed' &&
                                                  e.type == 'lp_quiz'
                                              ? const Icon(
                                                  Icons.check,
                                                  color: Colors.red,
                                                  size: 20,
                                                )
                                              : e.graduation == 'passed' &&
                                                      e.type == 'lp_quiz'
                                                  ? const Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                      size: 20,
                                                    )
                                                  : const Icon(
                                                      Icons.check,
                                                      color: Colors.black45,
                                                      size: 20,
                                                    ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () => {
                              if (e.locked == false)
                                {
                                  // if (e.status=='completed')
                                  //   {

                                  navigatorTo(
                                      context,
                                      (e.type != 'lp_lesson')
                                          ?

                                          //QUIZ=CoursePage
                                          QuizPage(
                                              id: e.id.toString(),
                                            )
                                          : WatchCourse(
                                              id: e.id.toString(),
                                              finishId: widget.id,
                                            )),
                                }
                              else
                                {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.WARNING,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: 'تحذير',
                                    desc: 'أنك غير مشترك في هذه الدورة',
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                  )..show()
                                }
                            },
                          )),
                    )
                    .values
                    .toList(),

                //  here inner content
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const TitleWithDotIcon(
                  title: 'اترك تقييم :',
                  fontSize: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RatingBar.builder(
                    initialRating: 1,
                    minRating: 1,
                    itemSize: 24,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: kSwatchColor,
                    ),
                    onRatingUpdate: (rating) {

                      reviewCubit!.ChangeRatingValue(rating.toInt());

                    },
                  ),
                ),
              ],
            ),
            const TitleWithDotIcon(
              title: 'اترك تعليق :',
              fontSize: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: commentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: MyButton(
                  loadSubscribeCourse: '',
                  title: 'إرسال',
                  width: size.width * 0.5,
                  height: 60,
                  onTap: () {
                    /// if token null login before else add rating and comment
                    CacheHelper.getData(key: 'token') == null
                        ? navigatorTo(context, LoginScreen())
                        : reviewCubit!.submitReview(
                            id: widget.id,
                            rate: reviewCubit.ratingValue,
                            title: reviewCubit.aboutCourseModel.name,
                            content: commentController.text);
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomerReview extends StatelessWidget {
  Reviews reviewModel;

  CustomerReview({Key? key, required this.reviewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // user profile image
          CustomImage(
            'https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80',
            radius: 50,
            width: 60,
            height: 60,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      reviewModel.display_name.toString(),
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis, fontSize: 30.sp),
                      maxLines: 2,
                    ),
                    ClientRating(
                      ratingValue: double.parse(reviewModel.rate),
                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    reviewModel.content.toString(),
                    style: TextStyle(
                      fontSize: 35.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClientRating extends StatelessWidget {
  final double ratingValue;

  const ClientRating({Key? key, required this.ratingValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: ratingValue,
      minRating: 1,
      itemSize: 14,
      direction: Axis.horizontal,
      allowHalfRating: true,
      ignoreGestures: false,
      itemCount: 5,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: kSwatchColor,
      ),
      onRatingUpdate: (rating) {

      },
    );
  }
}

class TitleWithDotIcon extends StatelessWidget {
  final String title;
  final double fontSize;

  const TitleWithDotIcon({Key? key, this.fontSize = 16, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
      child: Row(
        children: [
          // SvgPicture.asset('assets/svg/dot.svg'),
          const SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: kFontFamily,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTabBarButton extends StatelessWidget {
  final String title;
  final bool isActive;
  // ignore: prefer_typing_uninitialized_variables
  final onPress;

  const CustomTabBarButton(
      {Key? key, required this.title, required this.isActive, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPress,
          child: AutoSizeText(
            title,
            style: TextStyle(
              color: isActive ? kSecondaryColor : Colors.grey,
              // fontSize: 20,
              fontFamily: kFontFamily,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
        if (isActive)
          Container(
            width: 90,
            height: 2,
            margin: const EdgeInsets.only(bottom: 5),
            color: kSwatchColor,
          ),
      ],
    );
  }
}