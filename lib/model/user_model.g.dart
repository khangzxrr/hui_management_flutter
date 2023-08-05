// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 2;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as int,
      imageUrl: fields[1] as String,
      name: fields[2] as String,
      identity: fields[3] as String,
      identityCreateDate: fields[4] as DateTime,
      identityAddress: fields[5] as String,
      password: fields[6] as String,
      phonenumber: fields[7] as String,
      bankname: fields[8] as String,
      banknumber: fields[9] as String,
      address: fields[10] as String,
      additionalInfo: fields[11] as String,
      identityImageFrontUrl: fields[12] as String?,
      identityImageBackUrl: fields[13] as String?,
      nickName: fields[14] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.identity)
      ..writeByte(4)
      ..write(obj.identityCreateDate)
      ..writeByte(5)
      ..write(obj.identityAddress)
      ..writeByte(6)
      ..write(obj.password)
      ..writeByte(7)
      ..write(obj.phonenumber)
      ..writeByte(8)
      ..write(obj.bankname)
      ..writeByte(9)
      ..write(obj.banknumber)
      ..writeByte(10)
      ..write(obj.address)
      ..writeByte(11)
      ..write(obj.additionalInfo)
      ..writeByte(12)
      ..write(obj.identityImageFrontUrl)
      ..writeByte(13)
      ..write(obj.identityImageBackUrl)
      ..writeByte(14)
      ..write(obj.nickName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      identity: json['identity'] as String,
      identityCreateDate: DateTime.parse(json['identityCreateDate'] as String),
      identityAddress: json['identityAddress'] as String,
      password: json['password'] as String,
      phonenumber: json['phonenumber'] as String,
      bankname: json['bankname'] as String,
      banknumber: json['banknumber'] as String,
      address: json['address'] as String,
      additionalInfo: json['additionalInfo'] as String,
      identityImageFrontUrl: json['identityImageFrontUrl'] as String?,
      identityImageBackUrl: json['identityImageBackUrl'] as String?,
      nickName: json['nickName'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'identity': instance.identity,
      'identityCreateDate': instance.identityCreateDate.toIso8601String(),
      'identityAddress': instance.identityAddress,
      'password': instance.password,
      'phonenumber': instance.phonenumber,
      'bankname': instance.bankname,
      'banknumber': instance.banknumber,
      'address': instance.address,
      'additionalInfo': instance.additionalInfo,
      'identityImageFrontUrl': instance.identityImageFrontUrl,
      'identityImageBackUrl': instance.identityImageBackUrl,
      'nickName': instance.nickName,
    };
