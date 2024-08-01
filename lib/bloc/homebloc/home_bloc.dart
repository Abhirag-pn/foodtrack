import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodtrack/models/billmodel.dart';
import 'package:foodtrack/models/paymentmodel.dart';
import 'package:logger/logger.dart';
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
            .where('ispaid', isEqualTo: 'false')
            .orderBy('date', descending: true)
            .get();
        final userCollection = await FirebaseFirestore.instance
            .collection('users')
            .doc(userid)
            .get();

        List<Bill> bills = snapshot.docs.map((doc) {
          final data = doc.data();
          return Bill.fromMap(data);
        }).toList();
   
        emit(HomeLoadedState(
            bills: bills, username: userCollection.data()!['name']));
      } catch (e, s) {
        log(e.toString());
        log(s.toString());
        Logger().e(s);

        emit(HomeErrorState(errmsg: e.toString()));
      }
    });

    on<LogoutRequestEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        await FirebaseAuth.instance.signOut();
        emit(((LogoutState())));
      },
    );

    on<PayClickedEvent>((event, emit) {
      try {
        log("Pay clicked");
        emit(PayementState(amount: event.amount));
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
        emit(BillExpandedState(bill: event.bill));
      } catch (e) {
        log(e.toString());
      }
    });

    on<AddFoodClickedEvent>((event, emit) {
      {
        emit(AddFoodState());
      }
    });
    on<CashPaymentEvent>((event, emit) async {
      {
        try {
          String userId = FirebaseAuth.instance.currentUser!.uid;
          final QuerySnapshot qs = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('bills')
              .where('ispaid', isEqualTo: 'false')
              .get();

          List<QueryDocumentSnapshot> docs = qs.docs;
          WriteBatch batch = FirebaseFirestore.instance.batch();
          for (var doc in docs) {
            DocumentReference docRef = doc.reference;

            batch.update(docRef, {'ispaid': 'pending'});
            await batch.commit();
          }

          DocumentReference pref =
              FirebaseFirestore.instance.collection('payments').doc();

          final List<Bill> paymentBills =
              qs.docs.map((doc) => Bill.fromJson(doc.toString())).toList();
          Payment newPayment = Payment(
            id: pref.id,
            bills: paymentBills,
            paymentMethod: 'cash',
            paymentdate: DateTime.now(),
            totalamount: paymentBills.fold(
              0,
              (s, bill) => s + bill.total,
            ),
          );
          pref.set(newPayment.toMap());
          emit(PaymentRequestSentState());
        } catch (e) {
          emit(HomeErrorState(errmsg: e.toString()));
        }
      }
    });
  }
}
