import 'package:hive/hive.dart';
import 'package:hui_management/helper/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 2)
class UserModel {
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

  @HiveField(6)
  final String password;

  @HiveField(7)
  final String phonenumber;

  @HiveField(8)
  final String bankname;

  @HiveField(9)
  final String banknumber;

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

  UserModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.identity,
    required this.identityCreateDate,
    required this.identityAddress,
    required this.password,
    required this.phonenumber,
    required this.bankname,
    required this.banknumber,
    required this.address,
    required this.additionalInfo,
    required this.identityImageFrontUrl,
    required this.identityImageBackUrl,
    required this.nickName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //     id: json['id'],
  //     name: json['name'],
  //     email: json['email'],
  //     password: json['password'],
  //     phonenumber: json['phonenumber'],
  //     bankname: json['bankname'],
  //     banknumber: json['banknumber'],
  //     address: json['address'],
  //     additionalInfo: json['additionalInfo'],
  //   );
  // }
}
