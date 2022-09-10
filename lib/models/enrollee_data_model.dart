// To parse this JSON data, do
//
//     final enrolleeDadaModel = enrolleeDadaModelFromJson(jsonString);

import 'dart:convert';

EnrolleeDataModel enrolleeDadaModelFromJson(String str) => EnrolleeDataModel.fromJson(json.decode(str));

String enrolleeDadaModelToJson(EnrolleeDataModel data) => json.encode(data.toJson());

class EnrolleeDataModel {
  EnrolleeDataModel({
    this.title,
    this.email,
    this.phoneNumber,
    this.address,
    this.surname,
    this.firstName,
    this.middleName,
    this.gender,
    this.dob,
    this.bloodGroup,
    this.town,
    this.nokName,
    this.nokAddress,
    this.nokRelationship,
    this.nokPhone,
    this.categoryId,
    this.mdaSchoolName,
    this.healthCareId,
    this.existingMedicalCondition,
    this.hypertension,
    this.sickleCell,
    this.cancer,
    this.stateId,
    this.lgaId,
    this.genotype,
    this.maritalStatus,
    this.noOfDependants,
    this.kidneyIssue,
  });

  String? title;
  String? email;
  String? phoneNumber;
  String? address;
  String? surname;
  String? firstName;
  String? middleName;
  String? gender;
  DateTime? dob;
  String? bloodGroup;
  String? town;
  String? nokName;
  String? nokAddress;
  String? nokRelationship;
  String? nokPhone;
  int? categoryId;
  String? mdaSchoolName;
  int? healthCareId;
  String? existingMedicalCondition;
  int? hypertension;
  int? sickleCell;
  int? cancer;
  int? stateId;
  int? lgaId;
  String? genotype;
  String? maritalStatus;
  int? noOfDependants;
  int? kidneyIssue;

  factory EnrolleeDataModel.fromJson(Map<String, dynamic> json) => EnrolleeDataModel(
    title: json["title"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    address: json["address"],
    surname: json["surname"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    gender: json["gender"],
    dob: DateTime.parse(json["dob"]),
    bloodGroup: json["blood_group"],
    town: json["town"],
    nokName: json["nok_name"],
    nokAddress: json["nok_address"],
    nokRelationship: json["nok_relationship"],
    nokPhone: json["nok_phone"],
    categoryId: json["category_id"],
    mdaSchoolName: json["mda_school_name"],
    healthCareId: json["health_care_id"],
    existingMedicalCondition: json["existing_medical_condition"],
    hypertension: json["hypertension"],
    sickleCell: json["sickle_cell"],
    cancer: json["cancer"],
    stateId: json["state_id"],
    lgaId: json["lga_id"],
    genotype: json["genotype"],
    maritalStatus: json["marital_status"],
    noOfDependants: json["no_of_dependants"],
    kidneyIssue: json["kidney_issue"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "email": email,
    "phone_number": phoneNumber,
    "address": address,
    "surname": surname,
    "first_name": firstName,
    "middle_name": middleName,
    "gender": gender,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "blood_group": bloodGroup,
    "town": town,
    "nok_name": nokName,
    "nok_address": nokAddress,
    "nok_relationship": nokRelationship,
    "nok_phone": nokPhone,
    "category_id": categoryId,
    "mda_school_name": mdaSchoolName,
    "health_care_id": healthCareId,
    "existing_medical_condition": existingMedicalCondition,
    "hypertension": hypertension,
    "sickle_cell": sickleCell,
    "cancer": cancer,
    "state_id": stateId,
    "lga_id": lgaId,
    "genotype": genotype,
    "marital_status": maritalStatus,
    "no_of_dependants": noOfDependants,
    "kidney_issue": kidneyIssue,
  };
}
