class ProfileModel {
  Courses? courses;

  ProfileModel.fromJson(Map<String, dynamic>? json) {
    courses = Courses.fromJson(json!['courses']['content']['enrolled']);
  }
}

class Courses {
  List<SingleCourse> finished = [];
  List<SingleCourse> passed = [];
  // ignore: non_constant_identifier_names
  List<SingleCourse> in_Progress = [];

  Courses.fromJson(Map<String, dynamic>? json) {
    if (json!['finished'] != null) {
      json['finished'].forEach((element) {
        finished.add(SingleCourse.fromJson(element));
      });
    }
    if (json['passed'] != null) {
      json['passed'].forEach((element) {
        passed.add(SingleCourse.fromJson(element));
      });
    }
    if (json['in-progress'] != null) {
      json['in-progress'].forEach((element) {
        in_Progress.add(SingleCourse.fromJson(element));
      });
    }
  }
}

class SingleCourse {
  dynamic id;
  dynamic title;
  dynamic graduation;
  dynamic endTime;
  dynamic expiration;
  dynamic results;

  SingleCourse.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];

    title = json['title'];
    graduation = json['graduation'];
    endTime = json['end_time'];
    expiration = json['expiration'];
    results = json['results']['result'];
  }
}
