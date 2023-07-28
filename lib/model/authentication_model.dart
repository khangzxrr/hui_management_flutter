import 'package:hive/hive.dart';

import 'user_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'authentication_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class AuthenticationModel {
  @HiveField(0)
  final String token;

  @HiveField(1)
  final UserModel user;

  AuthenticationModel({required this.token, required this.user});

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) => _$AuthenticationModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationModelToJson(this);

  @override
  String toString() {
    return '$token ${user.toString()}';
  }
}
