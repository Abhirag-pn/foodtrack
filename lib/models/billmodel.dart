
import 'foodmodel.dart';

class Bill {
  final String id;
  final String date;
  final List<Food> items;
  bool ispaid;


  Bill({
    required this.id,
     this.ispaid=false,
    required this.date,
    required this.items,
    
  
  });

  factory Bill.fromMap(Map<String, dynamic> data) => Bill(
        id: data['id'] as String,
       ispaid: data['ispaid'],
        date: data['date'] as String,
        items: (data['items'] as List)
            .map((item) => Food.fromMap(item))
            .toList(),
      
      
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        
        'date': date,
        'items': items.map((item) => item.toMap()).toList(),
        'ispaid':ispaid
        
      };
}
