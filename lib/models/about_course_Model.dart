import 'package:html/parser.dart';

class AboutCourseModel {
  late String content;
  late String name;
  dynamic price = 0;
  String image = "";
  late dynamic count_students;
  late dynamic rating;
  late dynamic lesson;
  late dynamic quiz;
  late dynamic status;

  AboutCourseModel.fromJson(Map<String, dynamic> json) {
    content = parseHtmlString(json['content']);
    name = json['name'];
    price = json['price'];
    image = json['image'];
    count_students = json['count_students'];

    lesson = json['course_data']['result']['items']['lesson']['total'];
    quiz = json['course_data']['result']['items']['quiz']['total'];
    status = json['course_data']['status'];

    rating = json['rating'];
  }
/// function to parse html content to String
  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    const end = "للتعرف";
    final String parsedString =
        parse(document.body?.text).documentElement!.text;


    return parsedString;
  }
}
