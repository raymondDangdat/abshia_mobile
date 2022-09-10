// To parse this JSON data, do
//
//     final localGovernmentModel = localGovernmentModelFromJson(jsonString);

import 'dart:convert';

LocalGovernmentModel localGovernmentModelFromJson(String str) => LocalGovernmentModel.fromJson(json.decode(str));

String localGovernmentModelToJson(LocalGovernmentModel data) => json.encode(data.toJson());

class LocalGovernmentModel {
  LocalGovernmentModel({
    this.data,
  });

  Data? data;

  factory LocalGovernmentModel.fromJson(Map<String, dynamic> json) => LocalGovernmentModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.lgas,
  });

  List<Lgas>? lgas;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    lgas: List<Lgas>.from(json["lgas"].map((x) => Lgas.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "lgas": List<dynamic>.from(lgas!.map((x) => x.toJson())),
  };
}

class Lgas {
  Lgas({
    this.id,
    this.stateId,
    this.lgaName,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? stateId;
  String? lgaName;
  dynamic createdAt;
  dynamic updatedAt;

  factory Lgas.fromJson(Map<String, dynamic> json) => Lgas(
    id: json["id"],
    stateId: json["state_id"],
    lgaName: json["lga_name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "state_id": stateId,
    "lga_name": lgaName,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
