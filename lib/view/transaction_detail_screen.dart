// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:go_router/go_router.dart';
// // // // // // import 'package:smartcanteen/model/transaction_model.dart';

// // // // // // class TransactionDetailScreen extends StatelessWidget {
// // // // // //   final TransactionModel transaction;
// // // // // //   final String
// // // // // //   phoneNumber; // ဖုန်းနံပါတ် ထည့်သွင်းရန် parameter (Optional)[cite: 2]

// // // // // //   const TransactionDetailScreen({
// // // // // //     super.key,
// // // // // //     required this.transaction,
// // // // // //     this.phoneNumber = "09971238377", // Default Test Phone Number[cite: 2]
// // // // // //   });

// // // // // //   // Main Teal Theme Color[cite: 2]
// // // // // //   static const Color primaryTeal = Color(0xff117992);
// // // // // //   static const Color lightTeal = Color(0xFFE0F2F1);

// // // // // //   // Kpay Style Phone Masking Helper Function[cite: 2]
// // // // // //   // ဥပမာ - 09971238377 -> (******8377)[cite: 2]
// // // // // //   String _maskPhoneNumber(String phone) {
// // // // // //     if (phone.length >= 4) {
// // // // // //       final lastFour = phone.substring(phone.length - 4);
// // // // // //       return "(******$lastFour)";
// // // // // //     }
// // // // // //     return phone;
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     final isReceived = transaction.type == TransactionType.received;
// // // // // //     final String labelTitle = isReceived ? "ပေးပို့သူ" : "ပွိုင့်လွှဲမည် သို့";
// // // // // //     final String recipientName = transaction.subtitle.isNotEmpty
// // // // // //         ? transaction.subtitle
// // // // // //         : "Myint Myat";

// // // // // //     return Scaffold(
// // // // // //       backgroundColor: const Color(0xFFF5F5F5),

// // // // // //       // 1. App Bar
// // // // // //       appBar: AppBar(
// // // // // //         title: const Text(
// // // // // //           "လုပ်ဆောင်ချက် အသေးစိတ်",
// // // // // //           style: TextStyle(
// // // // // //             color: Colors.white,
// // // // // //             fontSize: 16,
// // // // // //             fontWeight: FontWeight.bold,
// // // // // //           ),
// // // // // //         ),
// // // // // //         centerTitle: true,
// // // // // //         backgroundColor: primaryTeal,
// // // // // //         elevation: 0.5,
// // // // // //         leading: IconButton(
// // // // // //           icon: const Icon(
// // // // // //             Icons.arrow_back_ios_new,
// // // // // //             color: Colors.white,
// // // // // //             size: 20,
// // // // // //           ),
// // // // // //           onPressed: () => context.pop(),
// // // // // //         ),
// // // // // //       ),

// // // // // //       body: SingleChildScrollView(
// // // // // //         padding: const EdgeInsets.all(16.0),
// // // // // //         child: Column(
// // // // // //           children: [
// // // // // //             // 2. Detail Card
// // // // // //             Container(
// // // // // //               width: double.infinity,
// // // // // //               padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
// // // // // //               decoration: BoxDecoration(
// // // // // //                 color: Colors.white,
// // // // // //                 borderRadius: BorderRadius.circular(16),
// // // // // //                 boxShadow: [
// // // // // //                   BoxShadow(
// // // // // //                     color: Colors.black.withOpacity(0.03),
// // // // // //                     blurRadius: 10,
// // // // // //                     offset: const Offset(0, 4),
// // // // // //                   ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //               child: Column(
// // // // // //                 children: [
// // // // // //                   // Status Icon Container
// // // // // //                   Container(
// // // // // //                     padding: const EdgeInsets.all(16),
// // // // // //                     decoration: const BoxDecoration(
// // // // // //                       color: lightTeal,
// // // // // //                       shape: BoxShape.circle,
// // // // // //                     ),
// // // // // //                     child: const Icon(
// // // // // //                       Icons.check_circle_rounded,
// // // // // //                       size: 48,
// // // // // //                       color: primaryTeal,
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                   const SizedBox(height: 12),

// // // // // //                   // Transaction Status Text
// // // // // //                   const Text(
// // // // // //                     "လုပ်ဆောင်ချက် အောင်မြင်ပါသည်",
// // // // // //                     style: TextStyle(
// // // // // //                       fontSize: 14,
// // // // // //                       color: primaryTeal,
// // // // // //                       fontWeight: FontWeight.w600,
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                   const SizedBox(height: 8),

// // // // // //                   // Amount Text
// // // // // //                   Text(
// // // // // //                     transaction.amount,
// // // // // //                     style: TextStyle(
// // // // // //                       fontSize: 22,
// // // // // //                       fontWeight: FontWeight.bold,
// // // // // //                       color: isReceived ? const Color(0xff059669) : primaryTeal,
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                   const SizedBox(height: 16),

// // // // // //                   const Divider(thickness: 1, height: 24, color: lightTeal),

// // // // // //                   // 1. လုပ်ဆောင်သောအချိန် (Kpay Date Format ဖြင့် ပေါ်မည်)[cite: 2]
// // // // // //                   _buildDetailRow("လုပ်ဆောင်သောအချိန်", transaction.time),

// // // // // //                   // 2. လုပ်ဆောင်မှုအမျိုးအစား[cite: 2]
// // // // // //                   _buildDetailRow(
// // // // // //                     "လုပ်ဆောင်မှုအမျိုးအစား",
// // // // // //                     isReceived ? "ပွိုင့်လက်ခံ" : "ပွိုင့်လွှဲ",
// // // // // //                   ),

// // // // // //                   // 3. ပွိုင့်လွှဲမည် သို့ / ပေးပို့သူ (Kpay Style နာမည် + ဖုန်းနံပါတ်)[cite: 2]
// // // // // //                   _buildUserDetailRow(
// // // // // //                     labelTitle,
// // // // // //                     recipientName,
// // // // // //                     _maskPhoneNumber(phoneNumber),
// // // // // //                   ),

