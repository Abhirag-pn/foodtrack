import 'dart:convert';

import 'foodmodel.dart';

class Bill {
  final String id;
  final DateTime date;
  final double total;
  final List<Food> items;
  String ispaid;

  Bill({
    required this.id, 
    required this.total,
    this.ispaid = "false",
    required this.date,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id':id,
      'date': date.millisecondsSinceEpoch,
      'total': total,
      'items': items.map((x) => x.toMap()).toList(),
      'ispaid': ispaid,
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      id:map['id'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      total: map['total'] as double,
      items: List<Food>.from(
        (map['items'] as List<dynamic>).map<Food>(
          (x) => Food.fromMap(x as Map<String, dynamic>),
        ),
      ),
      ispaid: map['ispaid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bill.fromJson(String source) =>
      Bill.fromMap(json.decode(source) as Map<String, dynamic>);
}
