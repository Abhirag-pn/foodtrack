part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetDetailsEvent extends HomeEvent {}
class PayClickedEvent extends HomeEvent {}
class HistoryClickedEvent extends HomeEvent {}
class BillExpandEvent extends HomeEvent {}
class PtofileClickEvent extends HomeEvent {}
