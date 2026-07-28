// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuModel _$MenuModelFromJson(Map<String, dynamic> json) => MenuModel(
  menuId: (json['menu_id'] as num).toInt(),
  shopId: (json['shop_id'] as num).toInt(),
  categoryId: (json['category_id'] as num).toInt(),
  itemName: json['item_name'] as String? ?? 'Unknown Item',
  itemImage: json['item_image'] as String? ?? '',
  description: json['description'] as String? ?? '',
  itemPrice: (json['item_price'] as num).toInt(),
  quantity: (json['quantity'] as num?)?.toInt() ?? 0,
  isAvailable: (json['is_available'] as num?)?.toInt() ?? 1,
  createdAt: json['created_at'] as String? ?? '',
  updatedAt: json['updated_at'] as String? ?? '',
  imageUrl: json['image_url'] as String? ?? '',
);

Map<String, dynamic> _$MenuModelToJson(MenuModel instance) => <String, dynamic>{
  'menu_id': instance.menuId,
  'shop_id': instance.shopId,
  'category_id': instance.categoryId,
  'item_name': instance.itemName,
  'item_image': instance.itemImage,
  'description': instance.description,
  'item_price': instance.itemPrice,
  'quantity': instance.quantity,
  'is_available': instance.isAvailable,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'image_url': instance.imageUrl,
};
