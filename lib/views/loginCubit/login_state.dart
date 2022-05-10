part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoadingState extends LoginState{}

// ignore: must_be_immutable
class LoginSuccessState extends LoginState{
  late UserModel userModel;
  LoginSuccessState(this.userModel);
}
// ignore: must_be_immutable
class LoginErrorState extends LoginState{
  late String  Error ;
  LoginErrorState(this.Error);

}

