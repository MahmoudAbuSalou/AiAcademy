// ignore: slash_for_doc_comments
/**
 *   - this cubit use in course info Page
 *   - this cubit responsible:
 *    -1-  get course details
 *    -2-  get course lessons
 *    -3-  get course review
 *    -3-  add comment and rating to specific course
 * */

import 'package:academy/shared/components/components.dart';
import 'package:academy/shared/components/constants.dart';
import 'package:academy/shared/network/local/cachehelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academy/models/review_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../models/about_course_Model.dart';
import '../../models/lessons.dart';
import '../../shared/network/remote/ExceptionHandler.dart';
import '../../shared/network/remote/dio_helper.dart';
import 'CourseInfo_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());

  ///  create instance of class ReviewCubit
  static ReviewCubit get(context) => BlocProvider.of(context);

  /// Controller for pagination
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  /// this variable describe number of page that contain courses
  int countPagination = 1;

  /// model of course details
  late AboutCourseModel aboutCourseModel;

  /// model of course review
  late ReviewModel reviewModel;

  /// model of course lessons
  late AutoGenerate lessonsModel;

  /// default value for index of  bottom navigation bar
  int activeTabBar = 1;

  /// default value for  rating => (  default is one stars )
  int ratingValue = 1;

  // ignore: slash_for_doc_comments
  /***
   *  this variables check if data load successfully  from Api
   *  and convert from json to class model successfully
   *
   * */
  bool loadInfo = false;
  bool loadLessons = false;
  bool loadReview = false;
  bool loadReviewSubmit = false;
  String loadSubscribeCourse = '';
  String message = "";

  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  void ChangeActiveTabBar(int index) {
    activeTabBar = index;
    emit(ChangeActiveTabBarState());
  }

  // ignore: non_constant_identifier_names
  void ChangeRatingValue(int index) {
    ratingValue = index;
    emit(ChangeRatingValueState());
  }

  ///   get review of course
  void getReviewCubit({required String id}) {
    emit(GetReviewLoading());

    DioHelper.getData(
            url: 'learnpress/v1/review/course/$id?&per_page=100',
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      reviewModel = ReviewModel.fromJson(value.data);
      loadReview = true;

      emit(GetReviewSuccess(reviewModel));
    }).catchError((error) {
      emit(GetReviewError(""));
    });
  }

  ///   get course Details
  void getCourseInfo({required String id}) {
    emit(GetCourseInfoLoading());
    DioHelper.getData(
            url: 'learnpress/v1/courses/$id',
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      aboutCourseModel = AboutCourseModel.fromJson(value.data);
      loadInfo = true;
      emit(GetCourseInfoSuccess(aboutCourseModel));
    }).catchError((error) {
      emit(GetCourseInfoError("ERROR"));
    });
  }

  ///  Add Comment and Rating To Course
  void submitReview(
      {required String id,
      required int rate,
      required String title,
      required String content}) {
    emit(PostCourseReviewLoading());
    DioHelper.postData(
            url: 'learnpress/v1/review/submit',
            data: {
              'id': int.parse(id),
              'rate': rate,
              'title': title,
              'content': content,
            },
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      loadReviewSubmit = true;
      showToast(
          msg: 'سوف يظهر تعليقك بعد ان تتم مراجعته', state: ToastState.SUCCESS);

      emit(PostCourseReviewSuccess());
    }).catchError((error) {
      // ignore: non_constant_identifier_names
      String ERROR = exceptionsHandle(error: error);
      showToast(msg: ERROR, state: ToastState.ERROR);

      emit(PostCourseReviewError(ERROR));
    });
  }

  ///  Get Course Lessons
  void getLessons({required String id}) {
    emit(GetLessonsLoading());

    DioHelper.getData(
            url: 'learnpress/v1/courses/$id',
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      lessonsModel = AutoGenerate.fromJson(value.data);
      loadLessons = true;

      emit(GetLessonsSuccess(lessonsModel));
    }).catchError((error) {
      emit(GetLessonsError("ERROR"));
    });
  }

  ///  Enrolled Course
  void subscribeCourse({required String id}) {
    loadSubscribeCourse = 'load';
    emit(SubscribeCourseLoading());

    DioHelper.postData(
            url: 'learnpress/v1/courses/enroll/',
            data: {"id": id},
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      loadSubscribeCourse = 'done';
      showToast(msg: 'تهانينا! تم الاشتراك بنجاح..', state: ToastState.SUCCESS);

      /// update Status of lesson after enrolled course
      getLessons(id: id);

      emit(SubscribeCourseSuccess());
    }).catchError((error) {
      emit(SubscribeCourseError());
    });
  }
}
