
import 'package:json_annotation/json_annotation.dart';

import 'shop_model.dart';

part 'view_menu_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ViewMenuModel {
  final bool success;
  final String message;
  final int totalShops;
  final List<ShopModel> data;

  ViewMenuModel({
    required this.success,
    required this.message,
    required this.totalShops,
    required this.data,
  });

  factory ViewMenuModel.fromJson(Map<String, dynamic> json) =>
      _$ViewMenuModelFromJson(json);

  Map<String, dynamic> toJson() => _$ViewMenuModelToJson(this);
}