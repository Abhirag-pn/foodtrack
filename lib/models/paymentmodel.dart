// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:foodtrack/models/billmodel.dart';

class Payment {
  final List<Bill> bills;
  double totalamount;
  DateTime? paymentdate;
  String id;
  bool isCompleted;
  bool isRejected;
  final String? paymentMethod;

  Payment(
      {required this.bills,
      required this.paymentMethod,
      required this.paymentdate,
      required this.totalamount,
      required this.id,
      this.isCompleted = false,
      this.isRejected = false});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bills': bills.map((x) => x.toMap()).toList(),
      'totalamount': totalamount,
      'paymentdate': paymentdate?.millisecondsSinceEpoch,
      'id': id,
      'isCompleted': isCompleted,
      'isRejected': isRejected,
      'paymentMethod': paymentMethod,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      bills: List<Bill>.from(
        (map['bills'] as List<int>).map<Bill>(
          (x) => Bill.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalamount: map['totalamount'] as double,
      paymentdate: map['paymentdate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['paymentdate'] as int)
          : null,
      id: map['id'],
      isCompleted: map['isCompleted'] as bool,
      isRejected: map['isRejected'] as bool,
      paymentMethod:
          map['paymentMethod'] != null ? map['paymentMethod'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Payment.fromJson(String source) =>
      Payment.fromMap(json.decode(source) as Map<String, dynamic>);
}
