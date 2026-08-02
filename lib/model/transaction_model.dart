// // // // import 'package:json_annotation/json_annotation.dart';

// // // // part 'transaction_model.g.dart';

// // // // // သင်၏ UI အသုံးပြုပုံပေါ်မူတည်၍ Enum ကို လိုသလို အသုံးပြုနိုင်သည်
// // // // enum TransactionType {
// // // //   @JsonValue('TRANSFER')
// // // //   transfer,
// // // //   @JsonValue('top-up')
// // // //   topUp,
// // // //   @JsonValue('order_payment')
// // // //   orderPayment,
// // // //   received,
// // // //   spent,
// // // // }

// // // // @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
// // // // class TransactionModel {
// // // //   final int transactionId;
// // // //   final int? fromWalletId;
// // // //   final int? toWalletId;
// // // //   final int? orderId;
// // // //   final int amount;
// // // //   final String? remark;
// // // //   final String transactionType;
// // // //   final String status;
// // // //   final String createdAt;
// // // //   final String updatedAt;

// // // //   TransactionModel({
// // // //     required this.transactionId,
// // // //     this.fromWalletId,
// // // //     this.toWalletId,
// // // //     this.orderId,
// // // //     required this.amount,
// // // //     this.remark,
// // // //     required this.transactionType,
// // // //     required this.status,
// // // //     required this.createdAt,
// // // //     required this.updatedAt,
// // // //   });

// // // //   // UI တွင် အသုံးပြုရန် Helper Getters များ
// // // //   TransactionType get type {
// // // //     if (transactionType == 'top-up' || toWalletId != null && transactionType == 'TRANSFER') {
// // // //       return TransactionType.received;
// // // //     }
// // // //     return TransactionType.spent;
// // // //   }

// // // //   String get title {
// // // //     switch (transactionType) {
// // // //       case 'top-up':
// // // //         return "ပွိုင့်ဖြည့်သွင်းခြင်း";
// // // //       case 'TRANSFER':
// // // //         return "ပွိုင့်လွှဲပြောင်းခြင်း";
// // // //       case 'order_payment':
// // // //         return "အော်ဒါငွေပေးချေမှု";
// // // //       default:
// // // //         return "ငွေလွှဲမှတ်တမ်း";
// // // //     }
// // // //   }

// // // //   String get subtitle {
// // // //     if (transactionType == 'TRANSFER') {
// // // //       return fromWalletId != null ? "Wallet ID: $fromWalletId မှ" : "";
// // // //     }
// // // //     return "";
// // // //   }

// // // //   String get time => createdAt;

// // // //   factory TransactionModel.fromJson(Map<String, dynamic> json) =>
// // // //       _$TransactionModelFromJson(json);

// // // //   Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
// // // // }

// // // import 'package:json_annotation/json_annotation.dart';

// // // part 'transaction_model.g.dart';

// // // // UI တွင် အသုံးပြုရန် Enum
// // // enum TransactionType {
// // //   @JsonValue('TRANSFER')
// // //   transfer,
// // //   @JsonValue('top-up')
// // //   topUp,
// // //   @JsonValue('order_payment')
// // //   orderPayment,
// // //   received,
// // //   spent
// // // }

// // // @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
// // // class TransactionModel {
// // //   final int transactionId;
// // //   final int? fromWalletId;
// // //   final int? toWalletId;
// // //   final int? orderId;
// // //   final int amount;
// // //   final String? displayAmount; // API response ပါသည့်အတိုင်း ထည့်ရန်
// // //   final String? remark;
// // //   final String transactionType;
// // //   final String? displayType;   // API response ပါသည့်အတိုင်း ထည့်ရန်
// // //   final String status;
// // //   final String createdAt;
// // //   final String? updatedAt;     // API response တွင် မပါနိုင်သဖြင့် nullable ပြုလုပ်ထားသည်

