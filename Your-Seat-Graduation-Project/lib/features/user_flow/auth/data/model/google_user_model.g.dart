// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoogleUserModelAdapter extends TypeAdapter<GoogleUserModel> {
  @override
  final int typeId = 1;

  @override
  GoogleUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoogleUserModel(
      name: fields[0] as String,
      email: fields[1] as String,
      password: fields[2] as String?,
      dateOfBirth: fields[3] as String?,
      image: fields[4] as String?,
      gender: fields[5] as String?,
      location: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GoogleUserModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.dateOfBirth)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoogleUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
