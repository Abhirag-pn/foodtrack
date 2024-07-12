import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodtrack/models/billmodel.dart';
import 'package:foodtrack/models/foodmodel.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

part 'addfood_event.dart';
part 'addfood_state.dart';

class AddfoodBloc extends Bloc<AddfoodEvent, AddfoodState> {
  AddfoodBloc() : super(AddfoodInitial()) {
    on<GetFoodItemsEvent>((event, emit) async {
      emit(FoodLoadingState());
      try {
        if (event.type != null && event.type!.isNotEmpty) {
          var snapshot = await FirebaseFirestore.instance
              .collection('fooditems')
              .where('type', isEqualTo: event.type)
              .get();
               var fooditems = snapshot.docs.map((doc) {
          return Food.fromMap(doc.data());
        }).toList();
        emit(FoodLoadedState(fooditems: fooditems));
        }else
        {
          var snapshot = await FirebaseFirestore.instance
              .collection('fooditems').get();
               var fooditems = snapshot.docs.map((doc) {
          return Food.fromMap(doc.data());
        }).toList();
        emit(FoodLoadedState(fooditems: fooditems));
        }

       
      } catch (e) {
        emit(FoodErrorState(errmsg: e.toString()));
      }
    });

    on<AddBillEvent>((event, emit) async {
      emit(FoodLoadingState());
      try {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        DocumentReference userDocRef =
            FirebaseFirestore.instance.collection('users').doc(userId);
        final billdocRef = userDocRef.collection('bills').doc();
        final newbill = Bill(
          total:event.items
                      .fold<double>(0, (sum, food) => sum + food.price)
                       ,
          id: billdocRef.id,
          date: DateTime.now(),
          items: event.items,
          ispaid: false,
        );

        await billdocRef.set(newbill.toMap());
       
      } catch (e) {
        emit(FoodErrorState(errmsg: e.toString()));
      }
    });
  }
}