// // // // // //                   // 4. လုပ်ဆောင်ချက် အမှတ် (ID)[cite: 2]
// // // // // //                   _buildDetailRow("လုပ်ဆောင်ချက် အမှတ် (ID)", transaction.id),

// // // // // //                   // 5. ပွိုင့်ပမာဏ[cite: 2]
// // // // // //                   _buildDetailRow("ပွိုင့်ပမာဏ", transaction.amount),
// // // // // //                 ],
// // // // // //               ),
// // // // // //             ),
// // // // // //           ],
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   // ရိုးရိုး Detail Row[cite: 2]
// // // // // //   Widget _buildDetailRow(String label, String value) {
// // // // // //     return Padding(
// // // // // //       padding: const EdgeInsets.symmetric(vertical: 10.0),
// // // // // //       child: Row(
// // // // // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //         children: [
// // // // // //           Expanded(
// // // // // //             flex: 4,
// // // // // //             child: Text(
// // // // // //               label,
// // // // // //               style: const TextStyle(
// // // // // //                 fontSize: 13,
// // // // // //                 color: primaryTeal,
// // // // // //                 fontWeight: FontWeight.w500,
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //           Expanded(
// // // // // //             flex: 5,
// // // // // //             child: Text(
// // // // // //               value,
// // // // // //               textAlign: TextAlign.right,
// // // // // //               style: const TextStyle(
// // // // // //                 fontSize: 13,
// // // // // //                 fontWeight: FontWeight.bold,
// // // // // //                 color: primaryTeal,
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   // Kpay ပုံစံ အမည်နှင့် ဖုန်းနံပါတ် အောက်ချင်းကပ်ပြသည့် Row[cite: 2]
// // // // // //   Widget _buildUserDetailRow(String label, String name, String maskedPhone) {
// // // // // //     return Padding(
// // // // // //       padding: const EdgeInsets.symmetric(vertical: 10.0),
// // // // // //       child: Row(
// // // // // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //         children: [
// // // // // //           Expanded(
// // // // // //             flex: 4,
// // // // // //             child: Text(
// // // // // //               label,
// // // // // //               style: const TextStyle(
// // // // // //                 fontSize: 13,
// // // // // //                 color: primaryTeal,
// // // // // //                 fontWeight: FontWeight.w500,
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //           Expanded(
// // // // // //             flex: 5,
// // // // // //             child: Column(
// // // // // //               crossAxisAlignment: CrossAxisAlignment.end,
// // // // // //               children: [
// // // // // //                 Text(
// // // // // //                   name,
// // // // // //                   textAlign: TextAlign.right,
// // // // // //                   style: const TextStyle(
// // // // // //                     fontSize: 13,
// // // // // //                     fontWeight: FontWeight.bold,
// // // // // //                     color: primaryTeal,
// // // // // //                   ),
// // // // // //                 ),
// // // // // //                 const SizedBox(height: 2),
// // // // // //                 Text(
// // // // // //                   maskedPhone,
// // // // // //                   textAlign: TextAlign.right,
// // // // // //                   style: const TextStyle(
// // // // // //                     fontSize: 12,
// // // // // //                     fontWeight: FontWeight.w600,
// // // // // //                     color: primaryTeal,
// // // // // //                   ),
// // // // // //                 ),
// // // // // //               ],
// // // // // //             ),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:go_router/go_router.dart';
// // // // // import 'package:smartcanteen/model/transaction_model.dart';

// // // // // class TransactionDetailScreen extends StatelessWidget {
// // // // //   final TransactionModel transaction;
// // // // //   final String phoneNumber; // ဖုန်းနံပါတ် ထည့်သွင်းရန် parameter (Optional)[cite: 19]

// // // // //   const TransactionDetailScreen({
// // // // //     super.key,
// // // // //     required this.transaction,
// // // // //     this.phoneNumber = "09971238377", // Default Test Phone Number[cite: 19]
// // // // //   });

// // // // //   // Main Teal Theme Color[cite: 19]
// // // // //   static const Color primaryTeal = Color(0xff117992);
// // // // //   static const Color lightTeal = Color(0xFFE0F2F1);

// // // // //   // Kpay Style Phone Masking Helper Function[cite: 19]
// // // // //   String _maskPhoneNumber(String phone) {
// // // // //     if (phone.length >= 4) {
// // // // //       final lastFour = phone.substring(phone.length - 4);
// // // // //       return "(******$lastFour)";
// // // // //     }
// // // // //     return phone;
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final isReceived = transaction.type == TransactionType.received;
// // // // //     final String labelTitle = isReceived ? "ပေးပို့သူ" : "ပွိုင့်လွှဲမည် သို့";
// // // // //     final String recipientName = transaction.subtitle.isNotEmpty
// // // // //         ? transaction.subtitle
// // // // //         : "Myint Myat";

// // // // //     return Scaffold(
// // // // //       backgroundColor: const Color(0xFFF5F5F5),

