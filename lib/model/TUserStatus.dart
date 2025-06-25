class TUserStatus {
  final bool status;
  final String message;
  final User user;

  TUserStatus({
    required this.status,
    required this.message,
    required this.user,
  });

  factory TUserStatus.fromJson(Map<String, dynamic> json) => TUserStatus(
    status: json["status"],
    message: json["message"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "user": user.toJson(),
  };
}

class User {
  final int id;
  final String name;
  final String email;
  final String status;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "status": status,
    "created_at": createdAt.toIso8601String(),
  };
}
