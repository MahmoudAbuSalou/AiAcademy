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
  void printLongString(String text) {
    final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((RegExpMatch match) =>   print(match.group(0)));
  }
/// function to parse html content to String
  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    const end = "للتعرف علي الأكاديمية ومن نحن من هنا";

    String parsedString = parse(document.body?.text).documentElement!.text;

    printLongString(parsedString);
    //
    // if(parsedString.contains("للتعرف")) {
    //   print('Contain String');
    //   return parsedString.substring(0,parsedString.indexOf("للتعرف"));
    // }

            return parsedString;
  }
}
