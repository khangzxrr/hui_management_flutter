import 'package:hui_management/model/sub_user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_with_payment_report.g.dart';

@JsonSerializable()
class UserWithPaymentReport extends SubUserModel {
  final double totalProcessingAmount; //total cost
  final double totalDebtAmount; //total transactional cost

  UserWithPaymentReport({
    required this.totalProcessingAmount,
    required this.totalDebtAmount,
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
  factory UserWithPaymentReport.fromJson(Map<String, dynamic> json) => _$UserWithPaymentReportFromJson(json);
  Map<String, dynamic> toJson() => _$UserWithPaymentReportToJson(this);

  //toString
  @override
  String toString() {
    return 'UserWithPaymentReport{totalCost: $totalProcessingAmount, totalTransactionCost: $totalDebtAmount, id: $id, imageUrl: $imageUrl, name: $name, identity: $identity, identityCreateDate: $identityCreateDate, identityAddress: $identityAddress, phoneNumber: $phoneNumber, bankName: $bankName, bankNumber: $bankNumber, address: $address, additionalInfo: $additionalInfo, identityImageFrontUrl: $identityImageFrontUrl, identityImageBackUrl: $identityImageBackUrl, nickName: $nickName}';
  }
}
