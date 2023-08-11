// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubUserModel _$SubUserModelFromJson(Map<String, dynamic> json) => SubUserModel(
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      identity: json['identity'] as String,
      identityCreateDate: DateTime.parse(json['identityCreateDate'] as String),
      identityAddress: json['identityAddress'] as String,
      phoneNumber: json['phoneNumber'] as String,
      bankName: json['bankName'] as String,
      bankNumber: json['bankNumber'] as String,
      address: json['address'] as String,
      additionalInfo: json['additionalInfo'] as String,
      identityImageFrontUrl: json['identityImageFrontUrl'] as String?,
      identityImageBackUrl: json['identityImageBackUrl'] as String?,
      nickName: json['nickName'] as String,
    );

Map<String, dynamic> _$SubUserModelToJson(SubUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'identity': instance.identity,
      'identityCreateDate': instance.identityCreateDate.toIso8601String(),
      'identityAddress': instance.identityAddress,
      'phoneNumber': instance.phoneNumber,
      'bankName': instance.bankName,
      'bankNumber': instance.bankNumber,
      'address': instance.address,
      'additionalInfo': instance.additionalInfo,
      'identityImageFrontUrl': instance.identityImageFrontUrl,
      'identityImageBackUrl': instance.identityImageBackUrl,
      'nickName': instance.nickName,
    };
