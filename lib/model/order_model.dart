import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class OrderModel {
  final int orderId;
  final String shopName;
  final String userRole;
  
  @JsonKey(defaultValue: '')
  final String customerName;
  
  @JsonKey(defaultValue: '')
  final String customerPhone;
  
  final String orderTime;
  final String status;
  final String orderType;
  final int totalPoints;
  final String? tableNumber;
  
  @JsonKey(defaultValue: null)
  final String? deliveryLocation;
  
  final String qrCodeToken;
  final String? expiresAt;
  final bool canPickup;
  final List<OrderItemModel> items;

  OrderModel({
    required this.orderId,
    required this.shopName,
    required this.userRole,
    required this.customerName,
    required this.customerPhone,
    required this.orderTime,
    required this.status,
    required this.orderType,
    required this.totalPoints,
    required this.tableNumber,
    this.deliveryLocation,
    required this.qrCodeToken,
    required this.expiresAt,
    required this.canPickup,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class OrderItemModel {
  final int srNo;
  final int itemId;
  final String name;
  final int quantity;
  final int unitPrice;
  final int totalPrice;

  OrderItemModel({
    required this.srNo,
    required this.itemId,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}