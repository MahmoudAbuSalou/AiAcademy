// ignore: slash_for_doc_comments
/**
 *  This page is responsible for displaying
 * the name and price of the course before purchasing the course
 * **/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/components.dart';
import '../../components/const.dart';

class CourseRegister extends StatefulWidget {
  String img = '';
  dynamic price=0;
  String name;
   CourseRegister({Key? key,required this.img,required this.price,required this.name}) : super(key: key);

  @override
  _CourseRegisterState createState() => _CourseRegisterState();
}

class _CourseRegisterState extends State<CourseRegister> {
  TextEditingController courseName=TextEditingController();

  /// this function responsible for connect with whatsApp
  void launchWhatsApp(
      {required int phone,
        required String message,
      }) async {
    String url() {
      if (Platform.isAndroid) {
        // add the [https]
        return "https://wa.me/$phone}/?text=${Uri.parse(message)}"; // new line
      } else {
        // add the [https]
        return "https://api.whatsapp.com/send?phone=$phone}=${Uri.parse(message)}"; // new line
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(title: 'شراء الكورس'),
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                    Container(
                      height: size.height/2,
                      decoration: BoxDecoration(

                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.img)

                          )
                      ),
                    ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Text(
                                'اسم الكورس',
                                style: TextStyle(
                                  fontSize: kSubTitleSize,
                                  fontFamily: kFontFamily,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      buildTextField(context, courseName,size,widget.name),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Text(
                                'الرقم',
                                style: TextStyle(
                                  fontSize: kSubTitleSize,
                                  fontFamily: kFontFamily,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Text(
                                '201221481731+',
                                style: TextStyle(
                                  fontSize: kSubTitleSize,
                                  fontFamily: kFontFamily,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Text(
                                'السعر',
                                style: TextStyle(
                                  fontSize: kSubTitleSize,
                                  fontFamily: kFontFamily,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Text(
                                '\$ ${widget.price}',
                                style: TextStyle(
                                  fontSize: kSubTitleSize,
                                  fontFamily: kFontFamily,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 150,
                          height: 45,
                          child: BorderedButton(title: 'تأكيد', color: Color(0xff32504F),
                              onPress: (){
                            launchWhatsApp(phone: 201221481731, message: widget.name);
                              }))
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(BuildContext context,controller,size,name) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:size.width*kPadding ),
      child: Container(
        height: 45,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: TextField(
          enabled: false,
          controller: controller,

          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            filled: true,
            fillColor: Colors.white,
            hintText: name,
            hintStyle: const TextStyle(
              color:kSwatchColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: const BorderSide(
                color:kSwatchColor,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: const BorderSide(
                color: kSwatchColor,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
