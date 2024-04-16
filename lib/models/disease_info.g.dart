// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disease_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiseaseInfoAdapter extends TypeAdapter<DiseaseInfo> {
  @override
  final int typeId = 0;

  @override
  DiseaseInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiseaseInfo(
      causes: fields[0] as String,
      effects: fields[1] as String,
      prevention: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DiseaseInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.causes)
      ..writeByte(1)
      ..write(obj.effects)
      ..writeByte(2)
      ..write(obj.prevention);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiseaseInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
