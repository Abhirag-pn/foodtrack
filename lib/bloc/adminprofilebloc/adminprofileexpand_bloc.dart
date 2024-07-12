import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodtrack/models/billmodel.dart';
import 'package:meta/meta.dart';

part 'adminprofileexpand_event.dart';
part 'adminprofileexpand_state.dart';

class AdminprofileexpandBloc extends Bloc<AdminprofileexpandEvent, AdminprofileexpandState> {
  AdminprofileexpandBloc() : super(AdminprofileexpandInitial()) {
    on<AdminGetBillsEvent>((event, emit) async{
      emit(AdminBillLoadingState());
  try {
   
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
log("Work AAKUnnind");
  emit(AdminBillLoadedState(bills: bills));
  }catch (e) {
    log(e.toString());
    emit(AdminBillErrorState(
      errmsg: e.toString()
    ));
  }
    });
    on<AdminBillExpandEvent>((event, emit) async{
      
   try {
        log("BillExpand clicked");
        emit(AdminBillExpandedState(bill:event.bill));
      } catch (e) {
        log(e.toString());
      }
    });

  




  }
}
