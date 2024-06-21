
import 'foodmodel.dart';

class Bill {
  final String id;
  final String userId;
  final DateTime date;
  final List<Food> items;
  final double totalAmount;
  final String paymentMethod;

  Bill({
    required this.id,
    required this.userId,
    required this.date,
    required this.items,
    required this.totalAmount,
    required this.paymentMethod,
  });

  factory Bill.fromMap(Map<String, dynamic> data) => Bill(
        id: data['id'] as String,
        userId: data['user_id'] as String,
        date: (data['date'].toDateTime()),
        items: (data['items'] as List)
            .map((item) => Food.fromMap(item))
            .toList(),
        totalAmount: data['total_amount'] as double,
        paymentMethod: data['payment_method'] as String,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'date': date,
        'items': items.map((item) => item.toMap()).toList(),
        'total_amount': totalAmount,
        'payment_method': paymentMethod,
      };
}
