class Food {
  final String id;
  final String name;
  final String type; // Optional
  final double price;
  final String imageLink;
   int qty;

  Food( {
     this.qty=0,
    required this.imageLink,
    required this.id,
    required this.name,
    required this.type,
    required this.price,
  });

  factory Food.fromMap(Map<String, dynamic> data) => Food(
        id: data['id'] as String,
        qty: data['qty'] ,
        name: data['name'] as String,
        type: data['type'] as String,
        imageLink: data['imageLink'] as String,
        price: data['price'] as double,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'qty':qty,
        'name': name,
        'type': type,
        'price': price,
        'imageLink':imageLink
      };
}
