part of 'adminprofileexpand_bloc.dart';

@immutable
sealed class AdminprofileexpandState {}

final class AdminprofileexpandInitial extends AdminprofileexpandState {}

class AdminprofileexpandActionState extends AdminprofileexpandState {}

class AdminBillLoadingState extends AdminprofileexpandState {}

class AdminBillLoadedState extends AdminprofileexpandState {
  final List<Bill> bills;
  final String username;

  AdminBillLoadedState( { required this.bills,required this.username,});
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
 


}
class MarkAsPaidUpdatedState extends AdminprofileexpandActionState {
final bool isRejected;

  MarkAsPaidUpdatedState({required this.isRejected});
}

class AdminToggleMarkAsPaid extends AdminprofileexpandActionState {}

class AdminToggleHistory extends AdminprofileexpandActionState {}
