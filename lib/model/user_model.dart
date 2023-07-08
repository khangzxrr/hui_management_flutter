import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  final int id;
  final String name;
  final String email;
  final String password;
  final String phonenumber;
  final String bankname;
  final String banknumber;
  final String address;
  final String additionalInfo;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phonenumber,
    required this.bankname,
    required this.banknumber,
    required this.address,
    required this.additionalInfo,
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
