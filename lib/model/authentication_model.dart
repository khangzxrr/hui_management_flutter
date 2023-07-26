import 'user_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'authentication_model.g.dart';

@JsonSerializable()
class AuthenticationModel {
  final String token;
  final UserModel user;

  AuthenticationModel({required this.token, required this.user});

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) => _$AuthenticationModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationModelToJson(this);

  @override
  String toString() {
    return '$token ${user.toString()}';
  }
}
