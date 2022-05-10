

class courseModel {
    String  image;
    String  name;
    int  price;
    dynamic id;
    final count_students;
    final avatar;
    final nameOwner;
    final rate;
    courseModel({required this.image,required this.id, required this.name,required this.price,required this.count_students,required this.avatar,required this.nameOwner,required this.rate});

    factory courseModel.fromJson(Map<String, dynamic> json) {
        return courseModel(
            image: json['image'],
            id: json['id'],
            name: json['name'], 
            price: json['price'],
            count_students:json['count_students'],
            avatar: json['instructor']['avatar'],
            nameOwner: json['instructor']['name'],
            rate: json['rating']

        );
    }


}