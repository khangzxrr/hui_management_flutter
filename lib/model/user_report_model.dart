import 'package:json_annotation/json_annotation.dart';

part 'user_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserReportModel {
  final int id;

  final String imageUrl;

  final String name;

  final String identity;

  final DateTime identityCreateDate;

  final String identityAddress;

  final String phoneNumber;

  final String bankName;

  final String bankNumber;

  final String address;

  final String additionalInfo;

  final String? identityImageFrontUrl;

  final String? identityImageBackUrl;

  final String nickName;

  final double fundRatio;

  UserReportModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.identity,
    required this.identityCreateDate,
    required this.identityAddress,
    required this.phoneNumber,
    required this.bankName,
    required this.bankNumber,
    required this.address,
    required this.additionalInfo,
    required this.identityImageFrontUrl,
    required this.identityImageBackUrl,
    required this.nickName,
    required this.fundRatio,
  });

  //toString
  @override
  String toString() {
    return 'UserReportModel{id: $id, imageUrl: $imageUrl, name: $name, identity: $identity, identityCreateDate: $identityCreateDate, identityAddress: $identityAddress, phoneNumber: $phoneNumber, bankName: $bankName, bankNumber: $bankNumber, address: $address, additionalInfo: $additionalInfo, identityImageFrontUrl: $identityImageFrontUrl, identityImageBackUrl: $identityImageBackUrl, nickName: $nickName, fundRatio: $fundRatio}';
  }

  factory UserReportModel.fromJson(Map<String, dynamic> json) => _$UserReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserReportModelToJson(this);
  

}
