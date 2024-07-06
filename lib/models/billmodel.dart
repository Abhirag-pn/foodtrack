
import 'foodmodel.dart';

class Bill {
  final String id;
  final String paymentsetId;
  final DateTime date;
  final List<Food> items;
  final double totalAmount;


  Bill({
    required this.id,
    required this.paymentsetId,
    required this.date,
    required this.items,
    required this.totalAmount,
  
  });

  factory Bill.fromMap(Map<String, dynamic> data) => Bill(
        id: data['id'] as String,
        paymentsetId: data['user_id'] as String,
        date: (data['date'].toDateTime()),
        items: (data['items'] as List)
            .map((item) => Food.fromMap(item))
            .toList(),
        totalAmount: data['total_amount'] as double,
      
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': paymentsetId,
        'date': date,
        'items': items.map((item) => item.toMap()).toList(),
        'total_amount': totalAmount,
        
      };
}
