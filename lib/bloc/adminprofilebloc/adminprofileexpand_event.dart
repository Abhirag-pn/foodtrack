part of 'adminprofileexpand_bloc.dart';

@immutable
sealed class AdminprofileexpandEvent {}

class AdminGetBillsEvent extends AdminprofileexpandEvent {
  final String userid;

  AdminGetBillsEvent({required this.userid});
}

class AdminMarkPaidClickEvent extends AdminprofileexpandEvent {}

class AdminHistoryClickEvent extends AdminprofileexpandEvent {}

class AdminBillExpandEvent extends AdminprofileexpandEvent {
  final Bill bill;

  AdminBillExpandEvent({required this.bill});
}


class MarkAsPaidClickedEvent extends AdminprofileexpandEvent {
  final List<Payment>requests;

  MarkAsPaidClickedEvent({required this.requests});
}
class MarkAsPaidConfirmedEvent extends AdminprofileexpandEvent {
final String paymentreqid;

  MarkAsPaidConfirmedEvent({required this.paymentreqid});
}
class MarkAsPaidRejectedEvent extends AdminprofileexpandEvent {
final String paymentreqid;

  MarkAsPaidRejectedEvent({required this.paymentreqid});
}
