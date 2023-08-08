import 'package:hui_management/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_with_payment_report.g.dart';

@JsonSerializable()
class UserWithPaymentReport extends UserModel {
  final double totalCost;
  final double totalTransactionCost;

  UserWithPaymentReport({
    required this.totalCost,
    required this.totalTransactionCost,
    required int id,
    required String imageUrl,
    required String name,
    required String identity,
    required DateTime identityCreateDate,
    required String identityAddress,
    required String password,
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
          password: password,
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
}
