// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViewMenuModel _$ViewMenuModelFromJson(Map<String, dynamic> json) =>
    ViewMenuModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      totalShops: (json['total_shops'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => ShopModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ViewMenuModelToJson(ViewMenuModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'total_shops': instance.totalShops,
      'data': instance.data,
    };
