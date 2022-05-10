
import '../../models/courses/course.dart';

late List <courseModel> coursesGlobal=[];

String getImageUrl(String id) {
  String img = 'https://aiacademy.info/wp-content/uploads/2015/12/bachelor-degree-of-business-admin-768x512.jpg';
  coursesGlobal.forEach((element) {
    // print("id Course : $id  idCourses : ${element.id}");
    if (element.id.toString() == id) {
      img = element.image;
    }
  });
  //print("ImageURL :  "+img);
  return img;
}

const categoriesAcademyProgrammes = 'wp/v2/course_category/';

const coursesById='learnpress/v1/courses?category=';
const Search='learnpress/v1/courses?search=';
const LOGIN = 'learnpress/v1/token';
const PROFILE = 'learnpress/v1/users/';
const Review = 'learnpress/v1/courses/';
 List IDS=[];