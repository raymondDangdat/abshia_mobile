// To parse this JSON data, do
//
//     final agentUser = agentUserFromJson(jsonString);

import 'dart:convert';

AgentUser agentUserFromJson(String str) => AgentUser.fromJson(json.decode(str));

String agentUserToJson(AgentUser data) => json.encode(data.toJson());

class AgentUser {
  AgentUser({
    this.token,
    this.user,
    this.tokenType,
    this.success,
  });

  dynamic token;
  User? user;
  dynamic tokenType;
  bool? success;

  factory AgentUser.fromJson(Map<String, dynamic> json) => AgentUser(
    token: json["token"],
    user: User.fromJson(json["user"]),
    tokenType: json["token_type"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user!.toJson(),
    "token_type": tokenType,
    "success": success,
  };
}

class User {
  User({
    this.id,
    this.email,
    this.emailVerifiedAt,
    this.role,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.details,
  });

  dynamic id;
  dynamic email;
  DateTime? emailVerifiedAt;
  dynamic role;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Details? details;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
    this.code,
    this.name,
    this.phoneNumber,
    this.address,
    this.slug,
    this.status,
    this.relationships,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic code;
  dynamic name;
  dynamic phoneNumber;
  dynamic address;
  dynamic slug;
  dynamic status;
  DetailsRelationships? relationships;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    phoneNumber: json["phone_number"],
    address: json["address"],
    slug: json["slug"],
    status: json["status"],
    relationships: DetailsRelationships.fromJson(json["relationships"]),
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "phone_number": phoneNumber,
    "address": address,
    "slug": slug,
    "status": status,
    "relationships": relationships!.toJson(),
    "deleted_at": deletedAt,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class DetailsRelationships {
  DetailsRelationships({
    this.enrolledUsers,
  });

  List<EnrolledUser>? enrolledUsers;

  factory DetailsRelationships.fromJson(Map<String, dynamic> json) => DetailsRelationships(
    enrolledUsers: List<EnrolledUser>.from(json["enrolled_users"].map((x) => EnrolledUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "enrolled_users": List<dynamic>.from(enrolledUsers!.map((x) => x.toJson())),
  };
}

class EnrolledUser {
  EnrolledUser({
    this.id,
    this.empId,
    this.title,
    this.surname,
    this.firstName,
    this.middleName,
    this.gender,
    this.phoneNumber,
    this.dob,
    this.address,
    this.bloodGroup,
    this.town,
    this.nokName,
    this.nokAddress,
    this.nokPhone,
    this.nokRelationship,
    this.mdaSchoolName,
    this.genotype,
    this.maritalStatus,
    this.noOfDependants,
    this.existingMedicalCondition,
    this.hypertension,
    this.sickleCell,
    this.cancer,
    this.kidneyIssue,
    this.slug,
    this.relationships,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic empId;
  dynamic title;
  dynamic surname;
  dynamic firstName;
  dynamic middleName;
  dynamic gender;
  dynamic phoneNumber;
  DateTime? dob;
  dynamic address;
  dynamic bloodGroup;
  dynamic town;
  dynamic nokName;
  dynamic nokAddress;
  dynamic nokPhone;
  dynamic nokRelationship;
  dynamic mdaSchoolName;
  dynamic genotype;
  dynamic maritalStatus;
  dynamic noOfDependants;
  dynamic existingMedicalCondition;
  dynamic hypertension;
  dynamic sickleCell;
  dynamic cancer;
  dynamic kidneyIssue;
  dynamic slug;
  EnrolledUserRelationships? relationships;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory EnrolledUser.fromJson(Map<String, dynamic> json) => EnrolledUser(
    id: json["id"],
    empId: json["emp_id"],
    title: json["title"],
    surname: json["surname"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    gender: json["gender"],
    phoneNumber: json["phone_number"],
    dob: DateTime.parse(json["dob"]),
    address: json["address"],
    bloodGroup: json["blood_group"],
    town: json["town"],
    nokName: json["nok_name"],
    nokAddress: json["nok_address"],
    nokPhone: json["nok_phone"],
    nokRelationship: json["nok_relationship"],
    mdaSchoolName: json["mda_school_name"],
    genotype: json["genotype"],
    maritalStatus: json["marital_status"],
    noOfDependants: json["no_of_dependants"],
    existingMedicalCondition: json["existing_medical_condition"],
    hypertension: json["hypertension"],
    sickleCell: json["sickle_cell"],
    cancer: json["cancer"],
    kidneyIssue: json["kidney_issue"],
    slug: json["slug"],
    relationships: EnrolledUserRelationships.fromJson(json["relationships"]),
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_id": empId,
    "title": title,
    "surname": surname,
    "first_name": firstName,
    "middle_name": middleName,
    "gender": gender,
    "phone_number": phoneNumber,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "address": address,
    "blood_group": bloodGroup,
    "town": town,
    "nok_name": nokName,
    "nok_address": nokAddress,
    "nok_phone": nokPhone,
    "nok_relationship": nokRelationship,
    "mda_school_name": mdaSchoolName,
    "genotype": genotype,
    "marital_status": maritalStatus,
    "no_of_dependants": noOfDependants,
    "existing_medical_condition": existingMedicalCondition,
    "hypertension": hypertension,
    "sickle_cell": sickleCell,
    "cancer": cancer,
    "kidney_issue": kidneyIssue,
    "slug": slug,
    "relationships": relationships!.toJson(),
    "deleted_at": deletedAt,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class EnrolledUserRelationships {
  EnrolledUserRelationships({
    this.state,
    this.lga,
    this.primaryHealthcare,
    this.agents,
  });

  dynamic state;
  dynamic lga;
  dynamic primaryHealthcare;
  dynamic agents;

  factory EnrolledUserRelationships.fromJson(Map<String, dynamic> json) => EnrolledUserRelationships(
    state: json["state"],
    lga: json["lga"],
    primaryHealthcare: json["primary_healthcare"],
    agents: json["agents"],
  );

  Map<String, dynamic> toJson() => {
    "state": state,
    "lga": lga,
    "primary_healthcare": primaryHealthcare,
    "agents": agents,
  };
}
