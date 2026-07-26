import 'package:json_annotation/json_annotation.dart';

part 'menu_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MenuModel {
  final int menuId;
  final int shopId;
  final int categoryId;
  final String itemName;
  final String itemImage;
  final String description;
  final int itemPrice;
  final int quantity;
  final int isAvailable;
  final String createdAt;
  final String updatedAt;
  final String imageUrl;

  MenuModel({
    required this.menuId,
    required this.shopId,
    required this.categoryId,
    required this.itemName,
    required this.itemImage,
    required this.description,
    required this.itemPrice,
    required this.quantity,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) =>
      _$MenuModelFromJson(json);

  Map<String, dynamic> toJson() => _$MenuModelToJson(this);
}