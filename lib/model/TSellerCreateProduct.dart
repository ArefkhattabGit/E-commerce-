class TSellerCreateProduct {
  final int code;
  final String message;
  final Data data;

  TSellerCreateProduct({
    required this.code,
    required this.message,
    required this.data,
  });

  factory TSellerCreateProduct.fromJson(Map<String, dynamic> json) => TSellerCreateProduct(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final Product product;

  Data({
    required this.product,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "product": product.toJson(),
  };
}

class Product {
  final int id;
  final int userId;
  final String name;
  final String slug;
  final dynamic description;
  final String price;
  final String discount;
  final int finalPrice;
  final String quantity;
  final dynamic isAvailable;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  Product({
    required this.id,
    required this.userId,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.discount,
    required this.finalPrice,
    required this.quantity,
    required this.isAvailable,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"],
    price: json["price"],
    discount: json["discount"],
    finalPrice: json["final_price"],
    quantity: json["quantity"],
    isAvailable: json["is_available"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "slug": slug,
    "description": description,
    "price": price,
    "discount": discount,
    "final_price": finalPrice,
    "quantity": quantity,
    "is_available": isAvailable,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
