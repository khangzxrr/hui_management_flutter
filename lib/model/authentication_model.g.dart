// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthenticationModelAdapter extends TypeAdapter<AuthenticationModel> {
  @override
  final int typeId = 1;

  @override
  AuthenticationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthenticationModel(
      token: fields[0] as String,
      user: fields[1] as UserModel,
    );
  }

  @override
  void write(BinaryWriter writer, AuthenticationModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationModel _$AuthenticationModelFromJson(Map<String, dynamic> json) =>
    AuthenticationModel(
      token: json['token'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthenticationModelToJson(
        AuthenticationModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };
