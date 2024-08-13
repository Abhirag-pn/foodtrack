import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../models/foodmodel.dart';
import '../../models/usermodel.dart';

part 'adminhome_event.dart';
part 'adminhome_state.dart';

class AdminhomeBloc extends Bloc<AdminhomeEvent, AdminhomeState> {
  AdminhomeBloc() : super(AdminhomeInitial()) {
    on<GetUsersEvent>((event, emit) async {
      emit(AdminHomeLoadingState());
      try {
        var snapshot = await FirebaseFirestore.instance.collection('users').where('role',isEqualTo: "user").get();
        var users = snapshot.docs.map((doc) {
          return UserModel.fromMap(doc.data());
        }).toList();
        emit(UsersLoadedState(users: users));
      } catch (e) {
        
        emit(AdminHomeErrorState(errmsg: e.toString()));
      }
    });

    on<AddFoodRequestEvent>((event, emit) async {
      try {
        final foodCollection = FirebaseFirestore.instance.collection('fooditems');
        final docRef = foodCollection.doc();
        final newfood = Food(
          id: docRef.id,
          qty: 0,
          name: event.name,
          price: event.price,
          type: event.type,
          imageLink: event.imagelink
        );
        await docRef.set(newfood.toMap());
        emit(FoodAddedState());
      } catch (e,s) {
        emit(AdminHomeErrorState(errmsg: e.toString()));
        log(s.toString());
      }
    });
    on<UserTileExpandEvent>((event, emit) async {
    emit(UserExpandedState(userid: event.userid));
    });

    
on<LogoutRequestEvent>(
      (event, emit) async{
        emit(AdminHomeLoadingState());
       await FirebaseAuth.instance.signOut();
        emit(((LogoutState())));
      },
    );
   
  }

}
