
class AutoGenerate {
  AutoGenerate({this.sections});


  List<Sections> ?sections;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((element) {
        sections!.add(Sections.fromJson(element));
      });
    }
  }

  int getReviewCount( List<Items> items){
    int count = 0;
    items.forEach((element) {
      if(element.status == 'completed')
        count++;
    });
    return count;
  }
  bool checkEnrolled(List<Items> items){
    bool check = true;
    items.forEach((element) {
      if(element.locked ==false )
        check = false;
    });
    return check;
  }

  bool checkCompleted(List<Items> items){
    bool check = true;
    items.forEach((element) {
      if(element.status !='completed' )
        check = false;
    });
    return check;
  }
}

class Sections {
  Sections({
    required this.id,
    required this.title,
    required this.courseId,
    required this.description,
    required this.order,
    required this.percent,
    required this.items,
  });

  dynamic id;
  dynamic title;
  dynamic courseId;
  dynamic description;
  dynamic order;
  dynamic percent;

  List<Items> items =[];

  Sections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    courseId = json['course_id'];
    description = json['description'];
    order = json['order'];
    percent = json['percent'];
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();
  }


}

class Items {
  Items({
    required this.id,
    required this.type,
    required this.title,
    required this.preview,
    required this.duration,
    required this.graduation,
    required this.status,
    required this.locked,
  });

  late final int id;
  late final String type;
  late final String title;
  late final bool preview;
  late final String duration;
  late final String graduation;
  late final String status;
  late final bool locked;

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    preview = json['preview'];
    duration = json['duration'];
    graduation = json['graduation'];
    status = json['status'];
    locked = json['locked'];
  }
}

