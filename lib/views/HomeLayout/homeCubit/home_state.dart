part of 'home_cubit.dart';


abstract class HomeState {}

class HomeInitial extends HomeState {}
class ChangBottomBarIconState extends HomeState{}
class GetDataSuccessAcademyProgrammes extends HomeState{}
class GetDataErrorAcademyProgrammes extends HomeState{}
class GetDataLoadingAcademyProgrammes extends HomeState{}
class Net extends HomeState{}