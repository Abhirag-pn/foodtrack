part of 'history_bloc.dart';

@immutable
sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}

class HistoryActionState extends HistoryState {}

class HistoryLoadingState extends HistoryState {}

class HistoryLoadedState extends HistoryState {
  final List<Payment> payments;

  HistoryLoadedState({required this.payments});
}

class HistoryErrorState extends HistoryActionState {
  final String errmsg;

  HistoryErrorState({required this.errmsg});
}
