// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      transactionId: (json['transaction_id'] as num).toInt(),
      fromWalletId: (json['from_wallet_id'] as num?)?.toInt(),
      fromUserName: json['from_user_name'] as String?,
      toWalletId: (json['to_wallet_id'] as num?)?.toInt(),
      toUserName: json['to_user_name'] as String?,
      orderId: (json['order_id'] as num?)?.toInt(),
      amount: json['amount'],
      displayAmount: json['display_amount'] as String?,
      direction: json['direction'] as String?,
      remark: json['remark'] as String?,
      transactionType: json['transaction_type'] as String,
      displayType: json['display_type'] as String?,
      status: json['status'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'transaction_id': instance.transactionId,
      'from_wallet_id': instance.fromWalletId,
      'from_user_name': instance.fromUserName,
      'to_wallet_id': instance.toWalletId,
      'to_user_name': instance.toUserName,
      'order_id': instance.orderId,
      'amount': instance.amount,
      'display_amount': instance.displayAmount,
      'direction': instance.direction,
      'remark': instance.remark,
      'transaction_type': instance.transactionType,
      'display_type': instance.displayType,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
