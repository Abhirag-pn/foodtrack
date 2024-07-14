part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthActionState extends AuthState{}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthErrorState extends AuthState {
  final String errormessage;

  AuthErrorState({required this.errormessage});
}

final class AuthSuccessState extends AuthActionState {}

final class AdminAuthSuccessState extends AuthActionState {}
final class UserLoginState extends AuthActionState {}
final class UserSignUpState extends AuthActionState {}
final class AdminLoginState extends AuthActionState {}
