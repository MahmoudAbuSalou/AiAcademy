import 'package:academy/views/web_view/web_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../components/const.dart';
import '../components/loggin_text_field.dart';
import '../components/login_button.dart';
import '../components/login_screen_scaffold.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/network/local/cachehelper.dart';
import 'HomeLayout/home_page.dart';
import 'loginCubit/login_cubit.dart';


// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(LoginInitial()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            /// if login Success  save user token and information
            if (state.userModel.token != null) {
              CacheHelper.saveData(key: 'token', value: state.userModel.token)
                  .then((value) => {
                CacheHelper.saveData(
                    key: 'user_id', value: state.userModel.userId)
                    .then((value) => {
                  CacheHelper.saveData(
                      key: 'user_email',
                      value: state.userModel.email)
                      .then((value) => {
                    CacheHelper.saveData(
                        key: 'user_login',
                        value: state
                            .userModel.userLogin)
                        .then((value) => {
                      CacheHelper.saveData(
                          key:
                          'user_display_name',
                          value: state
                              .userModel
                              .user_display_name)
                          .then((value) =>
                          navigatorToNew(
                              context,
                              HomePage()))
                    })
                  })
                })
              });
            } else {
              showToast(msg: "Incorrect Information ", state: ToastState.ERROR);
            }
          } else if (state is LoginErrorState) {
            showToast(msg: state.Error, state: ToastState.ERROR);
          }
        },
        builder: (context, state) {
          LoginCubit loginCubit = LoginCubit.get(context);
          return LoginScreenScaffold(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    color: kSwatchColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoKufiArabic-Medium',
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        LogginTextField(
                          valid: (String? value) {
                            if (value!=null && value.isEmpty) {
                              return "الرجاء أدخال اسم المستخدم";
                            }
                            return null;
                          },
                          controller: userName,
                          title: 'اسم المستخدم ',
                          iconPath: 'images/email.svg',
                        ),
                        LogginTextField(
                          valid: (String? value) {
                            if (value!=null && value.isEmpty) {
                              return "كلمة المرور فارغة";
                            }
                            return null;
                          },
                          controller: password,
                          title: 'كلمة المرور',
                          iconPath: 'images/key.svg',
                          obSecureText: true,
                        ),
                        state is LoadingState?
                        LoginButton(
                          onTap: (){},
                          load: true,
                        ):LoginButton(
                          load: false,
                          onTap: () {
                            /// if user input true login else show error
                            if(formKey.currentState!.validate()) {
                              loginCubit.userLogin(userName: userName.text,
                                  password: password.text);
                            }
                          },
                        ) ,
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () {},
                      splashColor: kSwatchColor.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: InkWell(
                        onTap:(){
                          /// register using web view
                          navigatorToNew(
                              context,
                              WebPage(Url:'https://aiacademy.info/%d8%a7%d9%84%d8%ad%d8%b3%d8%a7%d8%a8-%d8%a7%d9%84%d8%b4%d8%ae%d8%b5%d9%8a/?action=register'));
                        },
                        child: Container(
                          width: size.width * 0.35,
                          child: const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'إنشاء حساب إلكتروني',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NotoKufiArabic-Medium',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
