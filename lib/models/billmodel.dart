
import 'package:cloud_firestore/cloud_firestore.dart';

import 'foodmodel.dart';

class Bill {
  final DateTime date;
  final double total;
  final List<Food> items;
  bool ispaid;


  Bill( {

   required this.total,
     this.ispaid=false,
    required this.date,
    required this.items,
    
  
  });

  factory Bill.fromMap(Map<String, dynamic> data) => Bill(
    total: data['total'],
       ispaid: data['ispaid'],
        date: (data['date'] as Timestamp).toDate(),
        items: (data['items'] as List)
            .map((item) => Food.fromMap(item))
            .toList(),
      
      
      );

  Map<String, dynamic> toMap() => {

        'total':total,
        'date': date  ,
        'items': items.map((item) => item.toMap()).toList(),
        'ispaid':ispaid
        
      };
}
