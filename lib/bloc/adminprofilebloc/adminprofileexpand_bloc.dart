import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodtrack/bloc/homebloc/home_bloc.dart';
import 'package:foodtrack/models/billmodel.dart';
import 'package:foodtrack/models/usermodel.dart';
import 'package:logger/logger.dart';
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
            .collection('payments')
            .where('isCompleted', isEqualTo: false)
            .where('isRejected', isEqualTo: false)
            .get();
        var requests = reqsnapshot.docs.map((doc) {
          final data = doc.data();
          return Payment.fromMap(data);
        }).toList();
        log(requests.toString());

        emit(AdminBillLoadedState(
          requests: requests,
          bills: bills,
          username: userob.name,
        ));
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
      emit(MarkAsPaidClickedState(requests: event.requests));
    });
    on<MarkAsPaidConfirmedEvent>((event, emit) async {
      try {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        final DocumentSnapshot pd = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('payments')
            .doc(event.paymentreqid)
            .get();
        List<Bill> billsList = pd['bills'];
        WriteBatch batch = FirebaseFirestore.instance.batch();
        for (Bill b in billsList) {
          String id = b.id;
          DocumentReference billRef = FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('bills')
              .doc(id);

          batch.update(billRef, {'ispaid': 'true'});
          await batch.commit();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('payments')
              .doc(userId)
              .set({'isCompleted': true});
        }
        emit(MarkAsPaidUpdatedState(isRejected: false));
      } catch (e) {
        emit(AdminBillErrorState(errmsg: e.toString()));
      }
    });
    on<MarkAsPaidRejectedEvent>((event, emit) async {
      try {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        Logger().e(userId);
        final  pd =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .collection('payments')
                .doc(event.paymentreqid)
                .get();
        if (pd.exists) {
          Logger().e("ERROR");
        }
        if(pd.data()!=null){
          final Payment payment = Payment.fromMap(pd.data()!);
          List<Bill> billsList = payment.bills;
        WriteBatch batch = FirebaseFirestore.instance.batch();
        for (Bill b in billsList) {
          String id = b.id;
          DocumentReference billRef = FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('bills')
              .doc(id);

          batch.update(billRef, {'ispaid': 'false'});
          await batch.commit();
        }
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('payments')
            .doc(event.paymentreqid)
            .set({'isRejected': true});
        emit(MarkAsPaidUpdatedState(isRejected: true));
        }else{
          
          emit(AdminBillErrorState(errmsg: "DNULL"));
        }
        
        
      } catch (e) {
        emit(AdminBillErrorState(errmsg: e.toString()));
      }
    });
  }
}
