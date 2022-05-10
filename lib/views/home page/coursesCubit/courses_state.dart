part of 'courses_cubit.dart';


abstract class CoursesState {}

class CoursesInitial extends CoursesState {}
class GetDataSuccessAcademyCourses extends CoursesState{}
class GetDataErrorAcademyCourses extends CoursesState{}
class GetDataLoadingAcademyCourses extends CoursesState{}

class GetCountSuccess extends CoursesState{}
class GetCountError extends CoursesState{}
class GetCountLoading extends CoursesState{}