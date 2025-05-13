// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condition.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConditionAdapter extends TypeAdapter<Condition> {
  @override
  final int typeId = 1;

  @override
  Condition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Condition(
      uuid: fields[0] as String,
      from: fields[1] as double?,
      to: fields[2] as double?,
      price: fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Condition obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.from)
      ..writeByte(2)
      ..write(obj.to)
      ..writeByte(3)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConditionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
