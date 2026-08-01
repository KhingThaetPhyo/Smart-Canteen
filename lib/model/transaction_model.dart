// import 'package:json_annotation/json_annotation.dart';

// part 'transaction_model.g.dart';

// // သင်၏ UI အသုံးပြုပုံပေါ်မူတည်၍ Enum ကို လိုသလို အသုံးပြုနိုင်သည်
// enum TransactionType {
//   @JsonValue('TRANSFER')
//   transfer,
//   @JsonValue('top-up')
//   topUp,
//   @JsonValue('order_payment')
//   orderPayment,
//   received,
//   spent,
// }

// @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
// class TransactionModel {
//   final int transactionId;
//   final int? fromWalletId;
//   final int? toWalletId;
//   final int? orderId;
//   final int amount;
//   final String? remark;
//   final String transactionType;
//   final String status;
//   final String createdAt;
//   final String updatedAt;

//   TransactionModel({
//     required this.transactionId,
//     this.fromWalletId,
//     this.toWalletId,
//     this.orderId,
//     required this.amount,
//     this.remark,
//     required this.transactionType,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   // UI တွင် အသုံးပြုရန် Helper Getters များ
//   TransactionType get type {
//     if (transactionType == 'top-up' || toWalletId != null && transactionType == 'TRANSFER') {
//       return TransactionType.received;
//     }
//     return TransactionType.spent;
//   }

//   String get title {
//     switch (transactionType) {
//       case 'top-up':
//         return "ပွိုင့်ဖြည့်သွင်းခြင်း";
//       case 'TRANSFER':
//         return "ပွိုင့်လွှဲပြောင်းခြင်း";
//       case 'order_payment':
//         return "အော်ဒါငွေပေးချေမှု";
//       default:
//         return "ငွေလွှဲမှတ်တမ်း";
//     }
//   }

//   String get subtitle {
//     if (transactionType == 'TRANSFER') {
//       return fromWalletId != null ? "Wallet ID: $fromWalletId မှ" : "";
//     }
//     return "";
//   }

//   String get time => createdAt;

//   factory TransactionModel.fromJson(Map<String, dynamic> json) =>
//       _$TransactionModelFromJson(json);

//   Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
// }

import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

// UI တွင် အသုံးပြုရန် Enum
enum TransactionType {
  @JsonValue('TRANSFER')
  transfer,
  @JsonValue('top-up')
  topUp,
  @JsonValue('order_payment')
  orderPayment,
  received,
  spent
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TransactionModel {
  final int transactionId;
  final int? fromWalletId;
  final int? toWalletId;
  final int? orderId;
  final int amount;
  final String? displayAmount; // API response ပါသည့်အတိုင်း ထည့်ရန်
  final String? remark;
  final String transactionType;
  final String? displayType;   // API response ပါသည့်အတိုင်း ထည့်ရန်
  final String status;
  final String createdAt;
  final String? updatedAt;     // API response တွင် မပါနိုင်သဖြင့် nullable ပြုလုပ်ထားသည်

  TransactionModel({
    required this.transactionId,
    this.fromWalletId,
    this.toWalletId,
    this.orderId,
    required this.amount,
    this.displayAmount,
    this.remark,
    required this.transactionType,
    this.displayType,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  // UI တွင် အသုံးပြုရန် Helper Getters များ
  TransactionType get type {
    if (transactionType == 'top-up' || (toWalletId != null && transactionType == 'TRANSFER')) {
      return TransactionType.received;
    }
     return TransactionType.spent;
  }

  String get title {
    // API မှ display_type ပါလာပါက ၎င်းကို ဦးစားပေးသုံးနိုင်သည်
    if (displayType != null && displayType!.isNotEmpty) {
      return displayType!;
    }
    switch (transactionType) {
      case 'top-up':
        return "ငွေဖြည့်ခြင်း";
      case 'TRANSFER':
        return "ပွိုင့်လွှဲပြောင်းခြင်း";
      case 'order_payment':
        return "ပစ္စည်းဖိုး ပေးချေခြင်း";
      default:
        return "ငွေလွှဲမှတ်တမ်း";
    }
  }

  String get subtitle {
    if (transactionType == 'TRANSFER') {
      return fromWalletId != null ? "Wallet ID: $fromWalletId မှ" : "";
    }
    return "";
  }

  String get time => createdAt;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}