import 'dart:async';

import 'package:academy/shared/components/components.dart';
import 'package:academy/shared/components/constants.dart';
import 'package:academy/shared/network/end_point.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../../../models/Quiz/Quiz.dart';
import '../../../../shared/network/local/cachehelper.dart';
import '../../../../shared/network/remote/dio_helper.dart';




part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());
  bool test=false;
  bool status=true;
  String Message='';

  bool inProgress=false;
  late QuizModel quiz;
  bool StartTimer=false;
  Map answered={};
  Map ReviewAnswered={};
  late List<question> ? storeAnswers=[];
  static QuizCubit get(context) => BlocProvider.of(context);
  Timer ? timer;
 dynamic start =3600;
 bool doneQuiz=true;
 String Time='';
 bool Review=false;
  late Results  finalResult;
 void startTimer() {
   Duration(seconds: 2);
    emit(ChangeTime());
    const oneSec =  Duration(seconds: 1);

     timer = new Timer.periodic(
       oneSec,
           (Timer timer) {
         if (start == 0) {
           timer.cancel();
           emit(ChangeTime());
         }
         else {

           start--;

           emit(ChangeTime());
         }
       },
     );



  }
  void getQuiz( {required String id,context}){
   //test=false;
String token=CacheHelper.getData(key: 'token');
print(token);
    emit(GetQuizLoading());
    DioHelper.getData(url: 'learnpress/v1/quiz/$id',token:token,
    )
        .then((value ) {


        quiz=  QuizModel.fromJson(value.data);

          start=quiz.results!.totalTime!;









      test=true;


      emit(GetQuizSuccess());
    }).catchError((error) {
      showToast(msg: 'عذراً ، الصفحة المطلوبة غير متوفرة', state:ToastState.ERROR);
    //  Navigator.of(context).pop();
      print(error.toString());

      emit(GetQuizError());
    });



  }
  void changeScreen(){
    inProgress=!inProgress;
    emit(chgScreenQuiz());
  }


  void change({count,index,valueRa,valueCheck,context}){


     List temp=storeAnswers!;
    (index==null)?temp[count].value=valueRa:temp[count].isChecked[index]=valueCheck;
    emit(changeState());
  }
  void moveToReview(){
   Review=!Review;
   emit(changeState());
  }
  void startQuiz(id,context){

    String token=CacheHelper.getData(key: 'token');

    emit(loadingQuiz());
    DioHelper.postData(url: 'learnpress/v1/quiz/start?id=$id',token:token,data: {}
    ).then((value) {

      getQuiz(id: id,context: context);
          StartTimer=true;
    //  startTimer();

      emit(StartQuizSuccess());

    }).catchError((onError){
      showToast(msg: ' "Sorry, You cannot view this item."', state:ToastState.ERROR);


      emit(StartQuizFailed());
    });
  }


  void finishQuiz(id,context){
   timer?.cancel();
   //answered.clear();
    String token=CacheHelper.getData(key: 'token');
 //  test =false;
  inProgress=false;
 doneQuiz=false;
   Map toSend= {
      "id":id,
    "answered":answered
    };

    emit(loadingFinishQuiz());
    DioHelper.postData(url: 'learnpress/v1/quiz/finish/',token:token,data: toSend
    ).then((value) {




    getQuiz(id: id,context: context);

      emit(FinishQuizSuccess());

    }).catchError((onError){
      showToast(msg: ' "Sorry, You cannot Finish this item."', state:ToastState.ERROR);
      // Navigator.of(context).pop();
      print(onError.toString());

      emit(FinishQuizFailed());
    });
  }
  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }
  void fillReviewPage(){
  storeAnswers?.clear();
  int i=0;
  quiz.results?.result?.questions.forEach((element) {

    storeAnswers?.add(question(
      idQues:quiz.questions[i].id ,
      questionTitle:quiz.questions[i].title ,
      count:i+1 ,
      answers: quiz.questions[i].options,
      point:quiz.questions[i].point ,
      type: quiz.questions[i].type,
      Review: true,
    ));


    //Manipulate for Single Choice


    if(quiz.questions[i].type!="multi_choice"){

    // dynamic element=quiz.results?.result?.questions[i].answered;
     int value=10;
     int j=0;
     if( quiz.questions[i].options is! String) {
       quiz.questions[i].options?.forEach((element) {
       if(quiz.questions[i].options?[j].value==element.value) {
         value=j;
       }
       j++;
     });
     }



     storeAnswers?[i].value=value;

          }




    else{

     if(quiz.results?.result?.questions[i].answered is! String && quiz.results?.result?.questions[i].answered is! bool) {
       quiz.results?.result?.questions[i].answered.forEach(
          (element){
            int j=0;
            quiz.questions[i].options?.forEach((element) {
              if(quiz.questions[i].options?[j].value==element.value) {
                storeAnswers?[i].isChecked[j]=true;
              }
              j++;
            });




          }
      );
     }



    }

    i++;
  });
  }
  String convert(String converter){

    int temp = converter.indexOf('%');
    if(temp!=-1) {

     return     converter.substring(0, temp);
    }
    return converter;
  }
}
