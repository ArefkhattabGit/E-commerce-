class UserProfile {
  final int id;
  final String name;
  final String email;
  final String status;
  final Location location;
  final DateTime createdAt;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.location,
    required this.createdAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    status: json["status"],
    location: Location.fromJson(json["location"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "status": status,
    "location": location.toJson(),
    "created_at": createdAt.toIso8601String(),
  };
}

class Location {
  final int id;
  final int userId;
  final String street;
  final String building;
  final String area;
  final DateTime createdAt;

  Location({
    required this.id,
    required this.userId,
    required this.street,
    required this.building,
    required this.area,
    required this.createdAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    userId: json["user_id"],
    street: json["street"],
    building: json["building"],
    area: json["area"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "street": street,
    "building": building,
    "area": area,
    "created_at": createdAt.toIso8601String(),
  };
}
