part of 'addfood_bloc.dart';

@immutable
sealed class AddfoodState {}



final class AddfoodInitial extends AddfoodState {}

 final class FoodLoadedState extends AddfoodState{
  final List<Food>fooditems;

  FoodLoadedState({required this.fooditems});
 }

final class FoodLoadingState extends AddfoodState{}
final class FoodErrorState extends AddfoodState{
  final String errmsg;

  FoodErrorState({required this.errmsg});
}

final class FoodAddedState extends AddfoodState{}

