


import '../../models/about_course_Model.dart';
import '../../models/lessons.dart';
import '../../models/review_model.dart';

abstract class ReviewState {}
/// Initial State
class ReviewInitial extends ReviewState {}

///Active Bar State
class ChangeActiveTabBarState extends ReviewState {}

/// Rating State
class ChangeRatingValueState extends ReviewState {}



/// Reviews State
class GetReviewLoading extends ReviewState {}
class GetReviewSuccess extends ReviewState {
  ReviewModel reviewModel ;
  GetReviewSuccess(this.reviewModel);

}
class GetReviewError extends ReviewState {
  // ignore: non_constant_identifier_names
  final String ERROR;

  GetReviewError(this.ERROR);


}



/// Details Course  State
class GetCourseInfoLoading extends ReviewState {}
class GetCourseInfoSuccess extends ReviewState {
  AboutCourseModel aboutCourseModel ;
  GetCourseInfoSuccess(this.aboutCourseModel);

}
class GetCourseInfoError extends ReviewState {
  // ignore: non_constant_identifier_names
  final String ERROR;

  GetCourseInfoError(this.ERROR);


}



/// Add Comment and Rating State
class PostCourseReviewLoading extends ReviewState {}
class PostCourseReviewSuccess extends ReviewState {

  PostCourseReviewSuccess();

}
class PostCourseReviewError extends ReviewState {
  // ignore: non_constant_identifier_names
  final String ERROR;

  PostCourseReviewError(this.ERROR);


}


/// Get Lessons State
class GetLessonsLoading extends ReviewState {}
class GetLessonsSuccess extends ReviewState {

   AutoGenerate ?lessonsModel;
  GetLessonsSuccess(this.lessonsModel);

}
class GetLessonsError extends ReviewState {
  // ignore: non_constant_identifier_names
  final String ERROR;

  GetLessonsError(this.ERROR);


}

/// Enrolled  Course State
class SubscribeCourseLoading extends ReviewState {}
class SubscribeCourseSuccess extends ReviewState {

  SubscribeCourseSuccess();

}
class SubscribeCourseError extends ReviewState {


  SubscribeCourseError();


}
