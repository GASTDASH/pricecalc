// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calc_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalcItemAdapter extends TypeAdapter<CalcItem> {
  @override
  final int typeId = 2;

  @override
  CalcItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalcItem(
      uuid: fields[0] as String,
      price: fields[1] as Price,
      quantity: fields[2] as double,
      createdAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CalcItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalcItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
