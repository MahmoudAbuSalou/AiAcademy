import 'package:academy/models/Quiz/resault.dart';

import '../../shared/network/end_point.dart';
import 'Questions.dart';

class QuizModel{
  dynamic id=0;
  dynamic title;
  dynamic duration;
  dynamic i=0;
  late List<Questions> questions;
  Res ? results;
  dynamic ? idCourse;


  QuizModel.fromJson( json){
    id=json['id'];
    title=json['name'];
    idCourse=json['assigned']['course']['id'];
   duration=json['duration'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      IDS.clear();
      json['questions'].forEach((v) {
        questions.add( Questions.fromJson(v));

      });
  }
      results =
      json['results'] != null ?  Res.fromJson(json['results']) : null;

  }
}
//ResultsIntrnal
class Results {
  dynamic mark;
  dynamic userMark;
  dynamic questionCount;
  dynamic questionEmpty;
  dynamic questionAnswered;
  dynamic questionWrong;
  dynamic questionCorrect;
  dynamic status;
  dynamic  resul;

  dynamic timeSpend;
  dynamic passingGrade;
  dynamic userItemId;
  dynamic graduation;
  dynamic graduationText;
  dynamic  total_time;
  List <Ques>  questions=[];


  Results(
      {this.mark,
        this.userMark,
        this.questionCount,
        this.questionEmpty,
        this.questionAnswered,
        this.questionWrong,
        this.questionCorrect,
        this.status,
        required this.questions,

        this.timeSpend,
        this.passingGrade,
        this.userItemId,
        this.graduation,
        this.graduationText,
        this.resul,
      this.total_time});

  Results.fromJson( json) {
    mark = json['mark'];
    userMark = json['user_mark'];
    questionCount = json['question_count'];
    questionEmpty = json['question_empty'];
    questionAnswered = json['question_answered'];
    questionWrong = json['question_wrong'];
    questionCorrect = json['question_correct'];
    status = json['status'];
    total_time = json['total_time'];

    if (json['questions'] != null){
      IDS.forEach((element) {


        questions.add(Ques.fromJson(json['questions']['$element']));
      });
  }
    timeSpend = json['time_spend'];
    passingGrade = json['passing_grade'];
    userItemId = json['user_item_id'];
    graduation = json['graduation'];
    graduationText = json['graduationText'];
    resul = json['result'];


  }


}
class Ques{
 dynamic correct;
  dynamic mark;
  dynamic answered;
 Ques.fromJson( json) {

   correct=json['correct'];
   mark=json['mark'];
   answered=json['answered'];

 }
}