// // //   TransactionModel({
// // //     required this.transactionId,
// // //     this.fromWalletId,
// // //     this.toWalletId,
// // //     this.orderId,
// // //     required this.amount,
// // //     this.displayAmount,
// // //     this.remark,
// // //     required this.transactionType,
// // //     this.displayType,
// // //     required this.status,
// // //     required this.createdAt,
// // //     this.updatedAt,
// // //   });

// // //   // UI တွင် အသုံးပြုရန် Helper Getters များ
// // //   TransactionType get type {
// // //     if (transactionType == 'top-up' || (toWalletId != null && transactionType == 'TRANSFER')) {
// // //       return TransactionType.received;
// // //     }
// // //      return TransactionType.spent;
// // //   }

// // //   String get title {
// // //     // API မှ display_type ပါလာပါက ၎င်းကို ဦးစားပေးသုံးနိုင်သည်
// // //     if (displayType != null && displayType!.isNotEmpty) {
// // //       return displayType!;
// // //     }
// // //     switch (transactionType) {
// // //       case 'top-up':
// // //         return "ငွေဖြည့်ခြင်း";
// // //       case 'TRANSFER':
// // //         return "ပွိုင့်လွှဲပြောင်းခြင်း";
// // //       case 'order_payment':
// // //         return "ပစ္စည်းဖိုး ပေးချေခြင်း";
// // //       default:
// // //         return "ငွေလွှဲမှတ်တမ်း";
// // //     }
// // //   }

// // //   String get subtitle {
// // //     if (transactionType == 'TRANSFER') {
// // //       return fromWalletId != null ? "Wallet ID: $fromWalletId မှ" : "";
// // //     }
// // //     return "";
// // //   }

// // //   String get time => createdAt;

// // //   factory TransactionModel.fromJson(Map<String, dynamic> json) =>
// // //       _$TransactionModelFromJson(json);

// // //   Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
// // // }

// // import 'package:json_annotation/json_annotation.dart';

// // part 'transaction_model.g.dart';

// // @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
// // class TransactionModel {
// //   final int transactionId;
// //   final int? fromWalletId;
  
// //   @JsonKey(name: 'from_user_name')
// //   final String? fromUserName;

// //   final int? toWalletId;

// //   @JsonKey(name: 'to_user_name')
// //   final String? toUserName;

// //   final int? orderId;
// //   final int amount;

// //   @JsonKey(name: 'display_amount')
// //   final String? displayAmount;

// //   final String? direction;
// //   final String? remark;
// //   final String transactionType;

// //   @JsonKey(name: 'display_type')
// //   final String? displayType;

// //   final String status;
// //   final String createdAt;
// //   final String? updatedAt;

// //   TransactionModel({
// //     required this.transactionId,
// //     this.fromWalletId,
// //     this.fromUserName,
// //     this.toWalletId,
// //     this.toUserName,
// //     this.orderId,
// //     required this.amount,
// //     this.displayAmount,
// //     this.direction,
// //     this.remark,
// //     required this.transactionType,
// //     this.displayType,
// //     required this.status,
// //     required this.createdAt,
// //     this.updatedAt,
// //   });

// //   factory TransactionModel.fromJson(Map<String, dynamic> json) =>
// //       _$TransactionModelFromJson(json);

// //   Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
// // }

// import 'package:json_annotation/json_annotation.dart';

// part 'transaction_model.g.dart';

// // Enum for UI status checking
// enum TransactionType {
//   transfer,
//   topUp,
//   orderPayment,
//   received,
//   spent,
// }

// @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
// class TransactionModel {
//   final int transactionId;
//   final int? fromWalletId;

//   @JsonKey(name: 'from_user_name')
//   final String? fromUserName;

//   final int? toWalletId;

//   @JsonKey(name: 'to_user_name')
//   final String? toUserName;

//   final int? orderId;
//   final int amount;

//   @JsonKey(name: 'display_amount')
//   final String? displayAmount;

//   final String? direction;
//   final String? remark;
//   final String transactionType;

//   @JsonKey(name: 'display_type')
//   final String? displayType;

//   final String status;
//   final String createdAt;
//   final String? updatedAt;

