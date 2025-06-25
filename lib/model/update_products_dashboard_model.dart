class TUpdateProductClassDashboardModel {
  final int? code;
  final String? message;
  final Data? data;

  TUpdateProductClassDashboardModel({
    this.code,
    this.message,
    this.data,
  });

  factory TUpdateProductClassDashboardModel.fromJson(Map<String, dynamic> json) => TUpdateProductClassDashboardModel(
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final int? id;
  final int? userId;
  final String? name;
  final String? slug;
  final dynamic description;
  final dynamic  price;
  final dynamic  discount;
  final dynamic  finalPrice;
  final dynamic  quantity;
  final int? isAvailable;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  Data({
    this.id,
    this.userId,
    this.name,
    this.slug,
    this.description,
    this.price,
    this.discount,
    this.finalPrice,
    this.quantity,
    this.isAvailable,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
