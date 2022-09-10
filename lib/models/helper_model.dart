// To parse this JSON data, do
//
//     final createHelper = createHelperFromJson(jsonString);

import 'dart:convert';

HelperModel createHelperFromJson(String str) => HelperModel.fromJson(json.decode(str));

String createHelperToJson(HelperModel data) => json.encode(data.toJson());

class HelperModel {
  HelperModel({
    this.data,
  });

  Data? data;

  factory HelperModel.fromJson(Map<String, dynamic> json) => HelperModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}
class Data {
  Data({
    this.hospitals,
    this.categories,
    this.states,
  });

  List<Hospital>? hospitals;
  List<Category>? categories;
  List<NgStateModel>? states;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    hospitals: List<Hospital>.from(json["hospitals"].map((x) => Hospital.fromJson(x))),
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    states: List<NgStateModel>.from(json["states"].map((x) => NgStateModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "hospitals": List<dynamic>.from(hospitals!.map((x) => x.toJson())),
    "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
    "states": List<dynamic>.from(states!.map((x) => x.toJson())),
  };
}
class Category {
  Category({
    this.id,
    this.title,
    this.description,
    this.slug,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? description;
  String? slug;
  DateTime? deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    slug: json["slug"],
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "slug": slug,
    "deleted_at": deletedAt == null ? null : deletedAt!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class Hospital {
  Hospital({
    this.id,
    this.userId,
    this.name,
    this.address,
    this.phoneNumber,
    this.status,
    this.lgaId,
    this.slug,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? userId;
  String? name;
  String? address;
  String? phoneNumber;
  int? status;
  int? lgaId;
  String? slug;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    address: json["address"],
    phoneNumber: json["phone_number"],
    status: json["status"],
    lgaId: json["lga_id"],
    slug: json["slug"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "address": address,
    "phone_number": phoneNumber,
    "status": status,
    "lga_id": lgaId,
    "slug": slug,
    "deleted_at": deletedAt,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class NgStateModel {
  NgStateModel({
    this.id,
    this.stateName,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? stateName;
  dynamic createdAt;
  dynamic updatedAt;

  factory NgStateModel.fromJson(Map<String, dynamic> json) => NgStateModel(
    id: json["id"],
    stateName: json["state_name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "state_name": stateName,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
