import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodtrack/models/billmodel.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // static HomeBloc? _instance;
  // static HomeBloc get instance {
  //   _instance ??= HomeBloc();
  //   return _instance!;
  // }
  HomeBloc() : super(HomeInitial()) {
   on<GetBillDetailsEvent>((event, emit) async {
  emit(HomeLoadingState());
  try {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .collection('bills')
        .where('ispaid', isEqualTo: false).orderBy('date',descending: true)
        .get();

    var bills = snapshot.docs.map((doc) {
      final data = doc.data();
      log('Bill data: $data');
      return Bill.fromMap(data);
    }).toList();

    emit(HomeLoadedState(bills: bills));
  } catch (e,s) {
    log(e.toString());
    log(s.toString());

    emit(HomeErrorState());
  }
});

on<LogoutRequestEvent>(
      (event, emit) async{
        emit(HomeLoadingState());
       await FirebaseAuth.instance.signOut();
        emit(((LogoutState())));
      },
    );

    on<PayClickedEvent>((event, emit) {
   
      try {
        log("Pay clicked");
        emit(PayementState());
      } catch (e) {
        log(e.toString());
      }
    });

    on<HistoryClickedEvent>((event, emit) {
     
      try {
        log("History clicked");
        emit(HistoryState());
      } catch (e) {
        log(e.toString());
      }
    });


      on<BillExpandEvent>((event, emit) {
    
      try {
        log("BillExpand clicked");
        emit(BillExpandedState(bill:event.bill));
      } catch (e) {
        log(e.toString());
      }
    });


    on<AddFoodClickedEvent>((event, emit) {
      {
       emit(AddFoodState());
      
      }
    });

  }
}
