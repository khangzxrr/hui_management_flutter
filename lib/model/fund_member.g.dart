// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundMember _$FundMemberFromJson(Map<String, dynamic> json) => FundMember(
      id: json['id'] as int,
      nickName: json['nickName'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FundMemberToJson(FundMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickName': instance.nickName,
      'user': instance.user,
    };
