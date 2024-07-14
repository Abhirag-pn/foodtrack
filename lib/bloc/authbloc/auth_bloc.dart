import 'package:bloc/bloc.dart';
import 'package:foodtrack/models/usermodel.dart';
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
        UserCredential credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: event.email, password: event.password);

        if (credential.user != null) {
          final FirebaseFirestore _firestore = FirebaseFirestore.instance;
          final docSnapshot = await _firestore
              .collection('users')
              .doc(credential.user!.uid)
              .get();
          if (docSnapshot.data()?['role'] == 'admin') {
            emit(AdminAuthSuccessState());
          } else {
            emit(AuthSuccessState());
          }
        }
      } on FirebaseException catch (err) {
        String? message;
        if (err.code.isNotEmpty) {
          message = err.code;
        } else {
          message = "An error occured,check your credentials";
        }
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
          String? message;
          if (err.code.isNotEmpty) {
            message = err.message;
          } else {
            message = "An error occured,check your credentials";
          }
          emit(
            AuthErrorState(errormessage: message!),
          );

          message = err.code;
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

    on<ToggleAdminLogin>(
      (event, emit) {
        emit(AdminLoginState());
      },
    );
    on<ToggleUserLogin>(
      (event, emit) {
        emit(UserLoginState());
      },
    );
  }
}
