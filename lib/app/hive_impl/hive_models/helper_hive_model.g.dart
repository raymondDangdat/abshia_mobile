// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helper_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HelperHiveModelAdapter extends TypeAdapter<HelperHiveModel> {
  @override
  final int typeId = 3;

  @override
  HelperHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HelperHiveModel(
      id: fields[0] as String?,
      helper: fields[1] as HelperModel?,
    );
  }

  @override
  void write(BinaryWriter writer, HelperHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.helper);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HelperHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
