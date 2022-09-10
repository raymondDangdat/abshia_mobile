// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_enrollee_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfflineEnrolleeDataAdapter extends TypeAdapter<OfflineEnrolleeData> {
  @override
  final int typeId = 2;

  @override
  OfflineEnrolleeData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfflineEnrolleeData(
      id: fields[0] as String?,
      firstName: fields[2] as String?,
      gender: fields[3] as String?,
      phoneNumber: fields[4] as String?,
      email: fields[5] as String?,
      dob: fields[6] as String?,
      contactAddress: fields[7] as String?,
      bloodGroup: fields[8] as String?,
      title: fields[1] as String?,
      noOfDependants: fields[14] as String?,
      category: fields[20] as String?,
      maritalStatus: fields[15] as String?,
      nokPhoneNumber: fields[11] as String?,
      nokName: fields[10] as String?,
      existingMedicalCondition: fields[23] as String?,
      genotype: fields[22] as String?,
      healthCare: fields[21] as String?,
      kidneyIssue: fields[19] as String?,
      cancer: fields[18] as String?,
      sickleCell: fields[17] as String?,
      hypertensive: fields[16] as String?,
      nokAddress: fields[13] as String?,
      nokRelationship: fields[12] as String?,
      stateId: fields[26] as String?,
      lastName: fields[24] as String?,
      lgId: fields[27] as String?,
      middleName: fields[25] as String?,
      dateRegistered: fields[28] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, OfflineEnrolleeData obj) {
    writer
      ..writeByte(28)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.dob)
      ..writeByte(7)
      ..write(obj.contactAddress)
      ..writeByte(8)
      ..write(obj.bloodGroup)
      ..writeByte(10)
      ..write(obj.nokName)
      ..writeByte(11)
      ..write(obj.nokPhoneNumber)
      ..writeByte(12)
      ..write(obj.nokRelationship)
      ..writeByte(13)
      ..write(obj.nokAddress)
      ..writeByte(14)
      ..write(obj.noOfDependants)
      ..writeByte(15)
      ..write(obj.maritalStatus)
      ..writeByte(16)
      ..write(obj.hypertensive)
      ..writeByte(17)
      ..write(obj.sickleCell)
      ..writeByte(18)
      ..write(obj.cancer)
      ..writeByte(19)
      ..write(obj.kidneyIssue)
      ..writeByte(20)
      ..write(obj.category)
      ..writeByte(21)
      ..write(obj.healthCare)
      ..writeByte(22)
      ..write(obj.genotype)
      ..writeByte(23)
      ..write(obj.existingMedicalCondition)
      ..writeByte(24)
      ..write(obj.lastName)
      ..writeByte(25)
      ..write(obj.middleName)
      ..writeByte(26)
      ..write(obj.stateId)
      ..writeByte(27)
      ..write(obj.lgId)
      ..writeByte(28)
      ..write(obj.dateRegistered);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineEnrolleeDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
