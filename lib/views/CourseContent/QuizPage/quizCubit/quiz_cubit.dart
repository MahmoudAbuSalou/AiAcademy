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
/*
this class is used To:
1-get Quiz :
  1-1:Questions + Answers
  1-2:Review Page
  1-3:Result Page

2-Timer

3-Start Quiz + Finish Quiz

4-


 */

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());
  static QuizCubit get(context) => BlocProvider.of(context);


  //For Conditional Builder In QuizPage in File Quiz.dart
  bool test=false;




//For Change Screen Quiz if Quiz become in 'In Progress ' State
  bool inProgress=false;

  late QuizModel quiz;

//To Storage Answers Of User On Quiz's Questions To Send It Back
  Map answered={};




  // To Store Answers Of User On Quiz's Questions in Last Time that i recieve it From Back
  late List<question> ? storeAnswers=[];


  //Timer For Calculate Time During Quiz
  Timer ? timer;

  //Initial Start For Timer
  //that i change it when i recieve data From Back in Api
  // it is used in Timer
   dynamic start =3600;



//For Change Screen Quiz if Quiz become in 'Review ' State
   bool Review=false;


//Timer
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

  //Api For Get Quiz
  void getQuiz( {required String id,context}){



    emit(GetQuizLoading());
    DioHelper.getData(url: 'learnpress/v1/quiz/$id',token:CacheHelper.getData(key: 'token'),
    )
        .then((value ) {


        quiz=  QuizModel.fromJson(value.data);


        //Change Value Of Time that i use it in Timer
          start=quiz.results!.totalTime!;









      test=true;


      emit(GetQuizSuccess());
    }).catchError((error) {
      showToast(msg: 'عذراً ، الصفحة المطلوبة غير متوفرة', state:ToastState.ERROR);

      print(error.toString());

      emit(GetQuizError());
    });



  }

  //Change State Of Screen from 'In progress' To Anthor State and the opposite
  void changeScreen(){
    inProgress=!inProgress;
    emit(chgScreenQuiz());
  }

  //To Change State in Quiz Page
  //when i choose answer
  //Instead Of SetState
  void change({count,index,valueRa,valueCheck,context}){


     List temp=storeAnswers!;
    (index==null)?temp[count].value=valueRa:temp[count].isChecked[index]=valueCheck;
    emit(changeState());
  }

  //Change State Of Screen from 'Review' To Anthor State and the opposite
  void moveToReview(){
   Review=!Review;
   emit(changeState());
  }

  //Api To Start Quiz
  void startQuiz(id,context){

    String token=CacheHelper.getData(key: 'token');

    emit(loadingQuiz());
    DioHelper.postData(url: 'learnpress/v1/quiz/start?id=$id',token:token,data: {}
    ).then((value) {

      getQuiz(id: id,context: context);



      emit(StartQuizSuccess());

    }).catchError((onError){
      showToast(msg: ' "Sorry, You cannot view this item."', state:ToastState.ERROR);


      emit(StartQuizFailed());
    });
  }

  //Api To Finish Quiz
  void finishQuiz(id,context){
   timer?.cancel();

    String token=CacheHelper.getData(key: 'token');

  inProgress=false;

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

  //To Convert seconds  to Fromat 01:00:00
  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  // To Store Answers Of User On Quiz's Questions in Last Time that i recieve it From Back in [[     storeAnswers      ]]
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



  // //Manipulate for Multi Choice
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

  //SubString from 0 to Sign '%'
  String convert(String converter){

    int temp = converter.indexOf('%');
    if(temp!=-1) {

     return     converter.substring(0, temp);
    }
    return converter;
  }
}
