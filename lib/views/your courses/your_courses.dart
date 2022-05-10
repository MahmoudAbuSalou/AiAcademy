import 'package:academy/components/components.dart';
import 'package:academy/components/const.dart';
import 'package:flutter/material.dart';

class YourCourses extends StatefulWidget {
  const YourCourses({Key? key}) : super(key: key);

  @override
  _YourCoursesState createState() => _YourCoursesState();
}

class _YourCoursesState extends State<YourCourses> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
             MyAppBar(title: 'الكورسات الخاصة بك'),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: size.width * kPadding),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                  // list view for the student courses
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                      itemBuilder:(context,index)=>   const MyCourse(image: 'https://images.unsplash.com/photo-1606231140504-b6ec6cbbbf6b?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
                    name: 'التغيير في المجتمعات',))
                  ],
                ),
              ),
            ),
            )
          ],
        ),
      ),
    );
  }
}

class MyCourse extends StatelessWidget {
  const MyCourse({Key? key, required this.image, required this.name}) : super(key: key);
 final String image;
 final String name;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * kPadding,vertical: size.height*kPadding),
      child: Container(
        height: size.height / 2.5,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 2,
                  offset: const Offset(1, 1),
                  spreadRadius: 1),
            ]),
        child: Column(
          children: [
            Container(
              height: size.height/3.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(image)
                )
              ),
            ),
            SizedBox(height: size.height*(kPadding/2),),
            FittedBox(
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: kFontFamily,
                ),
              ),
            ),
            SizedBox(height: size.height*(kPadding/2),),
            BorderedButton(title: 'الذهاب', color: const Color(0xff32504F), onPress:(){} )
          ],
        ),
      ),
    );
  }
}