// // // // //       appBar: AppBar(
// // // // //         title: const Text(
// // // // //           "လုပ်ဆောင်ချက် အသေးစိတ်",
// // // // //           style: TextStyle(
// // // // //             color: Colors.white,
// // // // //             fontSize: 16,
// // // // //             fontWeight: FontWeight.bold,
// // // // //           ),
// // // // //         ),
// // // // //         centerTitle: true,
// // // // //         backgroundColor: primaryTeal,
// // // // //         elevation: 0.5,
// // // // //         leading: IconButton(
// // // // //           icon: const Icon(
// // // // //             Icons.arrow_back_ios_new,
// // // // //             color: Colors.white,
// // // // //             size: 20,
// // // // //           ),
// // // // //           onPressed: () {
// // // // //             if (context.canPop()) {
// // // // //               context.pop();
// // // // //             } else {
// // // // //               context.go('/transaction_history'); // သို့မဟုတ် ပင်မစာမျက်နှာ Route
// // // // //             }
// // // // //           },
// // // // //         ),
// // // // //       ),
// // // // //       body: SafeArea(
// // // // //         child: SingleChildScrollView(
// // // // //           padding: const EdgeInsets.all(16.0),
// // // // //           child: Column(
// // // // //             children: [
// // // // //               // 2. Detail Card
// // // // //               Container(
// // // // //                 width: double.infinity,
// // // // //                 padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
// // // // //                 decoration: BoxDecoration(
// // // // //                   color: Colors.white,
// // // // //                   borderRadius: BorderRadius.circular(16),
// // // // //                   boxShadow: [
// // // // //                     BoxShadow(
// // // // //                       color: Colors.black.withOpacity(0.03),
// // // // //                       blurRadius: 10,
// // // // //                       offset: const Offset(0, 4),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //                 child: Column(
// // // // //                   children: [
// // // // //                     // Status Icon Container
// // // // //                     Container(
// // // // //                       padding: const EdgeInsets.all(16),
// // // // //                       decoration: const BoxDecoration(
// // // // //                         color: lightTeal,
// // // // //                         shape: BoxShape.circle,
// // // // //                       ),
// // // // //                       child: const Icon(
// // // // //                         Icons.check_circle_rounded,
// // // // //                         size: 48,
// // // // //                         color: primaryTeal,
// // // // //                       ),
// // // // //                     ),
// // // // //                     const SizedBox(height: 12),
        
// // // // //                     // Transaction Status Text
// // // // //                     const Text(
// // // // //                       "လုပ်ဆောင်ချက် အောင်မြင်ပါသည်",
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 14,
// // // // //                         color: primaryTeal,
// // // // //                         fontWeight: FontWeight.w600,
// // // // //                       ),
// // // // //                     ),
// // // // //                     const SizedBox(height: 8),
        
// // // // //                     // Amount Text (double ကို String သို့ပြောင်းရန် interpolation သုံးထားသည်)
// // // // //                     Text(
// // // // //                       "${transaction.amount}",
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 22,
// // // // //                         fontWeight: FontWeight.bold,
// // // // //                         color: isReceived ? const Color(0xff059669) : primaryTeal,
// // // // //                       ),
// // // // //                     ),
// // // // //                     const SizedBox(height: 16),
        
// // // // //                     const Divider(thickness: 1, height: 24, color: lightTeal),
        
// // // // //                     // 1. လုပ်ဆောင်သောအချိန်[cite: 19]
// // // // //                     _buildDetailRow("လုပ်ဆောင်သောအချိန်", transaction.time),
        
// // // // //                     // 2. လုပ်ဆောင်မှုအမျိုးအစား[cite: 19]
// // // // //                     _buildDetailRow(
// // // // //                       "လုပ်ဆောင်မှုအမျိုးအစား",
// // // // //                       isReceived ? "ပွိုင့်လက်ခံ" : "ပွိုင့်လွှဲ",
// // // // //                     ),
        
// // // // //                     // 3. ပွိုင့်လွှဲမည် သို့ / ပေးပို့သူ[cite: 19]
// // // // //                     _buildUserDetailRow(
// // // // //                       labelTitle,
// // // // //                       recipientName,
// // // // //                       _maskPhoneNumber(phoneNumber),
// // // // //                     ),
        
// // // // //                     // 4. လုပ်ဆောင်ချက် အမှတ် (ID) - transactionId ကို int မှ String သို့ပြောင်းရန်[cite: 19]
// // // // //                     _buildDetailRow("လုပ်ဆောင်ချက် အမှတ် (ID)", transaction.transactionId.toString()),
        
// // // // //                     // 5. ပွိုင့်ပမာဏ[cite: 19]
// // // // //                     _buildDetailRow("ပွိုင့်ပမာဏ", "${transaction.amount}"),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   // ရိုးရိုး Detail Row[cite: 19]
// // // // //   Widget _buildDetailRow(String label, String value) {
// // // // //     return Padding(
// // // // //       padding: const EdgeInsets.symmetric(vertical: 10.0),
// // // // //       child: Row(
// // // // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: [
// // // // //           Expanded(
// // // // //             flex: 4,
// // // // //             child: Text(
// // // // //               label,
// // // // //               style: const TextStyle(
// // // // //                 fontSize: 13,
// // // // //                 color: primaryTeal,
// // // // //                 fontWeight: FontWeight.w500,
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //           Expanded(
// // // // //             flex: 5,
// // // // //             child: Text(
// // // // //               value,
// // // // //               textAlign: TextAlign.right,
// // // // //               style: const TextStyle(
// // // // //                 fontSize: 13,
// // // // //                 fontWeight: FontWeight.bold,
// // // // //                 color: primaryTeal,
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   // Kpay ပုံစံ အမည်နှင့် ဖုန်းနံပါတ် Row[cite: 19]
// // // // //   Widget _buildUserDetailRow(String label, String name, String maskedPhone) {
// // // // //     return Padding(
// // // // //       padding: const EdgeInsets.symmetric(vertical: 10.0),
// // // // //       child: Row(
// // // // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: [
// // // // //           Expanded(
// // // // //             flex: 4,
// // // // //             child: Text(
// // // // //               label,
// // // // //               style: const TextStyle(
// // // // //                 fontSize: 13,
// // // // //                 color: primaryTeal,
// // // // //                 fontWeight: FontWeight.w500,
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //           Expanded(
// // // // //             flex: 5,
// // // // //             child: Column(
// // // // //               crossAxisAlignment: CrossAxisAlignment.end,
// // // // //               children: [
// // // // //                 Text(
// // // // //                   name,
// // // // //                   textAlign: TextAlign.right,
// // // // //                   style: const TextStyle(
// // // // //                     fontSize: 13,
// // // // //                     fontWeight: FontWeight.bold,
// // // // //                     color: primaryTeal,
// // // // //                   ),
// // // // //                 ),
// // // // //                 const SizedBox(height: 2),
// // // // //                 Text(
// // // // //                   maskedPhone,
// // // // //                   textAlign: TextAlign.right,
// // // // //                   style: const TextStyle(
// // // // //                     fontSize: 12,
// // // // //                     fontWeight: FontWeight.w600,
// // // // //                     color: primaryTeal,
// // // // //                   ),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }
// // // // import 'package:flutter/material.dart';
// // // // import 'package:go_router/go_router.dart';
// // // // import 'package:smartcanteen/model/transaction_model.dart';

