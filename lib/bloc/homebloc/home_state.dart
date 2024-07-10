part of 'home_bloc.dart';

@immutable
sealed class HomeState {}
class HomeActionState extends HomeState{}

final class HomeInitial extends HomeState {}
final class HomeLoadingState extends HomeState {}
final class HomeErrorState extends HomeState {}
final class HomeLoadedState extends HomeState {
  final List<Bill> bills;

  HomeLoadedState({required this.bills});
}
final class PayementState extends HomeActionState {}
final class HistoryState extends HomeActionState {}
final class BillExpandedState extends HomeActionState {
  final Bill bill;

  BillExpandedState({required this.bill});
}
