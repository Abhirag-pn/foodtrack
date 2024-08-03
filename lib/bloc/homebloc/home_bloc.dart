import 'dart:developer';
import 'package:flutter_upi_pay/flutter_upi_pay.dart';
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
            bills: bills, username: userCollection.data()!['name'],id:userid));
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

        emit(HistoryState(id:event.id ));
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
    on<GpayPaymentEvent>((event, emit) async{
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
    List<Bill> paymentBills = [];
    for (var doc in docs) {
      DocumentReference docRef = doc.reference;
      batch.update(docRef, {'ispaid': 'pending'});

      final data = doc.data() as Map<String, dynamic>;
      paymentBills.add(Bill.fromMap(data));
    }

    // Commit batch update
    await batch.commit();
    final double total=paymentBills.fold(
        0,
        (s, bill) => s + bill.total,
      );
    FlutterPayment flutterPayment = FlutterPayment();
           flutterPayment.launchUpi(
              upiId: "reshmaaravindn9-1@okaxis",
              name:FirebaseAuth.instance.currentUser!.uid.toString(),
              amount: total.toString(),
              message: "Canteen Payment",
              currency: "INR");
    // Create and save the payment document
    DocumentReference pref = FirebaseFirestore.instance.collection('users').doc(userId).collection('payments').doc();
    Payment newPayment = Payment(
      id: pref.id,
      bills: paymentBills,
      paymentMethod: 'gpay',
      paymentdate: DateTime.now(),
      totalamount: total
    );
    await pref.set(newPayment.toMap());

    emit(PaymentRequestSentState());
  } catch (e) {
    emit(HomeErrorState(errmsg: e.toString()));
  } 

      }
    });
on<CashPaymentEvent>((event, emit) async {
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
    List<Bill> paymentBills = [];
    for (var doc in docs) {
      DocumentReference docRef = doc.reference;
      batch.update(docRef, {'ispaid': 'pending'});

      final data = doc.data() as Map<String, dynamic>;
      paymentBills.add(Bill.fromMap(data));
    }

    // Commit batch update
    await batch.commit();

    // Create and save the payment document
    DocumentReference pref = FirebaseFirestore.instance.collection('users').doc(userId).collection('payments').doc();
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
    await pref.set(newPayment.toMap());

    emit(PaymentRequestSentState());
  } catch (e) {
    emit(HomeErrorState(errmsg: e.toString()));
  }
});
  }
}
