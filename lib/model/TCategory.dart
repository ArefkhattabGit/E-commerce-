class TCategory {
  final int code;
  final Data data;

  TCategory({
    required this.code,
    required this.data,
  });

  factory TCategory.fromJson(Map<String, dynamic> json) => TCategory(
    code: json["code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data.toJson(),
  };
}

class Data {
  final List<Product> products;

  Data({
    required this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  final int id;
  final int userId;
  final String name;
  final String slug;
  final String? description;
  final String price;
  final String discount;
  final int finalPrice;
  final int quantity;
  final int isAvailable;
  final String? image;
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
