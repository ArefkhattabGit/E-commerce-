class TManageUsers {
  final List<Datum> data;

  TManageUsers({
    required this.data,
  });

  factory TManageUsers.fromJson(Map<String, dynamic> json) => TManageUsers(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final int id;
  final String name;
  final String email;
  final List<Role> roles;
  String status;
  final DateTime createdAt;

  Datum({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
    required this.status,
    required this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
    "status": status,
    "created_at": createdAt.toIso8601String(),
  };
}

class Role {
  final int id;
  final String name;

  Role({
    required this.id,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
