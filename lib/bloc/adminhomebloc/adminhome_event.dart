part of 'adminhome_bloc.dart';

@immutable
sealed class AdminhomeEvent {}

class GetUsersEvent extends AdminhomeEvent{}
class UserTileExpandEvent extends AdminhomeEvent{
  final String userid;

  UserTileExpandEvent({required this.userid});
}

class AddFoodRequestEvent extends AdminhomeEvent{
  final String name,type,imagelink;
  final double price;

  AddFoodRequestEvent({required this.name, required this.price, required this.type, required this.imagelink});

  

  
}

