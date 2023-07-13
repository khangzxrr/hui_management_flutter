import 'package:hui_management/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fund_member.g.dart';

@JsonSerializable()
class FundMember {
  int id;
  String nickName;

  UserModel user;

  FundMember({required this.id, required this.nickName, required this.user});

  factory FundMember.fromJson(Map<String, dynamic> json) => _$FundMemberFromJson(json);
  Map<String, dynamic> toJson() => _$FundMemberToJson(this);
}