//   TransactionModel({
//     required this.transactionId,
//     this.fromWalletId,
//     this.fromUserName,
//     this.toWalletId,
//     this.toUserName,
//     this.orderId,
//     required this.amount,
//     this.displayAmount,
//     this.direction,
//     this.remark,
//     required this.transactionType,
//     this.displayType,
//     required this.status,
//     required this.createdAt,
//     this.updatedAt,
//   });

//   // ==================== HELPER GETTERS FOR UI ====================

//   /// Checks if the transaction is an incoming payment (received) or outgoing payment (spent)
//   TransactionType get type {
//     if (direction == 'inflow' ||
//         transactionType == 'top-up' ||
//         (toWalletId != null && transactionType == 'TRANSFER')) {
//       return TransactionType.received;
//     }
//     return TransactionType.spent;
//   }

//   /// Title for transaction items in lists and detail screens
//   String get title {
//     if (displayType != null && displayType!.isNotEmpty) {
//       return displayType!;
//     }
//     switch (transactionType) {
//       case 'top-up':
//         return "ငွေဖြည့်ခြင်း";
//       case 'TRANSFER':
//         return "ပွိုင့်လွှဲပြောင်းခြင်း";
//       case 'order_payment':
//         return "ပစ္စည်းဖိုး ပေးချေခြင်း";
//       default:
//         return "ငွေလွှဲမှတ်တမ်း";
//     }
//   }

//   /// Subtitle showing user names or wallet info
//   String get subtitle {
//     if (type == TransactionType.received) {
//       if (fromUserName != null && fromUserName!.isNotEmpty) {
//         return "From: $fromUserName";
//       } else if (fromWalletId != null) {
//         return "Wallet ID: $fromWalletId မှ";
//       }
//     } else {
//       if (toUserName != null && toUserName!.isNotEmpty) {
//         return "To: $toUserName";
//       } else if (toWalletId != null) {
//         return "Wallet ID: $toWalletId သို့";
//       }
//     }
//     return "";
//   }

//   /// Time getter mapping createdAt field
//   String get time => createdAt;

//   // ===============================================================

//   factory TransactionModel.fromJson(Map<String, dynamic> json) =>
//       _$TransactionModelFromJson(json);

//   Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
// }
import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

enum TransactionType {
  transfer,
  topUp,
  received,
  spent, TRANSFER, order_payment,
}

@JsonSerializable(explicitToJson: true)
class TransactionModel {
  @JsonKey(name: 'transaction_id')
  final int transactionId;

  @JsonKey(name: 'from_wallet_id')
  final int? fromWalletId;

  @JsonKey(name: 'from_user_name')
  final String? fromUserName;

  @JsonKey(name: 'to_wallet_id')
  final int? toWalletId;

  @JsonKey(name: 'to_user_name')
  final String? toUserName;

  @JsonKey(name: 'order_id')
  final int? orderId;

  final dynamic amount; // Using dynamic or num avoids int/double type mismatch

  @JsonKey(name: 'display_amount')
  final String? displayAmount;

  final String? direction;
  final String? remark;

  @JsonKey(name: 'transaction_type')
  final String transactionType;

  @JsonKey(name: 'display_type')
  final String? displayType;

  final String status;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  TransactionModel({
    required this.transactionId,
    this.fromWalletId,
    this.fromUserName,
    this.toWalletId,
    this.toUserName,
    this.orderId,
    required this.amount,
    this.displayAmount,
    this.direction,
    this.remark,
    required this.transactionType,
    this.displayType,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  // Dynamic status/direction checks
  TransactionType get type {
    if (direction == 'inflow' ||
        transactionType == 'top-up' ||
        (toWalletId != null && transactionType == 'TRANSFER')) {
      return TransactionType.received;
    }
    return TransactionType.spent;
  }

  String get title => displayType ?? "ငွေလွှဲမှတ်တမ်း";

  String get subtitle {
    if (direction == 'inflow') {
      return fromUserName != null ? "From: $fromUserName" : "";
    } else {
      return toUserName != null ? "To: $toUserName" : "";
    }
  }

  String get time => createdAt;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}