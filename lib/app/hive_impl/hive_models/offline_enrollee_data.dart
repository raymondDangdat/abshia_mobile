import 'package:hive/hive.dart';

part 'offline_enrollee_data.g.dart';

@HiveType(typeId: 2)
class OfflineEnrolleeData {
  OfflineEnrolleeData({
    required this.id,
    required this.firstName,
    required this.gender,
    required this.phoneNumber,
    required this.email,
    required this.dob,
    required this.contactAddress,
    required this.bloodGroup,
    // required this.nationality,
    required this.title,
    required this.noOfDependants,
    required this.category,
    required this.maritalStatus,
    required this.nokPhoneNumber,
    required this.nokName,
    required this.existingMedicalCondition,
    required this.genotype,
    required this.healthCare,
    required this.kidneyIssue,
    required this.cancer,
    required this.sickleCell,
    required this.hypertensive,
    required this.nokAddress,
    required this.nokRelationship,
    required this.stateId,
    required this.lastName,
    required this.lgId,
    required this.middleName,
    required this.dateRegistered
  });
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? firstName;
  @HiveField(3)
  String? gender;
  @HiveField(4)
  String? phoneNumber;
  @HiveField(5)
  String? email;
  @HiveField(6)
  String? dob;
  @HiveField(7)
  String? contactAddress;
  @HiveField(8)
  String? bloodGroup;
  // @HiveField(9)
  // String? nationality;
  @HiveField(10)
  String? nokName;
  @HiveField(11)
  String? nokPhoneNumber;
  @HiveField(12)
  String? nokRelationship;
  @HiveField(13)
  String? nokAddress;
  @HiveField(14)
  String? noOfDependants;
  @HiveField(15)
  String? maritalStatus;
  @HiveField(16)
  String? hypertensive;
  @HiveField(17)
  String? sickleCell;
  @HiveField(18)
  String? cancer;
  @HiveField(19)
  String? kidneyIssue;
  @HiveField(20)
  String? category;
  @HiveField(21)
  String? healthCare;
  @HiveField(22)
  String? genotype;
  @HiveField(23)
  String? existingMedicalCondition;
  @HiveField(24)
  String? lastName;
  @HiveField(25)
  String? middleName;
  @HiveField(26)
  String? stateId;
  @HiveField(27)
  String? lgId;
  @HiveField(28)
  DateTime? dateRegistered;

}
