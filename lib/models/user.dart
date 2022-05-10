class UserModel {
  String? userId;
  String? userLogin;
  String? email;
  String? token;
  String? user_display_name;

  UserModel(
      {required this.userId,
      required this.user_display_name,
      required this.email,
      required this.userLogin});

  UserModel.fromJson(Map<String, dynamic>? json) {
    userId = json!['user_id'];
    token = json['token'];
    userLogin = json['user_login'];
    email = json['user_email'];
    user_display_name = json['user_display_name'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = userId;
    data['token'] = token;
    data['user_login'] = userLogin;
    data['user_email'] = email;
    data['user_display_name'] = user_display_name;

    return data;
  }
}

