import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub_user_model.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 2)
class SubUserModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String imageUrl;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String identity;

  @HiveField(4)
  final DateTime identityCreateDate;

  @HiveField(5)
  final String identityAddress;

  @HiveField(7)
  final String phoneNumber;

  @HiveField(8)
  final String bankName;

  @HiveField(9)
  final String bankNumber;

  @HiveField(10)
  final String address;

  @HiveField(11)
  final String additionalInfo;

  @HiveField(12)
  final String? identityImageFrontUrl;

  @HiveField(13)
  final String? identityImageBackUrl;

  @HiveField(14)
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
