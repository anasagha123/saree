// ignore_for_file: non_constant_identifier_names

class StoreModel {
  final int id;
  final String name;
  final String phone;
  final String preparation_time;
  final int delivery_cost;
  final String work_time;
  final String address;
  final String description;
  final String image;
  final String f_image;
  final bool status;
  final String store_type;
  final int store_category_id;
  final int user_id;
  final DateTime? created_at;
  final DateTime? updated_at;

  StoreModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.preparation_time,
    required this.delivery_cost,
    required this.work_time,
    required this.address,
    required this.description,
    required this.image,
    required this.f_image,
    required this.status,
    required this.store_type,
    required this.store_category_id,
    required this.user_id,
    this.created_at,
    this.updated_at,
  });

  factory StoreModel.fromJson(Map<String, dynamic> map) => StoreModel(
        id: map["id"],
        name: map["name"],
        phone: map["phone"],
        preparation_time: map["preparation_time"],
        delivery_cost: map["delivery_cost"],
        work_time: map["work_time"],
        address: map["address"],
        description: map["description"],
        image: map["image"],
        f_image: map["f_image"],
        status: map["status"] == 1,
        store_type: map["store_type"],
        store_category_id: map["store_category_id"],
        user_id: map["user_id"],
      );
}
