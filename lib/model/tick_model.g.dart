// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tick_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TickAdapter extends TypeAdapter<Tick> {
  @override
  final int typeId = 0;

  @override
  Tick read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tick(title: fields[0] as String, description: fields[1] as String);
  }

  @override
  void write(BinaryWriter writer, Tick obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TickAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
