// To parse this JSON data, do
//
//     final favoritesModel = favoritesModelFromJson(jsonString);

import 'dart:convert';

FavoritesModel favoritesModelFromJson(String str) => FavoritesModel.fromJson(json.decode(str));

String favoritesModelToJson(FavoritesModel data) => json.encode(data.toJson());

class FavoritesModel {
  final int? code;
  final FavoritesModelData? data;

  FavoritesModel({
    this.code,
    this.data,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) => FavoritesModel(
    code: json["code"],
    data: json["data"] == null ? null : FavoritesModelData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data?.toJson(),
  };
}

class FavoritesModelData {
  final List<Favorite>? favorites;

  FavoritesModelData({
    this.favorites,
  });

  factory FavoritesModelData.fromJson(Map<String, dynamic> json) => FavoritesModelData(
    favorites: json["favorites"] == null ? [] : List<Favorite>.from(json["favorites"]!.map((x) => Favorite.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "favorites": favorites == null ? [] : List<dynamic>.from(favorites!.map((x) => x.toJson())),
  };
}

class Favorite {
  final FavoriteData? data;

  Favorite({
    this.data,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    data: json["data"] == null ? null : FavoriteData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class FavoriteData {
  final int? id;
  final String? name;
  final String? image;

  FavoriteData({
    this.id,
    this.name,
    this.image,
  });

  factory FavoriteData.fromJson(Map<String, dynamic> json) => FavoriteData(
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
