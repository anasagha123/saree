// ignore_for_file: non_constant_identifier_names

class StoreTypeModel {
  final int id;
  final String name;
  final String code;
  final String? image;
  final DateTime? created_at;
  final DateTime? updated_at;

  StoreTypeModel({
    required this.id,
    required this.name,
    required this.code,
    this.image,
    this.created_at,
    this.updated_at,
  });

  factory StoreTypeModel.fromMap(Map<String, dynamic> map) => StoreTypeModel(
        id: map["id"],
        name: map["name"],
        code: map["code"],
        image: map["image"],
        created_at: DateTime.tryParse(map["created_at"]),
        updated_at: DateTime.tryParse(map["updated_at"]),
      );
}
