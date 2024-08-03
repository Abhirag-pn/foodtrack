import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../models/paymentmodel.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    on<GetHistoryEvent>((event, emit) async {
      try{final paymentsnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(event.userId)
          .collection('payments')
          .get();

      final paymentlist = paymentsnap.docs.map((doc) {
        final data = doc.data();

        return Payment.fromMap(data);
      }).toList();

      emit(HistoryLoadedState(payments: paymentlist));
    } on Exception catch(e)
    {
      emit(HistoryErrorState(errmsg: e.toString()));
    }
    });
  }
}