// // // // class TransactionDetailScreen extends StatelessWidget {
// // // //   final TransactionModel transaction;

// // // //   const TransactionDetailScreen({
// // // //     super.key,
// // // //     required this.transaction,
// // // //   });

// // // //   static const Color primaryTeal = Color(0xff117992);
// // // //   static const Color lightTeal = Color(0xFFE0F2F1);

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final bool isReceived = transaction.type == TransactionType.received;

// // // //     return Scaffold(
// // // //       backgroundColor: const Color(0xFFF5F5F5),
// // // //       appBar: AppBar(
// // // //         title: const Text(
// // // //           "လုပ်ဆောင်ချက် အသေးစိတ်",
// // // //           style: TextStyle(
// // // //             color: Colors.white,
// // // //             fontSize: 16,
// // // //             fontWeight: FontWeight.bold,
// // // //           ),
// // // //         ),
// // // //         centerTitle: true,
// // // //         backgroundColor: primaryTeal,
// // // //         elevation: 0.5,
// // // //         leading: IconButton(
// // // //           icon: const Icon(
// // // //             Icons.arrow_back_ios_new,
// // // //             color: Colors.white,
// // // //             size: 20,
// // // //           ),
// // // //           onPressed: () {
// // // //             if (context.canPop()) {
// // // //               context.pop();
// // // //             } else {
// // // //               context.go('/transaction_history');
// // // //             }
// // // //           },
// // // //         ),
// // // //       ),
// // // //       body: SafeArea(
// // // //         child: SingleChildScrollView(
// // // //           padding: const EdgeInsets.all(16.0),
// // // //           child: Column(
// // // //             children: [
// // // //               Container(
// // // //                 width: double.infinity,
// // // //                 padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
// // // //                 decoration: BoxDecoration(
// // // //                   color: Colors.white,
// // // //                   borderRadius: BorderRadius.circular(16),
// // // //                   boxShadow: [
// // // //                     BoxShadow(
// // // //                       color: Colors.black.withOpacity(0.03),
// // // //                       blurRadius: 10,
// // // //                       offset: const Offset(0, 4),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //                 child: Column(
// // // //                   children: [
// // // //                     Container(
// // // //                       padding: const EdgeInsets.all(16),
// // // //                       decoration: const BoxDecoration(
// // // //                         color: lightTeal,
// // // //                         shape: BoxShape.circle,
// // // //                       ),
// // // //                       child: const Icon(
// // // //                         Icons.check_circle_rounded,
// // // //                         size: 48,
// // // //                         color: primaryTeal,
// // // //                       ),
// // // //                     ),
// // // //                     const SizedBox(height: 12),
// // // //                     const Text(
// // // //                       "လုပ်ဆောင်ချက် အောင်မြင်ပါသည်",
// // // //                       style: TextStyle(
// // // //                         fontSize: 14,
// // // //                         color: primaryTeal,
// // // //                         fontWeight: FontWeight.w600,
// // // //                       ),
// // // //                     ),
// // // //                     const SizedBox(height: 8),
// // // //                     Text(
// // // //                       transaction.displayAmount ?? "${transaction.amount}",
// // // //                       style: TextStyle(
// // // //                         fontSize: 22,
// // // //                         fontWeight: FontWeight.bold,
// // // //                         color: isReceived ? const Color(0xff059669) : primaryTeal,
// // // //                       ),
// // // //                     ),
// // // //                     const SizedBox(height: 16),
// // // //                     const Divider(thickness: 1, height: 24, color: lightTeal),
                    
// // // //                     // လုပ်ဆောင်သောအချိန်[cite: 6]
// // // //                     _buildDetailRow("လုပ်ဆောင်သောအချိန်", transaction.time),
                    
// // // //                     // လုပ်ဆောင်မှုအမျိုးအစား[cite: 6]
// // // //                     _buildDetailRow("လုပ်ဆောင်မှုအမျိုးအစား", transaction.title),
                    
// // // //                     // From Wallet ID ရှိမှသာ ပြသရန် (ငွေလွှဲသူ / ပေးပို့သူ)[cite: 6]
// // // //                     if (transaction.fromWalletId != null)
// // // //                       _buildDetailRow("ပေးပို့သည့် Wallet (From)", "Wallet ID: ${transaction.fromWalletId}"),
                    
// // // //                     // To Wallet ID ရှိမှသာ ပြသရန် (လက်ခံရရှိသူ)[cite: 6]
// // // //                     if (transaction.toWalletId != null)
// // // //                       _buildDetailRow("လက်ခံမည့် Wallet (To)", "Wallet ID: ${transaction.toWalletId}"),
                    
// // // //                     // လုပ်ဆောင်ချက် အမှတ် (ID)[cite: 6]
// // // //                     _buildDetailRow("လုပ်ဆောင်ချက် အမှတ် (ID)", transaction.transactionId.toString()),
                    
