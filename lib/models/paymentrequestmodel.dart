
class Payment {
  final String id;
  DateTime? requestdate;
  bool isCompleted;

  Payment({required this.id, this.isCompleted=false, this.requestdate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'paymentdate': requestdate?.millisecondsSinceEpoch,
      'isCompleted': isCompleted,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) => Payment(
        
        id: map['id'] as String,
        isCompleted:map['isCompleted'],
        requestdate: map['paymentdate'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['paymentdate'] as int)
            : null,
      );
}
