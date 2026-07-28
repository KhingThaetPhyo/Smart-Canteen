// import 'package:json_annotation/json_annotation.dart';
// import 'menu_model.dart'; // Import your menu_model.dart

// part 'shop_model.g.dart';

// @JsonSerializable(fieldRename: FieldRename.snake)
// class ShopModel {
//   final int shopId;
//   final int userId;
//   final String shopName;
//   final String shopPhone;
//   final int isOpen;
//   final String? fcmToken;
//   final String createdAt;
//   final String updatedAt;
//   final List<MenuModel>? menus;

//   ShopModel({
//     required this.shopId,
//     required this.userId,
//     required this.shopName,
//     required this.shopPhone,
//     required this.isOpen,
//     this.fcmToken,
//     required this.createdAt,
//     required this.updatedAt,
//     this.menus,
//   });

//   factory ShopModel.fromJson(Map<String, dynamic> json) =>
//       _$ShopModelFromJson(json);

//   Map<String, dynamic> toJson() => _$ShopModelToJson(this);
// }
import 'package:json_annotation/json_annotation.dart';
import 'menu_model.dart';

part 'shop_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ShopModel {
  final int shopId;
  final int userId;

  @JsonKey(defaultValue: '')
  final String shopName;

  @JsonKey(defaultValue: '')
  final String shopPhone;

  final int isOpen;
  final String? fcmToken;

  @JsonKey(defaultValue: '')
  final String createdAt;

  @JsonKey(defaultValue: '')
  final String updatedAt;

  final List<MenuModel>? menus;

  ShopModel({
    required this.shopId,
    required this.userId,
    required this.shopName,
    required this.shopPhone,
    required this.isOpen,
    this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
    this.menus,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      _$ShopModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopModelToJson(this);
}