// // // //                     // ပွိုင့်ပမာဏ[cite: 6]
// // // //                     _buildDetailRow("ပွိုင့်ပမာဏ", transaction.displayAmount ?? "${transaction.amount}"),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildDetailRow(String label, String value) {
// // // //     return Padding(
// // // //       padding: const EdgeInsets.symmetric(vertical: 10.0),
// // // //       child: Row(
// // // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: [
// // // //           Expanded(
// // // //             flex: 4,
// // // //             child: Text(
// // // //               label,
// // // //               style: const TextStyle(
// // // //                 fontSize: 13,
// // // //                 color: primaryTeal,
// // // //                 fontWeight: FontWeight.w500,
// // // //               ),
// // // //             ),
// // // //           ),
// // // //           Expanded(
// // // //             flex: 5,
// // // //             child: Text(
// // // //               value,
// // // //               textAlign: TextAlign.right,
// // // //               style: const TextStyle(
// // // //                 fontSize: 13,
// // // //                 fontWeight: FontWeight.bold,
// // // //                 color: primaryTeal,
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:go_router/go_router.dart';
// // // import 'package:smartcanteen/model/transaction_model.dart';

// // // class TransactionDetailScreen extends StatelessWidget {
// // //   final TransactionModel transaction;

// // //   const TransactionDetailScreen({
// // //     super.key,
// // //     required this.transaction,
// // //   });

// // //   static const Color primaryTeal = Color(0xff117992);
// // //   static const Color lightTeal = Color(0xFFE0F2F1);

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // 1. Check direction: inflow (received/top-up) vs outflow (sent/spent)
// // //     final bool isInflow = transaction.direction == 'inflow' ||
// // //         transaction.type == TransactionType.received;

// // //     // 2. Set dynamic label for person/shop based on transaction type and direction
// // //     final String labelTitle = isInflow
// // //         ? "ပေးပို့သူ"
// // //         : (transaction.transactionType == 'order_payment'
// // //             ? "ဆိုင်အမည်"
// // //             : "လက်ခံသူ");

// // //     // 3. Dynamic Name (Inflow uses fromUserName, Outflow uses toUserName)
// // //     final String displayName = isInflow
// // //         ? (transaction.fromUserName ?? "မသိရှိသော ပေးပို့သူ")
// // //         : (transaction.toUserName ?? "မသိရှိသော လက်ခံသူ");

// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFFF5F5F5),
// // //       appBar: AppBar(
// // //         title: const Text(
// // //           "လုပ်ဆောင်ချက် အသေးစိတ်",
// // //           style: TextStyle(
// // //             color: Colors.white,
// // //             fontSize: 16,
// // //             fontWeight: FontWeight.bold,
// // //           ),
// // //         ),
// // //         centerTitle: true,
// // //         backgroundColor: primaryTeal,
// // //         elevation: 0.5,
// // //         leading: IconButton(
// // //           icon: const Icon(
// // //             Icons.arrow_back_ios_new,
// // //             color: Colors.white,
// // //             size: 20,
// // //           ),
// // //           onPressed: () {
// // //             if (context.canPop()) {
// // //               context.pop();
// // //             } else {
// // //               context.go('/transaction_history');
// // //             }
// // //           },
// // //         ),
// // //       ),
// // //       body: SafeArea(
// // //         child: SingleChildScrollView(
// // //           padding: const EdgeInsets.all(16.0),
// // //           child: Column(
// // //             children: [
// // //               Container(
// // //                 width: double.infinity,
// // //                 padding:
// // //                     const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.white,
// // //                   borderRadius: BorderRadius.circular(16),
// // //                   boxShadow: [
// // //                     BoxShadow(
// // //                       color: Colors.black.withOpacity(0.03),
// // //                       blurRadius: 10,
// // //                       offset: const Offset(0, 4),
// // //                     ),
// // //                   ],
// // //                 ),
// // //                 child: Column(
// // //                   children: [
// // //                     // Status Icon
// // //                     Container(
// // //                       padding: const EdgeInsets.all(16),
// // //                       decoration: const BoxDecoration(
// // //                         color: lightTeal,
// // //                         shape: BoxShape.circle,
// // //                       ),
// // //                       child: const Icon(
// // //                         Icons.check_circle_rounded,
// // //                         size: 48,
// // //                         color: primaryTeal,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: 12),

// // //                     // Status Text
// // //                     const Text(
// // //                       "လုပ်ဆောင်ချက် အောင်မြင်ပါသည်",
// // //                       style: TextStyle(
// // //                         fontSize: 14,
// // //                         color: primaryTeal,
// // //                         fontWeight: FontWeight.w600,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: 8),

// // //                     // Display Amount (e.g. "- 2,500 Ks")
// // //                     Text(
// // //                       transaction.displayAmount ?? "${transaction.amount} Ks",
// // //                       style: TextStyle(
// // //                         fontSize: 22,
// // //                         fontWeight: FontWeight.bold,
// // //                         color:
// // //                             isInflow ? const Color(0xff059669) : primaryTeal,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: 16),
// // //                     const Divider(thickness: 1, height: 24, color: lightTeal),

// // //                     // 1. လုပ်ဆောင်သောအချိန် (created_at)
// // //                     _buildDetailRow("လုပ်ဆောင်သောအချိန်", transaction.createdAt),

// // //                     // 2. လုပ်ဆောင်မှုအမျိုးအစား (display_type)
// // //                     _buildDetailRow("လုပ်ဆောင်မှုအမျိုးအစား", transaction.title),

// // //                     // 3. ပေးပို့သူ / လက်ခံသူ / ဆိုင်အမည်
// // //                     _buildDetailRow(labelTitle, displayName),

// // //                     // 4. ပေးပို့သည့် ပိုင်ရှင်/Wallet (From User & Wallet)
// // //                     if (transaction.fromWalletId != null)
// // //                       _buildDetailRow(
// // //                         "ပေးပို့သည့် Wallet",
// // //                         "${transaction.fromUserName ?? ''} (ID: ${transaction.fromWalletId})",
// // //                       ),

