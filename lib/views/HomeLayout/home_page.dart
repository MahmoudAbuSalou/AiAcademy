
import 'package:academy/views/Search/SearchScreen.dart';
import 'package:academy/views/login_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
    // TODO: implement initState
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

                iconNavBar('images/unvirsites.svg','الكليات'),


                //SvgPicture.asset('images/unvirsites.svg',color:const Color(0xff32504F),width: 35,height: 35,),
                const   Icon(
                  Icons.home,
                  size: 38,
                  color: Color(0xff32504F),
                  // color: context.isDarkMode ? kTextColorWhiteDark : Colors.black26,
                ),
                iconNavBar('images/collages.svg','المساقات'),
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
                          navigatorTo(context, ProfileScreen());
                        },
                        child:CacheHelper.getData(key: 'token')!=null ?ListTile(
                          leading: SvgPicture.asset('images/user (1).svg'),
                          title: AutoSizeText(
                            'الصفحة الشخصية',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontFamily: kFontFamily,
                              fontSize: kTitleSize,
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
                          title: AutoSizeText(
                            'تسجيل الخروج',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontFamily: kFontFamily,
                              fontSize: kTitleSize,
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
                          title: AutoSizeText(
                            'تسجيل الدخول',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontFamily: kFontFamily,
                              fontSize: kTitleSize,
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
                          title: AutoSizeText(
                            'تواصل معنا',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontFamily: kFontFamily,
                              fontSize: kTitleSize,
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
              backgroundColor: Colors.white,


              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon:CacheHelper.getData(key: 'token')!=null? Icon(Icons.person):Icon(Icons.login), onPressed: () {
                      CacheHelper.getData(key: 'token')!=null?
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(),)):
                      navigatorToNew(context, LoginScreen());

                    },),
                    IconButton(icon: Icon(Icons.search), onPressed: (

                        ) { Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchScreen(),));  },),


                  ],

                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: (){
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: SvgPicture.asset('images/menu.svg')),

                ),
              ],
            ),


            body: (!cubit.netConnected)?RefreshIndicator(
              backgroundColor:kSwatchColor,
              color: Colors.white,
              displacement: 200,
strokeWidth: 2,
                onRefresh: () async {
                 cubit.checkNet();
                 print(cubit.netConnected);
                },
                child: SingleChildScrollView(
               physics:BouncingScrollPhysics() ,
                  child:Center(
                      child:Container(
                        height: MediaQuery.of(context).size.height-400.h,
                        width: MediaQuery.of(context).size.width,
                        child:  Icon(
                          Icons.signal_wifi_statusbar_connected_no_internet_4_sharp,
                          size: 400.r,
                          color: kSwatchColor,
                        ),
                      )

                  ) ,
                ),
            ):

               IndexedStack(
                index: cubit.currentIndex,
                children:const [
                  University(),
                  main.MainPage(),
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
      SvgPicture.asset(image,color:const Color(0xff32504F),width: 35,height: 35,),
      AutoSizeText(name)
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
