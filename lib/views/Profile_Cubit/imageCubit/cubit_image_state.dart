part of 'cubit_image_cubit.dart';

@immutable
abstract class ImageState {}

class ImageInitial extends ImageState {}

class GetProfileImageLoading extends ImageState {}
// ignore: must_be_immutable
class GetProfileImageSuccess extends ImageState {
  AboutCourseModel aboutCourseModel ;
  GetProfileImageSuccess(this.aboutCourseModel);


}
// ignore: must_be_immutable
class GetProfileImageError extends ImageState {
  String error;
  GetProfileImageError(this.error);
}

