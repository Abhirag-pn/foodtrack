import 'package:foodtrack/models/billmodel.dart';

class Payment {
  final String id;
  final String userid;
  final List<Bill> contents;
  final bool ispaid; // Now a final property
  DateTime? paymentdate;
  final String? paymentMethod;

  Payment(
      {required this.id,
      required this.userid,
      required this.contents,
      this.ispaid = false,
      this.paymentMethod,
      this.paymentdate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'contents': contents.map((bill) => bill.toMap()).toList(),
      'ispaid': ispaid,
      'paymentdate': paymentdate?.millisecondsSinceEpoch,
      'paymentMethod': paymentMethod,
      'userid': userid
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) => Payment(
        userid: map['userid'] as String,
        paymentMethod: map['paymentMethod'] as String,
        id: map['id'] as String,
        contents: (map['contents'] as List)
            .map((billMap) => Bill.fromMap(billMap as Map<String, dynamic>))
            .toList(),
        ispaid: map['ispaid'] as bool,
        paymentdate: map['paymentdate'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['paymentdate'] as int)
            : null,
      );
}
