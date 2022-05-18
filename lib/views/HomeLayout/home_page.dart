
import 'package:academy/views/Search/SearchScreen.dart';
import 'package:academy/views/login_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:academy/views/home%20page/pages/main_page.dart' as main;

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

import 'package:academy/views/home%20page/pages/collage/collage.dart';
import 'package:academy/views/home%20page/pages/university/unvirsity.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/const.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cachehelper.dart';
import '../profile_screen.dart';
import '../your courses/your_courses.dart';
import 'homeCubit/home_cubit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {

    super.initState();
    HomeCubit.get(context).checkNet();


  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;

    return BlocConsumer<HomeCubit,HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);


          return Scaffold(
            key: _scaffoldKey,
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: cubit.currentIndex,
              buttonBackgroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              color: kSwatchColor,
              animationCurve: Curves.easeOutExpo,
              items:  <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 15.w),
                    child: iconNavBar('images/unvirsites.svg','الكليات',)),
                //SvgPicture.asset('images/unvirsites.svg',color:const Color(0xff32504F),width: 35,height: 35,),
                const   Icon(
                  Icons.home,
                  size: 38,
                  color: Color(0xff32504F),
                  // color: context.isDarkMode ? kTextColorWhiteDark : Colors.black26,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 15.w),
                    child: iconNavBar('images/collages.svg','المساقات')),
                //  SvgPicture.asset('images/collages.svg',color:const Color(0xff32504F),width: 35,height: 35,),
              ],
              onTap: (index) {

                // cubit.getHomeData();
                cubit.changBottomBar(index);

              },
            ),
            endDrawer: Drawer(
              child: Container(
                height: size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/drawer.png'),
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: (){
                              navigatorTo(context, ProfileScreen(homepage: false,));
                            },
                            child:CacheHelper.getData(key: 'token')!=null ?ListTile(
                              leading: SvgPicture.asset('images/user (1).svg'),
                              title: const AutoSizeText(
                                'الصفحة الشخصية',
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontFamily: kFontFamily,
                                  fontSize: 20,
                                ),
                              ),
                            ):Container(),
                          ),

                          CacheHelper.getData(key: 'token')!=null?
                          InkWell(
                            onTap: (){
                              CacheHelper.removeAllData().then((value) {
                                navigatorToNew(context, HomePage());

                              });
                            },
                            child: ListTile(
                              leading: SvgPicture.asset('images/online-course (1).svg'),
                              title: const AutoSizeText(
                                'تسجيل الخروج',
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontFamily: kFontFamily,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ):
                          InkWell(
                            onTap: (){
                              navigatorToNew(context, LoginScreen());
                            },
                            child: ListTile(
                              leading: SvgPicture.asset('images/online-course (1).svg'),
                              title: const AutoSizeText(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontFamily: kFontFamily,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: (){
                              launchWhatsApp(phone: 201221481731, message:'مرحبا، أحتاج أن أستفسر عن التالي لو سمحتم!');
                            },
                            child: ListTile(
                              leading: SvgPicture.asset('images/contact-us.svg'),
                              title: const AutoSizeText(
                                'تواصل معنا',
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontFamily: kFontFamily,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              shadowColor: Colors.black,
              foregroundColor: Colors.black,
              backgroundColor: kSwatchColor,



              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if(CacheHelper.getData(key: 'token')==null)
                    IconButton(icon:Icon(Icons.login), onPressed: () {


                      navigatorTo(context, LoginScreen());

                    },),
                   if (CacheHelper.getData(key: 'token')!=null)
                     IconButton(icon: Icon(Icons.search_sharp), onPressed: () {


                       navigatorTo(context, SearchScreen());

                     },),



                  ],

                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 8,right: 8,left: 20,bottom: 8),
                  child: InkWell(
                      onTap: (){
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: SvgPicture.asset('images/menu.svg')),

                ),
              ],
            ),


            body: (!cubit.netConnected)?
            Column(
              children: [
                Image.asset('images/noConnection.jpg'),
                Text('يرجى التحقق من الاتصال بالإنترنت',style: GoogleFonts.tajawal(
                  fontSize: 50.h,

                ),),
                SizedBox(
                  height: 100.h,
                ),
                CircularProgressIndicator(),
              ],
            ):
            IndexedStack(
              index: cubit.currentIndex,
              children: [
                University(),
                (CacheHelper.getData(key: 'token')!=null)?ProfileScreen(homepage: true,):  main.MainPage(),
                Collage(),
              ],
            ),


          );
        }
    );

  }
}
Widget  iconNavBar(String image,String name)
{
  return Column(
    children: [
      SvgPicture.asset(image,color:const Color(0xff32504F),width: 30,height: 30,),
      AutoSizeText(name,
        style: TextStyle(
          fontSize: 25.sp
        ),
      )
    ],
  );

}

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
