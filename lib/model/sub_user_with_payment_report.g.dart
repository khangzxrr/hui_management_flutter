// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_user_with_payment_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubUserWithPaymentReport _$SubUserWithPaymentReportFromJson(
        Map<String, dynamic> json) =>
    SubUserWithPaymentReport(
      totalProcessingAmount: (json['totalProcessingAmount'] as num).toDouble(),
      totalDebtAmount: (json['totalDebtAmount'] as num).toDouble(),
      fundRatio: (json['fundRatio'] as num).toDouble(),
      totalAliveAmount: (json['totalAliveAmount'] as num).toDouble(),
      totalDeadAmount: (json['totalDeadAmount'] as num).toDouble(),
      totalTakenAmount: (json['totalTakenAmount'] as num).toDouble(),
      totalUnfinishedTakenAmount:
          (json['totalUnfinishedTakenAmount'] as num).toDouble(),
      totalOutsideDebt: (json['totalOutsideDebt'] as num).toDouble(),
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

Map<String, dynamic> _$SubUserWithPaymentReportToJson(
        SubUserWithPaymentReport instance) =>
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
      'totalProcessingAmount': instance.totalProcessingAmount,
      'totalDebtAmount': instance.totalDebtAmount,
      'totalAliveAmount': instance.totalAliveAmount,
      'totalDeadAmount': instance.totalDeadAmount,
      'fundRatio': instance.fundRatio,
      'totalTakenAmount': instance.totalTakenAmount,
      'totalUnfinishedTakenAmount': instance.totalUnfinishedTakenAmount,
      'totalOutsideDebt': instance.totalOutsideDebt,
    };
