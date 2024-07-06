import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    on<GetBillDetailsEvent>((event, emit) {
      emit(HomeLoadingState());
      try {
        final userid = FirebaseAuth.instance.currentUser!.uid;
        final userRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userid)
            .collection('payementsets')
            .where('ispaid', isEqualTo: false);
      } catch (e) {
        log(e.toString());
      }
    });

    on<PayClickedEvent>((event, emit) {
      emit(HomeLoadingState());
      try {
        log("Pay clicked");
      } catch (e) {
        log(e.toString());
      }
    });

    on<HistoryClickedEvent>((event, emit) {
      emit(HomeLoadingState());
      try {
        log("History clicked");
      } catch (e) {
        log(e.toString());
      }
    });


      on<BillExpandEvent>((event, emit) {
      emit(HomeLoadingState());
      try {
        log("BillExpand clicked");
      } catch (e) {
        log(e.toString());
      }
    });


    on<AddFoodClickedEvent>((event, emit) {
      emit(HomeLoadingState());
      try {
        log("BillExpand clicked");
      } catch (e) {
        log(e.toString());
      }
    });

  }
}
