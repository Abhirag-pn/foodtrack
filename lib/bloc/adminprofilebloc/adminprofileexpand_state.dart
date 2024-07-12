part of 'adminprofileexpand_bloc.dart';

@immutable
sealed class AdminprofileexpandState {}

final class AdminprofileexpandInitial extends AdminprofileexpandState {}

class AdminprofileexpandActionState extends AdminprofileexpandState {}

class AdminBillLoadingState extends AdminprofileexpandState {}

class AdminBillLoadedState extends AdminprofileexpandState {
  final List<Bill> bills;

  AdminBillLoadedState({required this.bills});
}

class AdminBillErrorState extends AdminprofileexpandActionState {}

class AdminBillExpandedState extends AdminprofileexpandActionState {
  final Bill bill;

  AdminBillExpandedState({required this.bill});
}

class AdminToggleMarkAsPaid extends AdminprofileexpandActionState {}

class AdminToggleHistory extends AdminprofileexpandActionState {}
