class ObjectModel {
  String? sQuestionType;
  String? objectType;

  ObjectModel({this.sQuestionType, this.objectType});

  ObjectModel.fromJson(Map<String, dynamic> json) {
    sQuestionType = json['_question_type'];
    objectType = json['object_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_question_type'] = this.sQuestionType;
    data['object_type'] = this.objectType;
    return data;
  }
}