part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetBillDetailsEvent extends HomeEvent {}
class PayClickedEvent extends HomeEvent {}
class HistoryClickedEvent extends HomeEvent {}
class BillExpandEvent extends HomeEvent {
  final Bill bill;

  BillExpandEvent({required this.bill});
}
class LogoutRequestEvent extends HomeEvent{}
class ProfileClickEvent extends HomeEvent {}
class AddFoodClickedEvent extends HomeEvent {}
