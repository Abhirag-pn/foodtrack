part of 'home_bloc.dart';

@immutable
sealed class HomeState {}
class HomeActionState extends HomeState{}

final class HomeInitial extends HomeState {}
final class HomeLoadingState extends HomeState {}
final class LogoutState extends HomeActionState{}
final class HomeErrorState extends HomeActionState {
  final String errmsg;

  HomeErrorState({required this.errmsg});
}
final class HomeLoadedState extends HomeState {
  final List<Bill> bills;
  final String username;

  HomeLoadedState({required this.bills,required this.username});
}
final class PayementState extends HomeActionState {
  final double amount;

  PayementState({required this.amount});
}
final class HistoryState extends HomeActionState {}
final class AddFoodState extends HomeActionState{}
final class BillExpandedState extends HomeActionState {
  final Bill bill;

  BillExpandedState({required this.bill});
}
final class CashPaymenState extends HomeActionState {

}
final class GpayPaymentState extends HomeActionState {

}
final class PaymentRequestSentState extends HomeActionState {

}
