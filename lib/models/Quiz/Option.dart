class Options {
  String? title;
  String? value;
  String? isTrue;
  dynamic uid;

  Options({this.title, this.value, this.isTrue, this.uid});

  Options.fromJson(json) {
    title = json['title'];
    value = json['value'];
    isTrue = json['is_true'];
    uid = json['uid'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['value'] = this.value;
    data['is_true'] = this.isTrue;
    data['uid'] = this.uid;
    return data;
  }
}