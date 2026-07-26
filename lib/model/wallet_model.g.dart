// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletModel _$WalletModelFromJson(Map<String, dynamic> json) => WalletModel(
  walletId: (json['wallet_id'] as num?)?.toInt(),
  userId: (json['user_id'] as num).toInt(),
  shopId: (json['shop_id'] as num?)?.toInt(),
  balance: (json['balance'] as num).toInt(),
  isPinChanged: (json['is_pin_changed'] as num).toInt(),
  failedAttempts: (json['failed_attempts'] as num).toInt(),
  lockedUntil: json['locked_until'] as String?,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$WalletModelToJson(WalletModel instance) =>
    <String, dynamic>{
      'wallet_id': instance.walletId,
      'user_id': instance.userId,
      'shop_id': instance.shopId,
      'balance': instance.balance,
      'is_pin_changed': instance.isPinChanged,
      'failed_attempts': instance.failedAttempts,
      'locked_until': instance.lockedUntil,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
