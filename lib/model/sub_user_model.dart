import 'package:json_annotation/json_annotation.dart';

part 'sub_user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SubUserModel {
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

  SubUserModel({
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
  });

  factory SubUserModel.fromJson(Map<String, dynamic> json) => _$SubUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubUserModelToJson(this);

  //toString
  @override
  String toString() {
    return 'UserModel{id: $id, imageUrl: $imageUrl, name: $name, identity: $identity, identityCreateDate: $identityCreateDate, identityAddress: $identityAddress, phoneNumber: $phoneNumber, bankName: $bankName, bankNumber: $bankNumber, address: $address, additionalInfo: $additionalInfo, identityImageFrontUrl: $identityImageFrontUrl, identityImageBackUrl: $identityImageBackUrl, nickName: $nickName}';
  }
}
