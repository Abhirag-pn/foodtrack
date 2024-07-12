
class Payment {
  final String id;
  DateTime? paymentdate;
  final String? paymentMethod;

  Payment({required this.id, this.paymentMethod, this.paymentdate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'paymentdate': paymentdate?.millisecondsSinceEpoch,
      'paymentMethod': paymentMethod,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) => Payment(
        paymentMethod: map['paymentMethod'] as String,
        id: map['id'] as String,
        paymentdate: map['paymentdate'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['paymentdate'] as int)
            : null,
      );
}
