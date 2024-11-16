// ignore_for_file: non_constant_identifier_names

class CategoryModel {
  final int id;
  final String name;
  final String code;
  final int store_id;

  CategoryModel({
    required this.id,
    required this.name,
    required this.code,
    required this.store_id,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      store_id: json["store_id"],
    );
  }
}
