// ignore_for_file: non_constant_identifier_names

class BannerModel {
  final int id;
  final String name;
  final String image;
  final String description;
  final String type;
  final DateTime? created_at;
  final DateTime? updated_at;

  BannerModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.type,
    required this.created_at,
    required this.updated_at,
  });

  factory BannerModel.fromMap(Map<String, dynamic> map) => BannerModel(
        id: map["id"],
        name: map["name"],
        image: map["image"],
        description: map["description"],
        type: map["type"],
        created_at: DateTime.tryParse(map["created_at"] ?? ""),
        updated_at: DateTime.tryParse(map["updated_at"] ?? ""),
      );
}
