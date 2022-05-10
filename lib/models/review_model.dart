class ReviewModel {
  String? status;
  String? message;
  List<Reviews> reviews = [];

  ReviewModel.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
    json['data']['reviews']['reviews'].forEach((element) {
      if(element!= null)
        reviews.add(Reviews.fromJson(element));
    });
  }
}

class Reviews {
  String? display_name;
  String? content;
  dynamic rate;

  Reviews.fromJson(Map<String, dynamic>? json) {
    display_name = json!['display_name'];
    content = json['content'];
    rate = json['rate'];
  }
}
