// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationModel _$AuthenticationModelFromJson(Map<String, dynamic> json) =>
    AuthenticationModel(
      token: json['token'] as String,
      subUser: SubUserModel.fromJson(json['subUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthenticationModelToJson(
        AuthenticationModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'subUser': instance.subUser,
    };
