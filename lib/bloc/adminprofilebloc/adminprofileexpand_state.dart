part of 'adminprofileexpand_bloc.dart';

@immutable
sealed class AdminprofileexpandState {}

final class AdminprofileexpandInitial extends AdminprofileexpandState {}

class AdminprofileexpandActionState extends AdminprofileexpandState {}

class AdminBillLoadingState extends AdminprofileexpandState {}

class AdminBillLoadedState extends AdminprofileexpandState {
  final List<Bill> bills;
  final List<Payment>requests;
  final String username;
  final String id;

  AdminBillLoadedState(  { required this.requests,required this.bills,required this.username,required this.id});
}

class AdminBillErrorState extends AdminprofileexpandActionState {
  final String errmsg;

  AdminBillErrorState({required this.errmsg});
}

class AdminBillExpandedState extends AdminprofileexpandActionState {
  final Bill bill;

  AdminBillExpandedState({required this.bill});
}

class MarkAsPaidClickedState extends AdminprofileexpandActionState {
 
final List<Payment>requests;

  MarkAsPaidClickedState({required this.requests});

}
class MarkAsPaidUpdatedState extends AdminprofileexpandActionState {
final bool isRejected;

  MarkAsPaidUpdatedState({required this.isRejected});
}

class AdminToggleMarkAsPaid extends AdminprofileexpandActionState {}

class AdminToggleHistory extends AdminprofileexpandActionState {

final String id;

  AdminToggleHistory({required this.id});



}
