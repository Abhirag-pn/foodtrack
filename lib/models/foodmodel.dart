class Food {
  final String id;
  final String name;
  final String?description; // Optional
  final double price;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Food.fromMap(Map<String, dynamic> data) => Food(
        id: data['id'] as String,
        name: data['name'] as String,
        description: data['description'] as String?,
        price: data['price'] as double,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
      };
}
