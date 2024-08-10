// ignore_for_file: unused_import

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:foodtrack/models/usermodel.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequestEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        log("try");
        UserCredential credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: event.email, password: event.password);
        if (credential.user != null) {
          final FirebaseFirestore firestore = FirebaseFirestore.instance;
          final docSnapshot = await firestore
              .collection('users')
              .doc(credential.user!.uid)
              .get();
          if (docSnapshot.data()?['role'] == 'admin') {
            log("emit admin Block");
            emit(AdminAuthSuccessState());
          } else {
            log("emit user Block");
         emit(AuthSuccessState());
          }
        }
      } on FirebaseException catch (e) {
        log("Catch Block");
        String? message;
        message = e.code;
        log(e.toString());
        emit(
          AuthErrorState(errormessage: message),
        );
      } on Exception catch (e) {
        log("Catch Block");
        String? message;
        message = e.toString();
        log(e.toString());
        emit(
          AuthErrorState(errormessage: message),
        );
      }
    });

    on<CreateAccountEvent>(
      (event, emit) async {
        try {
          Future<bool> validateUsername(String? username) async {
            final userCollection =
                FirebaseFirestore.instance.collection('users');
            final querySnapshot =
                await userCollection.where('name', isEqualTo: username).get();

            if (querySnapshot.docs.isNotEmpty) {
              return true;
            } else {
              return false;
            }
          }

          final existUser = await validateUsername(event.username);

          if (existUser) {
            emit(AuthErrorState(errormessage: "Username already exists"));
          } else {
            UserCredential credential = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: event.email, password: event.password);

            UserModel userinfo = UserModel(
                id: credential.user!.uid,
                email: credential.user!.email!,
                name: event.username,
                role: 'user');
            await FirebaseFirestore.instance
                .collection("users")
                .doc(credential.user!.uid)
                .set(userinfo.toMap());

            emit(AuthSuccessState());
          }
        } on FirebaseAuthException catch (err) {
          log("Catch Block");
          String? message;
          if (err.code.isNotEmpty) {
            message = err.message;
          } else {
            message = "An error occured,check your credentials";
          }

          message = err.code;
          emit(
            AuthErrorState(errormessage: message),
          );
        }
        on Exception catch (e) {
        log("Catch Block");
        String? message;
        message = e.toString();
        log(e.toString());
        emit(
          AuthErrorState(errormessage: message),
        );
      }
      },
    );

    on<ToggleSignUp>(
      (event, emit) {
        emit(UserSignUpState());
      },
    );

    on<ToggleLogin>(
      (event, emit) {
        emit(UserLoginState());
      },
    );

 
  }
}
