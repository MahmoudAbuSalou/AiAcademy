part of 'review_cubit.dart';


abstract class ReviewState {}
//// Initial State
class ReviewInitial extends ReviewState {}

//Active Bar State
class ChangeActiveTabBarState extends ReviewState {}
//Rating State
class ChangeRatingValueState extends ReviewState {}

// Review State
class GetReviewLoading extends ReviewState {}
class GetReviewSuccess extends ReviewState {
  ReviewModel reviewModel ;
  GetReviewSuccess(this.reviewModel);

}
class GetReviewError extends ReviewState {
  final String ERROR;

  GetReviewError(this.ERROR);


}

//CourseInfo State
class GetCourseInfoLoading extends ReviewState {}
class GetCourseInfoSuccess extends ReviewState {
  AboutCourseModel aboutCourseModel ;
  GetCourseInfoSuccess(this.aboutCourseModel);

}
class GetCourseInfoError extends ReviewState {
  final String ERROR;

  GetCourseInfoError(this.ERROR);


}

// Add Comment and Rating State
class PostCourseReviewLoading extends ReviewState {}
class PostCourseReviewSuccess extends ReviewState {

  PostCourseReviewSuccess();

}
class PostCourseReviewError extends ReviewState {
  final String ERROR;

  PostCourseReviewError(this.ERROR);


}

// Get Lessons State
class GetLessonsLoading extends ReviewState {}
class GetLessonsSuccess extends ReviewState {

   AutoGenerate ?lessonsModel;
  GetLessonsSuccess(this.lessonsModel);

}
class GetLessonsError extends ReviewState {
  final String ERROR;

  GetLessonsError(this.ERROR);


}

//Subscribe Course State
class SubscribeCourseLoading extends ReviewState {}
class SubscribeCourseSuccess extends ReviewState {

  SubscribeCourseSuccess();

}
class SubscribeCourseError extends ReviewState {


  SubscribeCourseError();


}
