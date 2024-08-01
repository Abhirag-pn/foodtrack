import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodtrack/bloc/homebloc/home_bloc.dart';
import 'package:foodtrack/models/billmodel.dart';
import 'package:foodtrack/models/usermodel.dart';
import 'package:meta/meta.dart';

import '../../models/paymentmodel.dart';


part 'adminprofileexpand_event.dart';
part 'adminprofileexpand_state.dart';

class AdminprofileexpandBloc
    extends Bloc<AdminprofileexpandEvent, AdminprofileexpandState> {
  AdminprofileexpandBloc() : super(AdminprofileexpandInitial()) {
    on<AdminGetBillsEvent>((event, emit) async {
      emit(AdminBillLoadingState());
      try {
        final userdoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(event.userid)
            .get();
        log(userdoc.toString());
        final userob = UserModel.fromMap(userdoc.data()!);
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(event.userid)
            .collection('bills')
            .where('ispaid', isEqualTo: false)
            .get();

        log('Fetched bills: ${snapshot.docs.length}');

        var bills = snapshot.docs.map((doc) {
          final data = doc.data();
          log('Bill data: $data');
          return Bill.fromMap(data);
        }).toList();

        final reqsnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(event.userid)
            .collection('paymentrequests')
            .where('isCompleted', isEqualTo: false)
            .where('isRejected', isEqualTo: false)
            .get();
        var requests = reqsnapshot.docs.map((doc) {
          final data = doc.data();
          return Payment.fromMap(data);
        }).toList();
        log(requests.toString());

        emit(AdminBillLoadedState(
            bills: bills, username: userob.name,));
      } catch (e, s) {
        log(e.toString());
        log(s.toString());
        emit(AdminBillErrorState(errmsg: e.toString()));
      }
    });
    on<AdminBillExpandEvent>((event, emit) async {
      try {
        log("BillExpand clicked");
        emit(AdminBillExpandedState(
          bill: event.bill,
        ));
      } catch (e) {
        log(e.toString());
      }
    });
    on<MarkAsPaidClickedEvent>((event, emit) async {
      emit(MarkAsPaidClickedState());
    });
    on<MarkAsPaidConfirmedEvent>((event, emit) async {
      
       try {
          String userId = FirebaseAuth.instance.currentUser!.uid;
          final QuerySnapshot qs = await FirebaseFirestore.instance
              .collection('users').doc(userId).collection('bills')
              .where('ispaid', isEqualTo: 'pending')
              .get();
          List<QueryDocumentSnapshot> docs = qs.docs;
          WriteBatch batch = FirebaseFirestore.instance.batch();
          for (var doc in docs) {
            DocumentReference docRef = doc.reference;

            batch.update(docRef, {'ispaid': 'true'});
            await batch.commit();
          }
          emit(MarkAsPaidUpdatedState(isRejected: false));
         
        } catch (e) {
          emit(AdminBillErrorState(errmsg: e.toString()));
        }
      
    });
  }
}
