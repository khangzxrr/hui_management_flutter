import 'package:hui_management/model/sub_user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub_user_with_payment_report.g.dart';

@JsonSerializable()
class SubUserWithPaymentReport extends SubUserModel {
  final double totalProcessingAmount;
  final double totalDebtAmount;
  final double totalAliveAmount;
  final double totalDeadAmount;
  final double fundRatio;
  final double totalTakenAmount;
  final double totalUnfinishedTakenAmount;

  SubUserWithPaymentReport({
    required this.totalProcessingAmount,
    required this.totalDebtAmount,
    required this.fundRatio,
    required this.totalAliveAmount,
    required this.totalDeadAmount,
    required this.totalTakenAmount,
    required this.totalUnfinishedTakenAmount,
    required int id,
    required String imageUrl,
    required String name,
    required String identity,
    required DateTime identityCreateDate,
    required String identityAddress,
    required String phoneNumber,
    required String bankName,
    required String bankNumber,
    required String address,
    required String additionalInfo,
    required String? identityImageFrontUrl,
    required String? identityImageBackUrl,
    required String nickName,
  }) : super(
          id: id,
          imageUrl: imageUrl,
          name: name,
          identity: identity,
          identityCreateDate: identityCreateDate,
          identityAddress: identityAddress,
          phoneNumber: phoneNumber,
          bankName: bankName,
          bankNumber: bankNumber,
          address: address,
          additionalInfo: additionalInfo,
          identityImageFrontUrl: identityImageFrontUrl,
          identityImageBackUrl: identityImageBackUrl,
          nickName: nickName,
        );

  //from json
  factory SubUserWithPaymentReport.fromJson(Map<String, dynamic> json) => _$SubUserWithPaymentReportFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SubUserWithPaymentReportToJson(this);

  //toString
  @override
  String toString() {
    return 'SubUserWithPaymentReport{totalCost: $totalProcessingAmount, totalTransactionCost: $totalDebtAmount, id: $id, imageUrl: $imageUrl, name: $name, identity: $identity, identityCreateDate: $identityCreateDate, identityAddress: $identityAddress, phoneNumber: $phoneNumber, bankName: $bankName, bankNumber: $bankNumber, address: $address, additionalInfo: $additionalInfo, identityImageFrontUrl: $identityImageFrontUrl, identityImageBackUrl: $identityImageBackUrl, nickName: $nickName}';
  }
}
