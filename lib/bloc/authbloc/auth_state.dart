part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthErrorState extends AuthState {
  final String errormessage;

  AuthErrorState({required this.errormessage});
}

final class AuthSuccessState extends AuthState {}
final class AdminAuthSuccessState extends AuthState {}
final class UserLoginState extends AuthState {}
final class UserSignUpState extends AuthState {}
final class AdminLoginState extends AuthState {}
