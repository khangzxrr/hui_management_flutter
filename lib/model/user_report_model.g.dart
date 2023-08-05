// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserReportModel _$UserReportModelFromJson(Map<String, dynamic> json) =>
    UserReportModel(
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
      fundRatio: (json['fundRatio'] as num).toDouble(),
    );

Map<String, dynamic> _$UserReportModelToJson(UserReportModel instance) =>
    <String, dynamic>{
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
      'fundRatio': instance.fundRatio,
    };
