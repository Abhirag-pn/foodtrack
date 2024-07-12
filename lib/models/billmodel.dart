
import 'package:cloud_firestore/cloud_firestore.dart';

import 'foodmodel.dart';

class Bill {
  final String id;
  final DateTime date;
  final double total;
  final List<Food> items;
  bool ispaid;


  Bill( {
    required this.id,
   required this.total,
     this.ispaid=false,
    required this.date,
    required this.items,
    
  
  });

  factory Bill.fromMap(Map<String, dynamic> data) => Bill(
    total: data['total'],
        id: data['id'] as String,
       ispaid: data['ispaid'],
        date: (data['date'] as Timestamp).toDate(),
        items: (data['items'] as List)
            .map((item) => Food.fromMap(item))
            .toList(),
      
      
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'total':total,
        'date': date ,
        'items': items.map((item) => item.toMap()).toList(),
        'ispaid':ispaid
        
      };
}
