part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoadingState extends HomeState {}
final class HomeErrorState extends HomeState {}
final class PayementState extends HomeState {}
final class HistoryState extends HomeState {}
