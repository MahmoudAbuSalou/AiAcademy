import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/about_course_Model.dart';
import '../../../shared/network/local/cachehelper.dart';
import '../../../shared/network/remote/dio_helper.dart';

part 'cubit_image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());
  ///  create instance of class ReviewCubit
  static ImageCubit get(context) => BlocProvider.of(context);

  /// model of course details
  late AboutCourseModel aboutCourseModel;
  bool loadImage = false;

  void getProfileImage({required String id}) {
    emit(GetProfileImageLoading());
    DioHelper.getData(
        url: 'learnpress/v1/courses/$id?v=123123',
        token: CacheHelper.getData(key: 'token'))
        .then((value) {
      aboutCourseModel = AboutCourseModel.fromJson(value.data);
      loadImage = true;
      emit(GetProfileImageSuccess(aboutCourseModel));
    }).catchError((error) {
      emit(GetProfileImageError("ERROR"));
    });
  }
}
