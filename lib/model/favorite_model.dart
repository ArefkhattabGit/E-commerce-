class FavoriteModel {
  final int code;
  final FavoriteModelData data;

  FavoriteModel({
    required this.code,
    required this.data,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    code: json["code"],
    data: FavoriteModelData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data.toJson(),
  };
}

class FavoriteModelData {
  final String message;
  final Product product;

  FavoriteModelData({
    required this.message,
    required this.product,
  });

  factory FavoriteModelData.fromJson(Map<String, dynamic> json) => FavoriteModelData(
    message: json["message"],
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "product": product.toJson(),
  };
}

class Product {
  final ProductData data;

  Product({
    required this.data,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    data: ProductData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class ProductData {
  final int id;
  final String name;
  final String image;

  ProductData({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
