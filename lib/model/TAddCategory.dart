class TAddCategory {
  final int code;
  final String message;
  final Data data;

  TAddCategory({
    required this.code,
    required this.message,
    required this.data,
  });

  factory TAddCategory.fromJson(Map<String, dynamic> json) => TAddCategory(
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
  final Category category;

  Data({
    required this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    category: Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "category": category.toJson(),
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
