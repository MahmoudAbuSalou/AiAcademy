class ReviewCourseModel {
  int? idCourse;
  int? rate;
  String? tittle;
  String? content;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = idCourse;
    data['rate'] = rate;
    data['tittle'] = tittle;
    data['content'] = content;
    return data;
  }
}
