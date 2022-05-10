import 'package:academy/models/Quiz/Object.dart';
import 'package:academy/models/Quiz/Option.dart';
import 'package:academy/shared/network/end_point.dart';

class Questions {
  ObjectModel? object;
  dynamic id;
  dynamic title='';
  dynamic idd;
  dynamic type='';
  dynamic point=0;
  List<Options>? options;
  dynamic ?correct;
  Questions(
      {this.object, this.id,required this.title,required this.type,required this.point, this.options,this.correct});

  Questions.fromJson(json) {

    object =
    json['object'] != null ? new ObjectModel.fromJson(json['object']) : null;
    id = json['id'];
    IDS.add( json['id']);
    title = json['title'];
    type = json['type'];
    point = json['point'];


    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });

    }
  }


}