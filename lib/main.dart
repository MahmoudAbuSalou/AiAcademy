import 'dart:io';


import 'package:academy/views/HomeLayout/homeCubit/home_cubit.dart';
import 'package:academy/views/Profile_Cubit/profile_cubit.dart';


import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:academy/shared/bloc_observer.dart';
import 'package:academy/shared/network/local/cachehelper.dart';
import 'package:academy/shared/network/remote/dio_helper.dart';

import 'package:academy/views/splash%20screen/splash_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'components/const.dart';
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
        designSize: Size(1080, 2280),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_) {
          return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => HomeCubit(HomeInitial())),

                BlocProvider(
                  create: (BuildContext context) =>
                      ProfileCubit(ProfileInitial())..getUserProfile(),

                )
              ],
              child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                locale: const Locale('ar'),
                title: 'AI Academy',
                theme: ThemeData(
                  primaryColor: kSwatchColor,
                  focusColor: kSwatchColor,
                  primarySwatch: Colors.orange,
                ),
                home:
                SplashScreen(),
              ));
        });
  }
}
