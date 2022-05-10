//external
import 'package:academy/shared/network/end_point.dart';

import 'Quiz.dart';

class Res {
  String? passingGrade;
  bool? negativeMarking;
  bool? instantCheck;
  dynamic  retakeCount;
  dynamic  questionsPerPage;
  dynamic  pageNumbers;
  bool? reviewQuestions;
  List<String>? supportOptions;
  dynamic duration;
  String? status;
  List<Attempts>? attempts;
  Results ? result;

  String? startTime;
  dynamic retaken;
  dynamic  totalTime;
  dynamic i=0;

  Res(
      {this.passingGrade,
        this.negativeMarking,
        this.instantCheck,
        this.retakeCount,
        this.questionsPerPage,
        this.pageNumbers,
        this.reviewQuestions,
        this.supportOptions,
        this.duration,
        this.status,
        this.attempts,
        this.result,

        this.startTime,
        this.retaken,
         this.totalTime});

  Res.fromJson(Map<String, dynamic> json) {
    passingGrade = json['passing_grade'];
    negativeMarking = json['negative_marking'];
    instantCheck = json['instant_check'];
    retakeCount = json['retake_count'];
    questionsPerPage = json['questions_per_page'];
    pageNumbers = json['page_numbers'];
    reviewQuestions = json['review_questions'];
    result = json['results'] != null ? new Results.fromJson(json['results']) : null;

    duration = json['duration'];
    status = json['status'];

    startTime = json['start_time'];
    retaken = json['retaken'];
    totalTime = json['total_time'];



  }


}

class Attempts {
  int? mark;
  int? userMark;
  int? questionCount;
  int? questionEmpty;
  int? questionAnswered;
  int? questionWrong;
  int? questionCorrect;
  String? status;
  int? result;
  String? timeSpend;
  String? passingGrade;
  int? pass;

  Attempts(
      {this.mark,
        this.userMark,
        this.questionCount,
        this.questionEmpty,
        this.questionAnswered,
        this.questionWrong,
        this.questionCorrect,
        this.status,
        this.result,
        this.timeSpend,
        this.passingGrade,
        this.pass});

  Attempts.fromJson(Map<String, dynamic> json) {
    mark = json['mark'];
    userMark = json['user_mark'];
    questionCount = json['question_count'];
    questionEmpty = json['question_empty'];
    questionAnswered = json['question_answered'];
    questionWrong = json['question_wrong'];
    questionCorrect = json['question_correct'];
    status = json['status'];
    result = json['result'];
    timeSpend = json['time_spend'];
    passingGrade = json['passing_grade'];
    pass = json['pass'];
  }


}