// import 'package:json_annotation/json_annotation.dart';

// part 'wallet_model.g.dart';

// @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
// class WalletModel {
//   final int? walletId;
//   final int userId;
//   final int? shopId;
//   final int balance;
//   final int isPinChanged;
//   final int failedAttempts;
//   final String? lockedUntil;
//   final String createdAt;
//   final String updatedAt;

//   WalletModel({
//     this.walletId,
//     required this.userId,
//     this.shopId,
//     required this.balance,
//     required this.isPinChanged,
//     required this.failedAttempts,
//     this.lockedUntil,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory WalletModel.fromJson(Map<String, dynamic> json) =>
//       _$WalletModelFromJson(json);

//   Map<String, dynamic> toJson() => _$WalletModelToJson(this);
// }

import 'package:json_annotation/json_annotation.dart';

part 'wallet_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class WalletModel {
  final int? walletId;
  final int userId;
  final int? shopId;

  // Add @JsonKey with explicit key reading or readValue logic
  @JsonKey(readValue: _readBalance)
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

  /// Helper method to safely extract balance regardless of key name or type
  static Object? _readBalance(Map json, String key) {
    final val = json['balance'] ?? json['amount'] ?? json['points'] ?? json['wallet_balance'];
    if (val is String) {
      return int.tryParse(val) ?? 0;
    } else if (val is num) {
      return val.toInt();
    }
    return val;
  }

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletModelToJson(this);
}