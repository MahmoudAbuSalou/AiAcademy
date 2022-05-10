part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}


class ProfileLoadingState extends ProfileState{}
// ignore: must_be_immutable
class ProfileSuccessState extends ProfileState{
   ProfileModel? profileModel;
  ProfileSuccessState(this.profileModel);
}
// ignore: must_be_immutable
class ProfileErrorState extends ProfileState{
  late String  Error ;
  ProfileErrorState(Error);

}
