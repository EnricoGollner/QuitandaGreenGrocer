import 'package:json_annotation/json_annotation.dart';

import 'package:quitanda_app/src/models/cart_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  String id;

  @JsonKey(name: 'createdAt')
  DateTime? createdDateTime;

  @JsonKey(name: 'due')
  DateTime overdueDateTime;

  @JsonKey(defaultValue: [])
  List<CartItemModel> items;
  String status;
  
  String qrCodeImage;

  @JsonKey(name: 'copiaecola')
  String copyAndPaste;
  double total;

  bool get isOverdue => overdueDateTime.isBefore(DateTime.now());

  OrderModel({
    required this.id,
    this.createdDateTime,
    required this.overdueDateTime,
    required this.items,
    required this.status,
    required this.qrCodeImage,
    required this.copyAndPaste,
    required this.total,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
