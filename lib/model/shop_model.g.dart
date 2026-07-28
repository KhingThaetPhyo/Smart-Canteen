// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopModel _$ShopModelFromJson(Map<String, dynamic> json) => ShopModel(
  shopId: (json['shop_id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  shopName: json['shop_name'] as String? ?? '',
  shopPhone: json['shop_phone'] as String? ?? '',
  isOpen: (json['is_open'] as num).toInt(),
  fcmToken: json['fcm_token'] as String?,
  createdAt: json['created_at'] as String? ?? '',
  updatedAt: json['updated_at'] as String? ?? '',
  menus: (json['menus'] as List<dynamic>?)
      ?.map((e) => MenuModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ShopModelToJson(ShopModel instance) => <String, dynamic>{
  'shop_id': instance.shopId,
  'user_id': instance.userId,
  'shop_name': instance.shopName,
  'shop_phone': instance.shopPhone,
  'is_open': instance.isOpen,
  'fcm_token': instance.fcmToken,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'menus': instance.menus,
};