// // //                     // 5. လက်ခံသည့် ပိုင်ရှင်/Wallet (To User & Wallet)
// // //                     if (transaction.toWalletId != null)
// // //                       _buildDetailRow(
// // //                         "လက်ခံသည့် Wallet",
// // //                         "${transaction.toUserName ?? ''} (ID: ${transaction.toWalletId})",
// // //                       ),

// // //                     // 6. လုပ်ဆောင်ချက် အမှတ် (transaction_id)
// // //                     _buildDetailRow(
// // //                       "လုပ်ဆောင်ချက် အမှတ် (ID)",
// // //                       transaction.transactionId.toString(),
// // //                     ),

// // //                     // 7. ပွိုင့်ပမာဏ / ကျသင့်ငွေ
// // //                     _buildDetailRow(
// // //                       "ပွိုင့်ပမာဏ",
// // //                       transaction.displayAmount ?? "${transaction.amount} Ks",
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildDetailRow(String label, String value) {
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(vertical: 10.0),
// // //       child: Row(
// // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Expanded(
// // //             flex: 4,
// // //             child: Text(
// // //               label,
// // //               style: const TextStyle(
// // //                 fontSize: 13,
// // //                 color: primaryTeal,
// // //                 fontWeight: FontWeight.w500,
// // //               ),
// // //             ),
// // //           ),
// // //           Expanded(
// // //             flex: 5,
// // //             child: Text(
// // //               value,
// // //               textAlign: TextAlign.right,
// // //               style: const TextStyle(
// // //                 fontSize: 13,
// // //                 fontWeight: FontWeight.bold,
// // //                 color: primaryTeal,
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:smartcanteen/model/transaction_model.dart';

// // class TransactionDetailScreen extends StatelessWidget {
// //   final TransactionModel transaction;

// //   const TransactionDetailScreen({
// //     super.key,
// //     required this.transaction,
// //   });

// //   static const Color primaryTeal = Color(0xff117992);
// //   static const Color lightTeal = Color(0xFFE0F2F1);

// //   /// Simple date formatter to clean up "2026-08-02T06:37:06.000000Z" -> "2026-08-02 06:37"
// //   String _formatDateTime(String rawDate) {
// //     try {
// //       final parsed = DateTime.parse(rawDate);
// //       final year = parsed.year;
// //       final month = parsed.month.toString().padLeft(2, '0');
// //       final day = parsed.day.toString().padLeft(2, '0');
// //       final hour = parsed.hour.toString().padLeft(2, '0');
// //       final minute = parsed.minute.toString().padLeft(2, '0');
// //       return "$year-$month-$day $hour:$minute";
// //     } catch (_) {
// //       return rawDate;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final bool isTopUp = transaction.transactionType == 'top-up';
// //     final bool isOrderPayment = transaction.transactionType == 'order_payment';
// //     final bool isInflow = transaction.direction == 'inflow' ||
// //         transaction.type == TransactionType.received;

// //     // 1. Dynamic label (Sender, Receiver, or Shop)
// //     final String labelTitle = isTopUp
// //         ? "ပေးပို့သူ "
// //         : (isInflow
// //             ? "ပေးပို့သူ"
// //             : (isOrderPayment ? "ဆိုင်အမည်" : "လက်ခံသူ"));

// //     // 2. Dynamic display name fallback
// //     final String displayName = isTopUp
// //         ? "စနစ်မှ ငွေဖြည့်သွင်းခြင်း" // System Top-Up instead of Unknown
// //         : (isInflow
// //             ? (transaction.fromUserName ?? "စနစ်")
// //             : (transaction.toUserName ?? "မသိရှိသော လက်ခံသူ"));

// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF5F5F5),
// //       appBar: AppBar(
// //         title: const Text(
// //           "လုပ်ဆောင်ချက် အသေးစိတ်",
// //           style: TextStyle(
// //             color: Colors.white,
// //             fontSize: 16,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         centerTitle: true,
// //         backgroundColor: primaryTeal,
// //         elevation: 0.5,
// //         leading: IconButton(
// //           icon: const Icon(
// //             Icons.arrow_back_ios_new,
// //             color: Colors.white,
// //             size: 20,
// //           ),
// //           onPressed: () {
// //             if (context.canPop()) {
// //               context.pop();
// //             } else {
// //               context.go('/transaction_history');
// //             }
// //           },
// //         ),
// //       ),
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             children: [
// //               Container(
// //                 width: double.infinity,
// //                 padding:
// //                     const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius: BorderRadius.circular(16),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.black.withOpacity(0.03),
// //                       blurRadius: 10,
// //                       offset: const Offset(0, 4),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Column(
// //                   children: [
// //                     // Status Icon
// //                     Container(
// //                       padding: const EdgeInsets.all(16),
// //                       decoration: const BoxDecoration(
// //                         color: lightTeal,
// //                         shape: BoxShape.circle,
// //                       ),
// //                       child: const Icon(
// //                         Icons.check_circle_rounded,
// //                         size: 48,
// //                         color: primaryTeal,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 12),

// //                     // Status Text
// //                     Text(
// //                       transaction.status == 'held'
// //                           ? "လုပ်ဆောင်ချက် ထိန်းသိမ်းထားပါသည်"
// //                           : "လုပ်ဆောင်ချက် အောင်မြင်ပါသည်",
// //                       style: const TextStyle(
// //                         fontSize: 14,
// //                         color: primaryTeal,
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 8),

// //                     // Amount Text
// //                     Text(
// //                       transaction.displayAmount ?? "${transaction.amount} Ks",
// //                       style: TextStyle(
// //                         fontSize: 22,
// //                         fontWeight: FontWeight.bold,
// //                         color:
// //                             isInflow ? const Color(0xff059669) : primaryTeal,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 16),
// //                     const Divider(thickness: 1, height: 24, color: lightTeal),

// //                     // 1. Cleaned Date/Time
// //                     _buildDetailRow(
// //                       "လုပ်ဆောင်သောအချိန်",
// //                       _formatDateTime(transaction.createdAt),
// //                     ),

// //                     // 2. Transaction Type
// //                     _buildDetailRow("လုပ်ဆောင်မှုအမျိုးအစား", transaction.title),

// //                     // 3. Sender / Receiver / Method
// //                     _buildDetailRow(labelTitle, displayName),

// //                     // 4. Sender Wallet (Only show for peer-to-peer transfers, not top-ups)
// //                     if (!isTopUp && transaction.fromWalletId != null)
// //                       _buildDetailRow(
// //                         "ပေးပို့သည့် Wallet (ID)",
// //                         "${transaction.fromWalletId}",
// //                       ),

// //                     // 5. Receiver Wallet (Only show for peer-to-peer transfers, not top-ups)
// //                     if (!isTopUp && transaction.toWalletId != null)
// //                       _buildDetailRow(
// //                         "လက်ခံသည့် Wallet (ID)",
// //                         "${transaction.toWalletId}",
// //                       ),

// //                     // 6. Order ID (Only show if payment is tied to an order)
// //                     if (transaction.orderId != null)
// //                       _buildDetailRow(
// //                         "အော်ဒါ အမှတ် (ID)",
// //                         "#${transaction.orderId}",
// //                       ),

// //                     // 7. Remark
// //                     if (transaction.remark != null &&
// //                         transaction.remark!.isNotEmpty)
// //                       _buildDetailRow("မှတ်ချက်", transaction.remark!),

// //                     // 8. Transaction ID
// //                     _buildDetailRow(
// //                       "လုပ်ဆောင်ချက် အမှတ် (ID)",
// //                       transaction.transactionId.toString(),
// //                     ),

// //                     // 9. Total Amount
// //                     _buildDetailRow(
// //                       "ပွိုင့်ပမာဏ",
// //                       transaction.displayAmount ?? "${transaction.amount} Ks",
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildDetailRow(String label, String value) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 10.0),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Expanded(
// //             flex: 4,
// //             child: Text(
// //               label,
// //               style: const TextStyle(
// //                 fontSize: 13,
// //                 color: primaryTeal,
// //                 fontWeight: FontWeight.w500,
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             flex: 5,
// //             child: Text(
// //               value,
// //               textAlign: TextAlign.right,
// //               style: const TextStyle(
// //                 fontSize: 13,
// //                 fontWeight: FontWeight.bold,
// //                 color: primaryTeal,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:smartcanteen/model/transaction_model.dart';

// class TransactionDetailScreen extends StatelessWidget {
//   final TransactionModel transaction;

//   const TransactionDetailScreen({
//     super.key,
//     required this.transaction,
//   });

//   static const Color primaryTeal = Color(0xff117992);
//   static const Color lightTeal = Color(0xFFE0F2F1);

//   /// Simple date formatter to clean up "2026-08-02T06:37:06.000000Z" -> "2026-08-02 06:37"
//   String _formatDateTime(String rawDate) {
//     try {
//       final parsed = DateTime.parse(rawDate);
//       final year = parsed.year;
//       final month = parsed.month.toString().padLeft(2, '0');
//       final day = parsed.day.toString().padLeft(2, '0');
//       final hour = parsed.hour.toString().padLeft(2, '0');
//       final minute = parsed.minute.toString().padLeft(2, '0');
//       return "$year-$month-$day $hour:$minute";
//     } catch (_) {
//       return rawDate;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool isInflow = transaction.direction == 'inflow' ||
//         transaction.type == TransactionType.received;
//          final bool isOutflow = transaction.direction == 'outflow' ||
//         transaction.type == TransactionType.TRANSFER || transaction.type == TransactionType.order_payment;

//     // 1. Dynamic label (Inflow -> ပေးပို့သူ, Outflow -> လက်ခံသူ)
//     final String labelTitle1 = isInflow ? "ပေးပို့သူ" : "";
//     final String labelTitle2 = !isInflow ? "လက်ခံသူ" : "";

//     // 2. Dynamic display name (Inflow -> fromUserName, Outflow -> toUserName)
//     final String displayName1 = isInflow
//         ? (transaction.fromUserName ?? "စနစ်")
//         : "";
//         final String displayName2 = isInflow
//         ? (transaction.toUserName ?? "မသိရှိသော လက်ခံသူ")
//         : "";

//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       appBar: AppBar(
//         title: const Text(
//           "လုပ်ဆောင်ချက် အသေးစိတ်",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: primaryTeal,
//         elevation: 0.5,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios_new,
//             color: Colors.white,
//             size: 20,
//           ),
//           onPressed: () {
//             if (context.canPop()) {
//               context.pop();
//             } else {
//               context.go('/transaction_history');
//             }
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.03),
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     // Status Icon
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: const BoxDecoration(
//                         color: lightTeal,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(
//                         Icons.check_circle_rounded,
//                         size: 48,
//                         color: primaryTeal,
//                       ),
//                     ),
//                     const SizedBox(height: 12),

//                     // Status Text
//                     Text(
//                        "လုပ်ဆောင်ချက် အောင်မြင်ပါသည်",
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: primaryTeal,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 8),

