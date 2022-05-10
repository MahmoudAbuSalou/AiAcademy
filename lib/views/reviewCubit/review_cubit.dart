import 'dart:convert';

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

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());

  static ReviewCubit get(context) => BlocProvider.of(context);
  RefreshController refreshController = RefreshController(initialRefresh: false);
  int countPagination=1;
  late AboutCourseModel aboutCourseModel;
    late ReviewModel reviewModel;
     late AutoGenerate lessonsModel;
  int activeTabBar = 1;
  int ratingValue = 1;
  bool loadInfo = false;
  bool loadLessons = false;
  bool loadReview = false;
  bool loadReviewSubmit = false;
  String loadSubscribeCourse = '';
  String message = "";

  void ChangeActiveTabBar(int index) {
    activeTabBar = index;
    emit(ChangeActiveTabBarState());
  }

  void ChangeRatingValue(int index) {
    ratingValue = index;
    emit(ChangeRatingValueState());
  }

  void getReviewCubit({required String id}) {
    // url: 'learnpress/v1/review/course/$id'

      emit(GetReviewLoading());

    DioHelper.getData(
            url:'learnpress/v1/review/course/$id?&per_page=100',
        token: CacheHelper.getData(key: 'token')
    )
        .then((value) {

      reviewModel = ReviewModel.fromJson(value.data);
             loadReview=true;

      emit(GetReviewSuccess(reviewModel));
    }).catchError((error) {

      print(error);
      emit(GetReviewError(""));
    });
  }

  void getCourseInfo({required String id}) {
    emit(GetCourseInfoLoading());
    DioHelper.getData(
            url: 'learnpress/v1/courses/$id',
            token: CacheHelper.getData(key: 'token'))
        .then((value) {

      aboutCourseModel = AboutCourseModel.fromJson(value.data);
     print(aboutCourseModel.price);
     print(aboutCourseModel.status);
      print('sale');
      loadInfo = true;
      emit(GetCourseInfoSuccess(aboutCourseModel));

    }).catchError((error) {
      String ERROR = exceptionsHandle(error: error);
      emit(GetCourseInfoError("ERROR"));
    });
  }

  void submitReview({required String id,
    required int rate,
    required String title,
    required String content}) {
    //url:'learnpress/v1/review/submit'
    print("id     : " + id);
    print("rate   : " + rate.toString());
    print("tittle : " + title);
    print("content: " + content);
    emit(PostCourseReviewLoading());

    DioHelper.postData(
            url:
               'learnpress/v1/review/submit',
            data: {
              'id': int.parse(id),
              'rate': rate,
              'title': title,
              'content': content,
            },
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print(value.data);
            loadReviewSubmit = true;
      showToast(msg: 'سوف يظهر تعليقك بعد ان تتم مراجعته', state: ToastState .SUCCESS);

      emit(PostCourseReviewSuccess());
    }).catchError((error) {
      String ERROR = exceptionsHandle(error: error);
      showToast(msg: ERROR, state: ToastState.ERROR);

      emit(PostCourseReviewError(ERROR));
    });
  }

  void getLessons({required String id}) {
    emit(GetLessonsLoading());

    DioHelper.getData(
            url: 'learnpress/v1/courses/$id',
            token: CacheHelper.getData(key: 'token'))
        .then((value) {


    lessonsModel =   AutoGenerate.fromJson(value.data);



    loadLessons=true;

     emit(GetLessonsSuccess(lessonsModel));
    }).catchError((error) {
      // print(error);
      // String ERROR = exceptionsHandle(error: error);

      emit(GetLessonsError("ERROR"));
    });
  }
  void subscribeCourse({required String id}) {
    loadSubscribeCourse = 'load';
    emit(SubscribeCourseLoading());
    print(CacheHelper.getData(key: 'token'));
    DioHelper.postData(
            url: 'learnpress/v1/courses/enroll/',
            data: {
              "id": id
            },
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
         loadSubscribeCourse='done';
          showToast(msg: 'تهانينا! تم الاشتراك بنجاح..', state: ToastState.SUCCESS);
             getLessons(id: id);


     emit(SubscribeCourseSuccess());
    }).catchError((error) {
     print(error);
      emit(SubscribeCourseError());
    });
  }




}
// /wp-json/learnpress/v1/courses/id_course
//'learnpress/v1/courses?learned=true&include=$id'