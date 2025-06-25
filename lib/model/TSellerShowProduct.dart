class TSellerShowSellerProduct {
  final int code;
  final Data data;

  TSellerShowSellerProduct({
    required this.code,
    required this.data,
  });

  factory TSellerShowSellerProduct.fromJson(Map<String, dynamic> json) => TSellerShowSellerProduct(
    code: json["code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data.toJson(),
  };
}

class Data {
  final List<SellerProduct> products;

  Data({
    required this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    products: List<SellerProduct>.from(json["products"].map((x) => SellerProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class SellerProduct {
  final int id;
  final int userId;
  final String name;
  final String slug;
  final dynamic description;
  final String price;
  final String discount;
  final int finalPrice;
  final int quantity;
  final int isAvailable;
  final String? image;
  final dynamic brand;
  final Category category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  SellerProduct({
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
    required this.brand,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory SellerProduct.fromJson(Map<String, dynamic> json) => SellerProduct(
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
    brand: json["brand"],
    category: Category.fromJson(json["category"]),
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
    "brand": brand,
    "category": category.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class Category {
  final int id;
  final String name;
  final dynamic description;
  final String slug;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.slug,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    slug: json["slug"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "slug": slug,
    "image": image,
  };
}
