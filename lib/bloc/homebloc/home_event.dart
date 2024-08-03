part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetBillDetailsEvent extends HomeEvent {}
class PayClickedEvent extends HomeEvent {
  final double amount;

  PayClickedEvent({required this.amount});
}
class HistoryClickedEvent extends HomeEvent {
  final String id;

  HistoryClickedEvent({required this.id});
}
class BillExpandEvent extends HomeEvent {
  final Bill bill;

  BillExpandEvent({required this.bill});
}
class LogoutRequestEvent extends HomeEvent{}
class ProfileClickEvent extends HomeEvent {}
class AddFoodClickedEvent extends HomeEvent {}
class CashPaymentEvent extends HomeEvent {
  final double amount;

  CashPaymentEvent({required this.amount});
}
class GpayPaymentEvent extends HomeEvent {
  final double amount;

  GpayPaymentEvent({required this.amount});
}
