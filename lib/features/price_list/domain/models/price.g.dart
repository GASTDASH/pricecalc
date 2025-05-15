// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PriceAdapter extends TypeAdapter<Price> {
  @override
  final int typeId = 0;

  @override
  Price read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Price(
      uuid: fields[0] as String,
      name: fields[1] as String?,
      defaultPrice: fields[2] as double,
      units: fields[3] as String?,
      conditions: (fields[4] as List).cast<Condition>(),
      createdAt: fields[5] as DateTime,
      groupUuid: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Price obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.defaultPrice)
      ..writeByte(3)
      ..write(obj.units)
      ..writeByte(4)
      ..write(obj.conditions)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.groupUuid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
