part of 'course_content_cubit.dart';


abstract class CourseContentState {}

class CourseContentInitial extends CourseContentState {}
class GetDataSuccessWatchCourse extends CourseContentState{}
class GetDataErrorWatchCourse extends CourseContentState{}
class GetDataLoadingWatchCourse extends CourseContentState{}
class loadingFinishLesson extends CourseContentState{}
class loadingFinishCourse extends CourseContentState{}
class SuccessFinishLesson extends CourseContentState{}
class SuccessFinishCourse extends CourseContentState{}
class ErrorFinishLesson extends CourseContentState{}
class ErrorFinishCourse extends CourseContentState{}
class ChangeBottomNavigationBar extends CourseContentState{}