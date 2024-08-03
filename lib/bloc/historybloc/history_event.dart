part of 'history_bloc.dart';

@immutable
sealed class HistoryEvent {}


class GetHistoryEvent extends HistoryEvent {
  final String userId;

  GetHistoryEvent({required this.userId});
}



