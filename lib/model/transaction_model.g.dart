// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      transactionId: (json['transaction_id'] as num).toInt(),
      fromWalletId: (json['from_wallet_id'] as num?)?.toInt(),
      toWalletId: (json['to_wallet_id'] as num?)?.toInt(),
      orderId: (json['order_id'] as num?)?.toInt(),
      amount: (json['amount'] as num).toInt(),
      displayAmount: json['display_amount'] as String?,
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
      'to_wallet_id': instance.toWalletId,
      'order_id': instance.orderId,
      'amount': instance.amount,
      'display_amount': instance.displayAmount,
      'remark': instance.remark,
      'transaction_type': instance.transactionType,
      'display_type': instance.displayType,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
