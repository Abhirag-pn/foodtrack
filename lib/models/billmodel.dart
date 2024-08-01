// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'foodmodel.dart';

class Bill {
  final DateTime date;
  final double total;
  final List<Food> items;
  String ispaid;

  Bill({
    required this.total,
    this.ispaid = "false",
    required this.date,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'total': total,
      'items': items.map((x) => x.toMap()).toList(),
      'ispaid': ispaid,
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      total: map['total'] as double,
      items: List<Food>.from(
        (map['items'] as List<int>).map<Food>(
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
