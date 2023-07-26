// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      identity: json['identity'] as String,
      password: json['password'] as String,
      phonenumber: json['phonenumber'] as String,
      bankname: json['bankname'] as String,
      banknumber: json['banknumber'] as String,
      address: json['address'] as String,
      additionalInfo: json['additionalInfo'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'identity': instance.identity,
      'password': instance.password,
      'phonenumber': instance.phonenumber,
      'bankname': instance.bankname,
      'banknumber': instance.banknumber,
      'address': instance.address,
      'additionalInfo': instance.additionalInfo,
    };
