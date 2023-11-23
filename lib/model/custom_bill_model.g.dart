// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomBill _$CustomBillFromJson(Map<String, dynamic> json) => CustomBill(
      id: json['id'] as int,
      description: json['description'] as String,
      payCost: (json['payCost'] as num).toDouble(),
      type: $enumDecode(_$CustomBillTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$CustomBillToJson(CustomBill instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'payCost': instance.payCost,
      'type': _$CustomBillTypeEnumMap[instance.type]!,
    };

const _$CustomBillTypeEnumMap = {
  CustomBillType.ownerTake: 'OwnerTake',
  CustomBillType.ownerPaid: 'OwnerPaid',
};
