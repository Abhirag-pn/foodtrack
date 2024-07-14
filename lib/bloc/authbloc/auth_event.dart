part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginRequestEvent extends AuthEvent{
  final String email,password;

  LoginRequestEvent({required this.email, required this.password});
}

class CreateAccountEvent extends AuthEvent {
 final String username,email,password,cpassword;

  CreateAccountEvent( {required this.cpassword,required this.username, required this.email, required this.password });

}



class ToggleSignUp extends AuthEvent{}

class ToggleLogin extends AuthEvent{}

class ToggleAdminLogin extends AuthEvent {}

class ToggleUserLogin extends AuthEvent {}