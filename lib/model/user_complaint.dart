class UseComplaint {
  int code;
  Data data;

  UseComplaint({
    required this.code,
    required this.data,
  });

  factory UseComplaint.fromJson(Map<String, dynamic> json) => UseComplaint(
    code: json["code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data.toJson(),
  };
}

class Data {
  String message;
  Complaint complaint;

  Data({
    required this.message,
    required this.complaint,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    message: json["message"],
    complaint: Complaint.fromJson(json["complaint"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "complaint": complaint.toJson(),
  };
}

class Complaint {
  int userId;
  String description;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Complaint({
    required this.userId,
    required this.description,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
    userId: json["user_id"],
    description: json["description"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "description": description,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
