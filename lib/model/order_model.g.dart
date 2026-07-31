// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  orderId: (json['order_id'] as num).toInt(),
  shopName: json['shop_name'] as String,
  userRole: json['user_role'] as String,
  customerName: json['customer_name'] as String? ?? '',
  customerPhone: json['customer_phone'] as String? ?? '',
  orderTime: json['order_time'] as String,
  status: json['status'] as String,
  orderType: json['order_type'] as String,
  totalPoints: (json['total_points'] as num).toInt(),
  tableNumber: json['table_number'] as String?,
  deliveryLocation: json['delivery_location'] as String?,
  qrCodeToken: json['qr_code_token'] as String,
  expiresAt: json['expires_at'] as String?,
  canPickup: json['can_pickup'] as bool,
  items: (json['items'] as List<dynamic>)
      .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'shop_name': instance.shopName,
      'user_role': instance.userRole,
      'customer_name': instance.customerName,
      'customer_phone': instance.customerPhone,
      'order_time': instance.orderTime,
      'status': instance.status,
      'order_type': instance.orderType,
      'total_points': instance.totalPoints,
      'table_number': instance.tableNumber,
      'delivery_location': instance.deliveryLocation,
      'qr_code_token': instance.qrCodeToken,
      'expires_at': instance.expiresAt,
      'can_pickup': instance.canPickup,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      srNo: (json['sr_no'] as num).toInt(),
      itemId: (json['item_id'] as num).toInt(),
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: (json['unit_price'] as num).toInt(),
      totalPrice: (json['total_price'] as num).toInt(),
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'sr_no': instance.srNo,
      'item_id': instance.itemId,
      'name': instance.name,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'total_price': instance.totalPrice,
    };
