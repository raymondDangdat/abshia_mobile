// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.data,
  });

  Data? data;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.email,
    this.emailVerifiedAt,
    this.role,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.details,
  });

  String? id;
  String? email;
  DateTime? emailVerifiedAt;
  String? role;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Details? details;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    email: json["email"],
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
    role: json["role"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    details: Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "email_verified_at": emailVerifiedAt!.toIso8601String(),
    "role": role,
    "deleted_at": deletedAt,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "details": details!.toJson(),
  };
}

class Details {
  Details({
    this.id,
    this.name,
    this.phoneNumber,
    this.address,
    this.slug,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? phoneNumber;
  String? address;
  String? slug;
  int? status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    id: json["id"],
    name: json["name"],
    phoneNumber: json["phone_number"],
    address: json["address"],
    slug: json["slug"],
    status: json["status"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone_number": phoneNumber,
    "address": address,
    "slug": slug,
    "status": status,
    "deleted_at": deletedAt,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
