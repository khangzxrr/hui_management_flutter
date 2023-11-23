import 'package:json_annotation/json_annotation.dart';

part 'custom_bill_model.g.dart';

enum CustomBillType {
  @JsonValue('OwnerTake')
  ownerTake,
  @JsonValue('OwnerPaid')
  ownerPaid,
}

@JsonSerializable()
class CustomBill {
  int id;
  String description;
  double payCost;
  CustomBillType type;

  CustomBill({
    required this.id,
    required this.description,
    required this.payCost,
    required this.type,
  });

  factory CustomBill.fromJson(Map<String, dynamic> json) => _$CustomBillFromJson(json);
  Map<String, dynamic> toJson() => _$CustomBillToJson(this);
}
