// ignore_for_file: non_constant_identifier_names

class ProductModel {
  final int id;
  final String name;
  final int price;
  final int sale_price;
  final String description;
  final String image;
  final bool status;
  final int category_id;
  final int store_id;
  final int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.sale_price,
    required this.description,
    required this.image,
    required this.status,
    required this.category_id,
    required this.store_id,
    this.quantity = 0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      sale_price: json["sale_price"],
      description: json["description"],
      image: json["image"],
      status: json["status"] == 1,
      category_id: json["category_id"],
      store_id: json["store_id"],
    );
  }

  @override
  String toString() {
    return 'ProductModel{id: $id, name: $name, price: $price, sale_price: $sale_price, description: $description, image: $image, status: $status, category_id: $category_id, store_id: $store_id, quantity: $quantity}';
  }
}
