
import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'wallet_model.g.dart';
bool _intToBool(dynamic value) {
  return value == 1 || value == true;
}

int _boolToInt(bool value) {
  return value ? 1 : 0;
}
@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class WalletModel {
  final int? walletId;
  final int userId;
  final int? shopId;
  final int balance;
  // final bool isPinChanged;
  @JsonKey(
  fromJson: _intToBool,
  toJson: _boolToInt,
)
final bool isPinChanged;
  final int failedAttempts;
  final String? lockedUntil;
  final String createdAt;
  final String updatedAt;

  WalletModel({
     this.walletId,
    required this.userId,
     this.shopId,
    required this.balance,
  required this.isPinChanged,
  required this.failedAttempts,
   this.lockedUntil,
  required this.createdAt,
  required this.updatedAt,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletModelToJson(this);
}
