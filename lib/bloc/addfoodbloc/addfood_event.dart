part of 'addfood_bloc.dart';

@immutable
sealed class AddfoodEvent {}

class GetFoodItemsEvent extends AddfoodEvent{
  final String? type;

  GetFoodItemsEvent({required this.type});
}
class AddBillEvent extends AddfoodEvent{
  final List<Food>items;

  AddBillEvent({required this.items});


}

