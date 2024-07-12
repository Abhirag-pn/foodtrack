part of 'adminhome_bloc.dart';

@immutable
sealed class AdminhomeState {}
class AdminHomeActionState extends AdminhomeState {}



final class AdminhomeInitial extends AdminhomeState {}


class UsersLoadedState extends AdminhomeState {
  final List<UserModel> users;

  UsersLoadedState({required this.users});
}
class AdminHomeLoadingState extends AdminhomeState {}
class AdminHomeErrorState extends AdminhomeState {
  final String errmsg;

  AdminHomeErrorState({required this.errmsg});
}

class UserExpandedState extends AdminHomeActionState {
  final String userid;

  UserExpandedState({required this.userid});
}
class FoodAddedState extends AdminHomeActionState {
  
}
