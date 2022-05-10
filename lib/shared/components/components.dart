
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/const.dart';
import '../../models/Quiz/Option.dart';
import '../../views/CourseContent/QuizPage/quizCubit/quiz_cubit.dart';
import '../network/end_point.dart';
import 'constants.dart';

Widget buildArticleItem(business, context ){
  return  Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage('${business['urlToImage']}'),
                fit: BoxFit.cover,
              )
          ),
        ),
        const SizedBox(width: 20,),
        Expanded(
          // ignore: sized_box_for_whitespace
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text("${business['title']}",style:Theme.of(context).textTheme.bodyText1 ,maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Expanded(
                  child: Text("${business['publishedAt']}",style: const TextStyle(
                      color: Colors.grey
                  ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )

              ],
            ),
          ),
        ),
      ],
    ),
  );
}
Widget myDriver()=> Padding(
  padding: const EdgeInsetsDirectional.only(start:0),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey,
  ),
);
void navigatorTo(context,Widget screen){
  Navigator.push(context,MaterialPageRoute(builder: (context)=>screen));
}
void navigatorToNew(context,Widget screen){
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context)=>screen),
          (route) => false);
}
Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
   Icon ? prefix,
  required Function valid,
  bool correct = true,
  bool focus = true,
  bool isPassword = false,
  bool enable = true,
  Icon? suffix,
  Function? onChanged,
  Function? onSubmitted,
  Function? suffixPressed,
  //Function ?onTap,
}) =>
    TextFormField(
      enabled: enable,
      validator: (s) {
        valid();

        },
      // onTap: (){
      //   onTap!();
      // },
      controller: controller,
      keyboardType: type,
      autocorrect: true,
      autofocus: true,
      textAlign: TextAlign.start,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
        prefixIcon: prefix,
        suffixIcon: suffix != null
            ? IconButton(
          icon: suffix,
          onPressed: (){
            suffixPressed!();
          },
        )
            : null,
      ),
      onChanged: (s){
        onChanged !();
      },
      onFieldSubmitted: (s){
        onSubmitted!();
      },
    );



Widget defaultTextButton({required String text,required Function function,Color color = Colors.white}){
  return TextButton(onPressed: (){
    function();
  }, child: Text(text.toUpperCase(),style: TextStyle(
    color:color
  ),));
}


void showToast({required String msg,required ToastState state})=> Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0

  );
class question extends StatefulWidget {


  //Id Of Question
  int ?idQues;

  //Number Of Questionin Quiz  1 - 2 - 3 .......
  int count;


  //To Detect Showing Screen [ Review or  Test]
  bool  Review=false;

  //This is Question
  late String  questionTitle;


  //This is List Of Options
  List<Options> ? answers=[];

  //Multi Choice Or Single Choice
  String type;


  int point;

  //Initial Value For Radio Button
  dynamic value=10;


  //Initial List For CheckBOX
  List <bool >  isChecked=[
    false,false,false,false,false
  ];
  question({required this.Review, required this.count,required this.questionTitle,required this.answers,required this.type,required this.point,required this.idQues}) : super();

  @override
  _questionState createState() => _questionState();
}

class _questionState extends State<question> {
@override
  void initState() {


  //Store Question In List StoreAnswers In Quiz Cubit
  QuizCubit.get(context).storeAnswers!.add(question(count: widget.count, questionTitle: widget.questionTitle, answers:widget. answers, type: widget.type, point: widget.point, idQues: widget.idQues,Review: widget.Review,));


  super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return Column(
      children: [

        //ShowQuestion
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 30.w,vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.count.toString() + '.',
                style:GoogleFonts.tajawal(  textStyle: TextStyle(
                    fontSize: 40.sp, fontWeight: FontWeight.bold),),

              ),


              Container(
                width: 950.w,
                child: Text(
                    widget.questionTitle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.tajawal(
                      textStyle: TextStyle(fontSize: 50.sp,),
                    )
                ),
              )
            ],
          ),
        ),




     //BuildAnswers
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: SizedBox(
            height: 400.h,
            width: double.infinity,
            child:
            ListView.builder(
                shrinkWrap: true,

                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: widget.answers!.length,
                itemBuilder: (context, index) {


                  return Container(
                    width:700.w,
                      child: buildOption( widget.answers![index].title,index,widget.type));
                }),
          ),
        )
      ],
    );
  }
  Widget buildOption( String ? name,int index,String type) {

    return (type!='multi_choice')?
        //RadioButtons
    Padding(
      padding:  EdgeInsets.symmetric(horizontal: 12.w),

      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 100.w,
            child:
            Padding(
              padding:  EdgeInsets.all(0.h),
              child: Radio(

                value: index,
                groupValue:(
                //Check if Store Answers Contain Data Or No
                    (QuizCubit.get(context).storeAnswers!.length>0)?
                    //If contain data this mean i am in review Page and i will show my answers
                    QuizCubit.get(context).storeAnswers![widget.count-1].value

                    :
                //if don't contain data this mean i am in Test Page
                widget.value
                ),
                hoverColor: Colors.yellow,
                activeColor:
                //if i am in Review Page i will Show Green radio for correct Answer And Red For False Answer
                (widget.Review)?
                ((QuizCubit.get(context).quiz.results?.result?.questions[widget.count-1].correct)
                    ?Colors.green:Colors.red)


                    :   //if i am in Test Page i will Showyellow radio
                kSwatchColor,
                focusColor: Colors.purple,
                onChanged: (valu ) {


                        //Change Value when i choose answer
                    widget.value = valu;
                    //Change State instead SetState
                    QuizCubit.get(context).change(count: widget.count-1,context: context,valueRa: valu);

                    //Store Answer In List To Send It To The Back
                    QuizCubit.get(context).answered['${widget.idQues}']=QuizCubit.get(context).quiz.questions[widget.count-1].options![index].value;

                },
              ),
            )
          ),
          SizedBox(width: 30.w,),
          FittedBox(
            child: Container(
              width: 800.w,
              child: Text(
                name!,
                maxLines: 1,
                style:  GoogleFonts.tajawal(
                    textStyle: TextStyle(
                        fontSize: 45.sp)
                ),
              ),
            ),
          ),
        ],
      ),
    )
    :
    //CheckBOXES
    Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 0.h),
      child: Container(
        width: 800.w,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Checkbox(
               activeColor: (widget.Review)?((QuizCubit.get(context).quiz.results?.result?.questions[widget.count-1].correct)?Colors.green:Colors.red) : kSwatchColor,
              value: (QuizCubit.get(context).storeAnswers!.length>0)? QuizCubit.get(context).storeAnswers![widget.count-1].isChecked[index]:widget.isChecked[index],
              onChanged: (value) {


                  widget.isChecked[index] = value!;

                  QuizCubit.get(context).change(index: index,count: widget.count-1,valueCheck: value,context: context);
                  List temp=QuizCubit.get(context).answered['${widget.idQues}']??[];

                  if(value==false){
                    temp.remove(QuizCubit.get(context).quiz.questions[widget.count-1].options![index].value);
                  }
                  if(value ==true){
                    temp.add(QuizCubit.get(context).quiz.questions[widget.count-1].options![index].value);
                  }
                QuizCubit.get(context).answered['${widget.idQues}']=temp;
                print(QuizCubit.get(context).quiz.questions[widget.count-1].options![index].value);
                print( QuizCubit.get(context).answered['${widget.idQues}']);



              },
            ),
            Container(
              width: 700.w,

              child: Text(

                name!,

                maxLines: 3,
                style:  GoogleFonts.tajawal(
                    textStyle: TextStyle(
                        fontSize: 45.sp)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
