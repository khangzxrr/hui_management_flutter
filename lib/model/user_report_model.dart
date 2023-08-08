import 'package:hui_management/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserReportModel extends UserModel {
  final double fundRatio;

  final double totalCost;
  final double totalTransactionCost;

  final double totalAliveAmount;
  final double totalDeadAmount;

  UserReportModel({
    required super.id,
    required super.imageUrl,
    required super.name,
    required super.identity,
    required super.identityCreateDate,
    required super.identityAddress,
    required super.password,
    required super.phoneNumber,
    required super.bankName,
    required super.bankNumber,
    required super.address,
    required super.additionalInfo,
    required super.identityImageFrontUrl,
    required super.identityImageBackUrl,
    required super.nickName,
    required this.fundRatio,
    required this.totalCost,
    required this.totalTransactionCost,
    required this.totalAliveAmount,
    required this.totalDeadAmount,
  });

  //toString
  @override
  String toString() {
    return 'UserReportModel{id: $id, imageUrl: $imageUrl, name: $name, identity: $identity, identityCreateDate: $identityCreateDate, identityAddress: $identityAddress, phoneNumber: $phoneNumber, bankName: $bankName, bankNumber: $bankNumber, address: $address, additionalInfo: $additionalInfo, identityImageFrontUrl: $identityImageFrontUrl, identityImageBackUrl: $identityImageBackUrl, nickName: $nickName, fundRatio: $fundRatio}';
  }

  factory UserReportModel.fromJson(Map<String, dynamic> json) => _$UserReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserReportModelToJson(this);
}
