// ignore_for_file: non_constant_identifier_names

class UserModel {
  final int id;
  final String name;
  final String phone;
  final String? email;
  final String role;
  final DateTime? email_verified_at;
  final int status;
  final DateTime? created_at;
  final DateTime? updated_at;
  final UserLocationModel location;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    required this.role,
    this.email_verified_at,
    required this.status,
    this.created_at,
    this.updated_at,
    required this.location,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"],
      name: map["name"],
      phone: map["phone"],
      email: map["email"],
      role: map["role"],
      email_verified_at: DateTime.tryParse(map["email_verified_at"] ?? ""),
      status: map["status"],
      created_at: DateTime.tryParse(map["created_at"] ?? ""),
      updated_at: DateTime.tryParse(map["updated_at"] ?? ""),
      location: UserLocationModel.fromMap(map["location"]),
    );
  }
}

class UserLocationModel {
  final int id;
  final String address;
  final int user_id;
  final DateTime? created_at;
  final DateTime? updated_at;

  UserLocationModel({
    required this.id,
    required this.address,
    required this.user_id,
    this.created_at,
    this.updated_at,
  });

  factory UserLocationModel.fromMap(Map<String, dynamic> map) =>
      UserLocationModel(
        id: map["id"],
        address: map["address"],
        user_id: map["user_id"],
        created_at: DateTime.tryParse(map["created_at"] ?? ""),
        updated_at: DateTime.tryParse(map["updated_at"] ?? ""),
      );
}