//                     // Amount Text
//                     Text(
//                       transaction.displayAmount ?? "${transaction.amount} Ks",
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color:
//                             isInflow ? const Color(0xff059669) : primaryTeal,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     const Divider(thickness: 1, height: 24, color: lightTeal),

//                     // 1. Cleaned Date/Time
//                     _buildDetailRow(
//                       "လုပ်ဆောင်သောအချိန်",
//                       _formatDateTime(transaction.createdAt),
//                     ),

//                     // 2. Transaction Type
//                     _buildDetailRow("လုပ်ဆောင်မှုအမျိုးအစား", transaction.title),

//                     // 3. Sender or Receiver Name
//                     _buildDetailRow("ပေးပို့သူ", displayName1),
//                     _buildDetailRow("လက်ခံသူ", displayName2),
//                     // 4. Sender Wallet (Shown if available)
//                     if (transaction.fromWalletId != null)
//                       _buildDetailRow(
//                         "ပေးပို့သည့် Wallet (ID)",
//                         "${transaction.fromWalletId}",
//                       ),

//                     // 5. Receiver Wallet (Shown if available)
//                     if (transaction.toWalletId != null)
//                       _buildDetailRow(
//                         "လက်ခံသည့် Wallet (ID)",
//                         "${transaction.toWalletId}",
//                       ),

