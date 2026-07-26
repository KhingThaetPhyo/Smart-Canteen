import 'package:json_annotation/json_annotation.dart';

part 'wallet_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class WalletModel {
  final int? walletId;
  final int userId;
  final int? shopId;
  final int balance;
  final int isPinChanged;
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