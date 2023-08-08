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
      phoneNumber: json['phoneNumber'] as String,
      bankName: json['bankName'] as String,
      bankNumber: json['bankNumber'] as String,
      address: json['address'] as String,
      additionalInfo: json['additionalInfo'] as String,
      identityImageFrontUrl: json['identityImageFrontUrl'] as String?,
      identityImageBackUrl: json['identityImageBackUrl'] as String?,
      nickName: json['nickName'] as String,
      fundRatio: (json['fundRatio'] as num).toDouble(),
      totalCost: (json['totalCost'] as num).toDouble(),
      totalTransactionCost: (json['totalTransactionCost'] as num).toDouble(),
      totalAliveAmount: (json['totalAliveAmount'] as num).toDouble(),
      totalDeadAmount: (json['totalDeadAmount'] as num).toDouble(),
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
      'phoneNumber': instance.phoneNumber,
      'bankName': instance.bankName,
      'bankNumber': instance.bankNumber,
      'address': instance.address,
      'additionalInfo': instance.additionalInfo,
      'identityImageFrontUrl': instance.identityImageFrontUrl,
      'identityImageBackUrl': instance.identityImageBackUrl,
      'nickName': instance.nickName,
      'fundRatio': instance.fundRatio,
      'totalCost': instance.totalCost,
      'totalTransactionCost': instance.totalTransactionCost,
      'totalAliveAmount': instance.totalAliveAmount,
      'totalDeadAmount': instance.totalDeadAmount,
    };