//                     // 6. Order ID (Shown if associated with an order)
//                     if (transaction.orderId != null)
//                       _buildDetailRow(
//                         "အော်ဒါ အမှတ် (ID)",
//                         "#${transaction.orderId}",
//                       ),

//                     // 7. Remark
//                     if (transaction.remark != null &&
//                         transaction.remark!.isNotEmpty)
//                       _buildDetailRow("မှတ်ချက်", transaction.remark!),

//                     // 8. Transaction ID
//                     _buildDetailRow(
//                       "လုပ်ဆောင်ချက် အမှတ် (ID)",
//                       transaction.transactionId.toString(),
//                     ),

//                     // 9. Total Amount
//                     _buildDetailRow(
//                       "ပွိုင့်ပမာဏ",
//                       transaction.displayAmount ?? "${transaction.amount} Ks",
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 4,
//             child: Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 13,
//                 color: primaryTeal,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 5,
//             child: Text(
//               value,
//               textAlign: TextAlign.right,
//               style: const TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.bold,
//                 color: primaryTeal,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/model/transaction_model.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailScreen({
    super.key,
    required this.transaction,
  });

  static const Color primaryTeal = Color(0xff117992);
  static const Color lightTeal = Color(0xFFE0F2F1);

  /// Simple date formatter to clean up "2026-08-02T06:37:06.000000Z" -> "2026-08-02 06:37"
  String _formatDateTime(String rawDate) {
    try {
      final parsed = DateTime.parse(rawDate);
      final year = parsed.year;
      final month = parsed.month.toString().padLeft(2, '0');
      final day = parsed.day.toString().padLeft(2, '0');
      final hour = parsed.hour.toString().padLeft(2, '0');
      final minute = parsed.minute.toString().padLeft(2, '0');
      return "$year-$month-$day $hour:$minute";
    } catch (_) {
      return rawDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isInflow = transaction.direction == 'inflow' ||
        transaction.type == TransactionType.received;

    final bool isOrderPayment = transaction.transactionType == 'order_payment';

    // 1. ပေးပို့သူ (From User Name) Dynamic Assignment
    final String senderName = transaction.fromUserName ??
        (isInflow ? "စနစ်" : "အကောင့်ပိုင်ရှင်");

    // 2. လက်ခံသူ / ဆိုင်အမည် (To User Name) Dynamic Assignment
    final String receiverName = transaction.toUserName ??
        (isOrderPayment ? "မသိရှိသော ဆိုင်အမည်" : "မသိရှိသော လက်ခံသူ");

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          "လုပ်ဆောင်ချက် အသေးစိတ်",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryTeal,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/transaction_history');
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Status Icon
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: lightTeal,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle_rounded,
                        size: 48,
                        color: primaryTeal,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Status Text
                    const Text(
                      "လုပ်ဆောင်ချက် အောင်မြင်ပါသည်",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryTeal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Amount Text
                    Text(
                      transaction.displayAmount ?? "${transaction.amount} Ks",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color:
                            isInflow ? const Color(0xff059669) : primaryTeal,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(thickness: 1, height: 24, color: lightTeal),

                    // 1. Cleaned Date/Time
                    _buildDetailRow(
                      "လုပ်ဆောင်သောအချိန်",
                      _formatDateTime(transaction.createdAt),
                    ),

                    // 2. Transaction Type
                    _buildDetailRow("လုပ်ဆောင်မှုအမျိုးအစား", transaction.title),

                    // 3. ပေးပို့သူ (from_user_name ရှိလျှင် သို့မဟုတ် inflow ဖြစ်လျှင် ပြရန်)
                    if (transaction.fromUserName != null || isInflow)
                      _buildDetailRow("ပေးပို့သူ", senderName),

                    // 4. လက်ခံသူ / ဆိုင်အမည် (to_user_name ရှိလျှင် သို့မဟုတ် order_payment/outflow ဖြစ်လျှင် ပြရန်)
                    if (transaction.toUserName != null || !isInflow)
                      _buildDetailRow(
                        isOrderPayment ? "ဆိုင်အမည်" : "လက်ခံသူ",
                        receiverName,
                      ),

                    // // 5. Sender Wallet (ID)
                    // if (transaction.fromWalletId != null)
                    //   _buildDetailRow(
                    //     "ပေးပို့သည့် Wallet (ID)",
                    //     "${transaction.fromWalletId}",
                    //   ),

                    // // 6. Receiver Wallet (ID)
                    // if (transaction.toWalletId != null)
                    //   _buildDetailRow(
                    //     "လက်ခံသည့် Wallet (ID)",
                    //     "${transaction.toWalletId}",
                    //   ),

                    // 7. Order ID
                    if (transaction.orderId != null)
                      _buildDetailRow(
                        "အော်ဒါ အမှတ် (ID)",
                        "#${transaction.orderId}",
                      ),

                    // 8. Remark
                    if (transaction.remark != null &&
                        transaction.remark!.isNotEmpty)
                      _buildDetailRow("မှတ်ချက်", transaction.remark!),

                    // 9. Transaction ID
                    _buildDetailRow(
                      "လုပ်ဆောင်ချက် အမှတ် (ID)",
                      transaction.transactionId.toString(),
                    ),

                    // 10. Total Amount
                    _buildDetailRow(
                      "ပွိုင့်ပမာဏ",
                      transaction.displayAmount ?? "${transaction.amount} Ks",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: primaryTeal,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: primaryTeal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}