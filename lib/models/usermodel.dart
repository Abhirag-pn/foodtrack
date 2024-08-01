class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        id: data['id'] as String,
        name: data['name'] as String,
        email: data['email'] as String,
        role: data['role'] as String,

      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role,
        
      };
}
