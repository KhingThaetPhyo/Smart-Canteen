// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:smartcanteen/view/order_screen.dart';
// import 'package:smartcanteen/view/pickup_qr_screen.dart';

// class OrderDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> order;

//   const OrderDetailScreen({super.key, required this.order});

//   // Teal Theme Color
//   static const Color primaryTeal = Color(0xff117992);
//   static final Color lightTeal = Colors.teal.shade50;
//   static final Color darkTeal = const Color(0xff117992);

//   // ရက်စွဲကို Formatted လုပ်ရန်
//   String _formatEnglishDateTime(dynamic dateInput) {
//     if (dateInput == null) return '';
//     if (dateInput is String) {
//       final parsedDate = DateTime.tryParse(dateInput);
//       if (parsedDate != null) {
//         return DateFormat('d/M/yyyy HH:mm:ss').format(parsedDate);
//       }
//       return dateInput; 
//     }
//     return '';
//   }

//   // QR ကုဒ်ပြမည့် Dialog (order_id နှင့် qr_code_token နှစ်ခုစလုံးကို ပေါင်းစပ်ထားသည်)
//   void _showPickUpCodeDialog(BuildContext context, dynamic orderId, String qrCodeToken) {
//     final String qrData = "Order ID: $orderId\nToken: $qrCodeToken";

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: const Text(
//             "ပစ္စည်းထုတ်ယူရန် QR ကုဒ်",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Color(0xff117992),
//             ),
//           ),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.teal.shade100),
//                   ),
//                   child: SizedBox(
//                     width: 200,
//                     height: 200,
//                     child: QrImageView(
//                       data: qrData, // order_id နှင့် qr_code_token ပေါင်းစပ်ထားသော ဒေတာ
//                       version: QrVersions.auto,
//                       size: 200.0,
//                       backgroundColor: Colors.white,
//                       gapless: true,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   "အော်ဒါနံပါတ်: $orderId",
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   "ကုဒ်: $qrCodeToken",
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             Center(
//               child: TextButton(
//                 style: TextButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: const Color(0xff117992),
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text("ပိတ်မည်"),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // API မှ JSON Key များနှင့် ကိုက်ညီအောင် ပြင်ဆင်ထားခြင်း
//     final String shopName = order['shop_name'] ?? 'အန်တီမွန် စားသောက်ဆိုင်';
//     final String customerName = order['customer_name'] ?? 'Aung Aung';
//     final String orderDate = order['order_time'] ?? '';
//     final String phone = order['customer_phone'] ?? '09 790182418';
//     final String code = order['qr_code_token'] ?? 'MBK-1000';
    
//     // order_id ကို ထည့်သွင်းထုတ်ယူခြင်း
//     final dynamic orderId = order['order_id'] ?? order['id'] ?? '';
    
//     final List items = order['items'] ?? [];

//     // can_pickup (စမ်းသပ်ရန် အမြဲပေါ်နေစေရန် true ပေးထားပါသည်)
//     //final bool canPickup = order['can_pickup'] ?? true;
// // can_pickup ကို order ၏ status သည် 'ready' ဖြစ်မှသာ true ဖြစ်စေရန် စစ်ဆေးခြင်း
//     final String status = (order['status'] ?? '').toString().toLowerCase();
//     final bool canPickup = status == 'ready';
//     // စုစုပေါင်း ကျသင့်ပွိုင့် တွက်ချက်ခြင်း
//     int totalAmount = 0;
//     for (var itemData in items) {
//       final int qty = itemData['quantity'] ?? 1;
//       final int price = itemData['unit_price'] ?? 0;
//       totalAmount += price * qty;
//     }

//     return Scaffold(
//       backgroundColor: lightTeal,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(80),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Container(
//               height: 56,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [primaryTeal, primaryTeal.withOpacity(0.85)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: primaryTeal.withOpacity(0.35),
//                     blurRadius: 12,
//                     spreadRadius: 1,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8),
//                     child: IconButton(
//                       icon: const Icon(
//                         Icons.arrow_back_ios_new_rounded,
//                         color: Colors.white,
//                         size: 18,
//                       ),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ),
//                   Expanded(
//                     child: Text(
//                       "$shopName စားသောက်ဆိုင်",
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         letterSpacing: 0.3,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   const SizedBox(width: 48),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//         child: Column(
//           children: [
//             ClipPath(
//               clipper: ReceiptClipper(),
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(16),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.teal.withOpacity(0.08),
//                       blurRadius: 15,
//                       offset: const Offset(0, 6),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Center(
//                             child: Text(
//                               "အော်ဒါပြေစာ",
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.w900,
//                                 color: darkTeal,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 child: _buildInfoRow("ဝယ်ယူသူ", customerName),
//                               ),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 child: _buildInfoRow("ရက်စွဲ", orderDate),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           _buildInfoRow("ဖုန်းနံပါတ်", phone),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Column(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               color: lightTeal,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 10,
//                               horizontal: 6,
//                             ),
//                             child: Row(
//                               children: [
//                                 SizedBox(
//                                   width: 30,
//                                   child: Text(
//                                     "စဉ်",
//                                     textAlign: TextAlign.center,
//                                     style: _headerStyle(darkTeal),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 3,
//                                   child: Text(
//                                     "အမျိုးအမည်",
//                                     style: _headerStyle(darkTeal),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Text(
//                                     "အရေတွက်",
//                                     textAlign: TextAlign.center,
//                                     style: _headerStyle(darkTeal),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Text(
//                                     "ဈေးနှုန်း",
//                                     textAlign: TextAlign.right,
//                                     style: _headerStyle(darkTeal),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Text(
//                                     "သင့်ပွိုင့်",
//                                     textAlign: TextAlign.right,
//                                     style: _headerStyle(darkTeal),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           ...List.generate(items.length, (index) {
//                             final itemData = items[index];
//                             final int qty = itemData['quantity'] ?? 1;
//                             final int price = itemData['unit_price'] ?? 0;
//                             final int subtotal = itemData['total_price'] ?? (price * qty);

//                             return Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 8,
//                                 horizontal: 6,
//                               ),
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     width: 30,
//                                     child: Text(
//                                       "${index + 1}",
//                                       textAlign: TextAlign.center,
//                                       style: _cellStyle,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 3,
//                                     child: Text(
//                                       itemData['name'] ?? '',
//                                       style: _cellStyle,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       "$qty",
//                                       textAlign: TextAlign.center,
//                                       style: _cellStyle,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       "$price",
//                                       textAlign: TextAlign.right,
//                                       style: _cellStyle,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       "$subtotal",
//                                       textAlign: TextAlign.right,
//                                       style: _cellStyleBold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }),
//                           const SizedBox(height: 8),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: lightTeal,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 12,
//                               horizontal: 12,
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "စုစုပေါင်းကျသင့်ပွိုင့်",
//                                   style: TextStyle(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.bold,
//                                     color: darkTeal,
//                                   ),
//                                 ),
//                                 Text(
//                                   "$totalAmount ပွိုင့်",
//                                   style: const TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w900,
//                                     color: primaryTeal,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 28),
//                     if (canPickup)
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 20, 36),
//                         child: Center(
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: primaryTeal.withOpacity(0.3),
//                                   blurRadius: 10,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             child: Material(
//                               color: Colors.transparent,
//                               child: InkWell(
//                                 // orderId နှင့် code ကို Dialog ထဲသို့ ထည့်သွင်းပေးခြင်း
//                                 onTap: () => _showPickUpCodeDialog(context, orderId, code),
//                                 borderRadius: BorderRadius.circular(16),
//                                 child: Ink(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 24,
//                                     vertical: 12,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Colors.teal.shade500,
//                                         Colors.teal.shade700,
//                                       ],
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight,
//                                     ),
//                                     borderRadius: BorderRadius.circular(16),
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: const [
//                                       Icon(
//                                         Icons.qr_code_scanner_rounded,
//                                         color: Colors.white,
//                                         size: 20,
//                                       ),
//                                       SizedBox(width: 8),
//                                       Text(
//                                         "ပစ္စည်းယူရန် QR ကုဒ်",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 14,
//                                           letterSpacing: 0.3,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     else
//                       const SizedBox(height: 24),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "$label : ",
//           style: TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.bold,
//             color: Colors.teal.shade700,
//           ),
//         ),
//         Expanded(
//           child: Text(
//             value,
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//               color: darkTeal,
//             ),
//             overflow: TextOverflow.ellipsis,
//             maxLines: 2,
//           ),
//         ),
//       ],
//     );
//   }

//   static TextStyle _headerStyle(Color color) =>
//       TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color);

//   static const TextStyle _cellStyle = TextStyle(
//     fontSize: 12,
//     color: Color(0xFF334155),
//   );

//   static const TextStyle _cellStyleBold = TextStyle(
//     fontSize: 12,
//     fontWeight: FontWeight.bold,
//     color: Colors.teal,
//   );
// }

// class ReceiptClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, size.height - 10);

//     double x = 0;
//     double y = size.height - 10;
//     double increment = 8;

//     while (x < size.width) {
//       x += increment;
//       y = (y == size.height - 10) ? size.height : size.height - 10;
//       path.lineTo(x, y);
//     }

//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';
// // import 'package:qr_flutter/qr_flutter.dart';

// // class OrderDetailScreen extends StatelessWidget {
// //   final Map<String, dynamic> order;

// //   const OrderDetailScreen({super.key, required this.order});

// //   // Teal Theme Color
// //   static const Color primaryTeal = Color(0xff117992);
// //   static final Color lightTeal = Colors.teal.shade50;
// //   static final Color darkTeal = const Color(0xff117992);

// //   // ရက်စွဲကို Formatted လုပ်ရန်
// //   String _formatEnglishDateTime(dynamic dateInput) {
// //     if (dateInput == null) return '';
// //     if (dateInput is String) {
// //       final parsedDate = DateTime.tryParse(dateInput);
// //       if (parsedDate != null) {
// //         return DateFormat('d/M/yyyy HH:mm:ss').format(parsedDate);
// //       }
// //       return dateInput; 
// //     }
// //     return '';
// //   }

// //   // QR ကုဒ်ပြမည့် Dialog (order_id နှင့် qr_code_token နှစ်ခုစလုံးကို ပေါင်းစပ်ထားသည်)
// //   void _showPickUpCodeDialog(BuildContext context, dynamic orderId, String qrCodeToken) {
// //     final String qrData = "Order ID: $orderId\nToken: $qrCodeToken";

// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(16),
// //           ),
// //           title: const Text(
// //             "ပစ္စည်းထုတ်ယူရန် QR ကုဒ်",
// //             textAlign: TextAlign.center,
// //             style: TextStyle(
// //               fontSize: 16,
// //               fontWeight: FontWeight.bold,
// //               color: Color(0xff117992),
// //             ),
// //           ),
// //           content: SingleChildScrollView(
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Container(
// //                   padding: const EdgeInsets.all(12),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(12),
// //                     border: Border.all(color: Colors.teal.shade100),
// //                   ),
// //                   child: SizedBox(
// //                     width: 200,
// //                     height: 200,
// //                     child: QrImageView(
// //                       data: qrData, // order_id နှင့် qr_code_token ပေါင်းစပ်ထားသော ဒေတာ
// //                       version: QrVersions.auto,
// //                       size: 200.0,
// //                       backgroundColor: Colors.white,
// //                       gapless: true,
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 16),
// //                 Text(
// //                   "အော်ဒါနံပါတ်: $orderId",
// //                   style: const TextStyle(
// //                     fontSize: 13,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.black87,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 4),
// //                 Text(
// //                   "ကုဒ်: $qrCodeToken",
// //                   style: const TextStyle(
// //                     fontSize: 12,
// //                     color: Colors.grey,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           actions: [
// //             Center(
// //               child: TextButton(
// //                 style: TextButton.styleFrom(
// //                   foregroundColor: Colors.white,
// //                   backgroundColor: const Color(0xff117992),
// //                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                 ),
// //                 onPressed: () => Navigator.pop(context),
// //                 child: const Text("ပိတ်မည်"),
// //               ),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     // API မှ JSON Key များနှင့် ကိုက်ညီအောင် ပြင်ဆင်ထားခြင်း
// //     final String shopName = order['shop_name'] ?? 'အန်တီမွန် စားသောက်ဆိုင်';
// //     final String customerName = order['customer_name'] ?? 'Aung Aung';
// //     final String orderDate = order['order_time'] ?? '';
// //     final String phone = order['customer_phone'] ?? '09 790182418';
// //     final String code = order['qr_code_token'] ?? 'MBK-1000';
    
// //     // order_id ကို ထည့်သွင်းထုတ်ယူခြင်း
// //     final dynamic orderId = order['order_id'] ?? order['id'] ?? '';
    
// //     final List items = order['items'] ?? [];

// //     // can_pickup (စမ်းသပ်ရန် အမြဲပေါ်နေစေရန် true ပေးထားပါသည်)
// //     final bool canPickup = order['can_pickup'] ?? true;

// //     // စုစုပေါင်း ကျသင့်ပွိုင့် တွက်ချက်ခြင်း
// //     int totalAmount = 0;
// //     for (var itemData in items) {
// //       final int qty = itemData['quantity'] ?? 1;
// //       final int price = itemData['unit_price'] ?? 0;
// //       totalAmount += price * qty;
// //     }

// //     return Scaffold(
// //       backgroundColor: lightTeal,
// //       appBar: PreferredSize(
// //         preferredSize: const Size.fromHeight(80),
// //         child: SafeArea(
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //             child: Container(
// //               height: 56,
// //               decoration: BoxDecoration(
// //                 gradient: LinearGradient(
// //                   colors: [primaryTeal, primaryTeal.withOpacity(0.85)],
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                 ),
// //                 borderRadius: BorderRadius.circular(16),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: primaryTeal.withOpacity(0.35),
// //                     blurRadius: 12,
// //                     spreadRadius: 1,
// //                     offset: const Offset(0, 5),
// //                   ),
// //                 ],
// //               ),
// //               child: Row(
// //                 children: [
// //                   Padding(
// //                     padding: const EdgeInsets.only(left: 8),
// //                     child: IconButton(
// //                       icon: const Icon(
// //                         Icons.arrow_back_ios_new_rounded,
// //                         color: Colors.white,
// //                         size: 18,
// //                       ),
// //                       onPressed: () => Navigator.pop(context),
// //                     ),
// //                   ),
// //                   Expanded(
// //                     child: Text(
// //                       "$shopName စားသောက်ဆိုင်",
// //                       textAlign: TextAlign.center,
// //                       style: const TextStyle(
// //                         color: Colors.white,
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 16,
// //                         letterSpacing: 0.3,
// //                       ),
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
// //                   ),
// //                   const SizedBox(width: 48),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         physics: const BouncingScrollPhysics(),
// //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
// //         child: Column(
// //           children: [
// //             ClipPath(
// //               clipper: ReceiptClipper(),
// //               child: Container(
// //                 width: double.infinity,
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius: const BorderRadius.vertical(
// //                     top: Radius.circular(16),
// //                   ),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.teal.withOpacity(0.08),
// //                       blurRadius: 15,
// //                       offset: const Offset(0, 6),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Column(
// //                   children: [
// //                     Padding(
// //                       padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Center(
// //                             child: Text(
// //                               "အော်ဒါပြေစာ",
// //                               style: TextStyle(
// //                                 fontSize: 22,
// //                                 fontWeight: FontWeight.w900,
// //                                 color: darkTeal,
// //                               ),
// //                             ),
// //                           ),
// //                           const SizedBox(height: 16),
// //                           Row(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Expanded(
// //                                 child: _buildInfoRow("ဝယ်ယူသူ", customerName),
// //                               ),
// //                               const SizedBox(width: 10),
// //                               Expanded(
// //                                 child: _buildInfoRow("ရက်စွဲ", orderDate),
// //                               ),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 8),
// //                           _buildInfoRow("ဖုန်းနံပါတ်", phone),
// //                         ],
// //                       ),
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Padding(
// //                       padding: const EdgeInsets.symmetric(horizontal: 20),
// //                       child: Column(
// //                         children: [
// //                           Container(
// //                             decoration: BoxDecoration(
// //                               color: lightTeal,
// //                               borderRadius: BorderRadius.circular(8),
// //                             ),
// //                             padding: const EdgeInsets.symmetric(
// //                               vertical: 10,
// //                               horizontal: 6,
// //                             ),
// //                             child: Row(
// //                               children: [
// //                                 SizedBox(
// //                                   width: 30,
// //                                   child: Text(
// //                                     "စဉ်",
// //                                     textAlign: TextAlign.center,
// //                                     style: _headerStyle(darkTeal),
// //                                   ),
// //                                 ),
// //                                 Expanded(
// //                                   flex: 3,
// //                                   child: Text(
// //                                     "အမျိုးအမည်",
// //                                     style: _headerStyle(darkTeal),
// //                                   ),
// //                                 ),
// //                                 Expanded(
// //                                   flex: 2,
// //                                   child: Text(
// //                                     "အရေတွက်",
// //                                     textAlign: TextAlign.center,
// //                                     style: _headerStyle(darkTeal),
// //                                   ),
// //                                 ),
// //                                 Expanded(
// //                                   flex: 2,
// //                                   child: Text(
// //                                     "ဈေးနှုန်း",
// //                                     textAlign: TextAlign.right,
// //                                     style: _headerStyle(darkTeal),
// //                                   ),
// //                                 ),
// //                                 Expanded(
// //                                   flex: 2,
// //                                   child: Text(
// //                                     "သင့်ပွိုင့်",
// //                                     textAlign: TextAlign.right,
// //                                     style: _headerStyle(darkTeal),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                           const SizedBox(height: 6),
// //                           ...List.generate(items.length, (index) {
// //                             final itemData = items[index];
// //                             final int qty = itemData['quantity'] ?? 1;
// //                             final int price = itemData['unit_price'] ?? 0;
// //                             final int subtotal = itemData['total_price'] ?? (price * qty);

// //                             return Padding(
// //                               padding: const EdgeInsets.symmetric(
// //                                 vertical: 8,
// //                                 horizontal: 6,
// //                               ),
// //                               child: Row(
// //                                 children: [
// //                                   SizedBox(
// //                                     width: 30,
// //                                     child: Text(
// //                                       "${index + 1}",
// //                                       textAlign: TextAlign.center,
// //                                       style: _cellStyle,
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     flex: 3,
// //                                     child: Text(
// //                                       itemData['name'] ?? '',
// //                                       style: _cellStyle,
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     flex: 2,
// //                                     child: Text(
// //                                       "$qty",
// //                                       textAlign: TextAlign.center,
// //                                       style: _cellStyle,
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     flex: 2,
// //                                     child: Text(
// //                                       "$price",
// //                                       textAlign: TextAlign.right,
// //                                       style: _cellStyle,
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     flex: 2,
// //                                     child: Text(
// //                                       "$subtotal",
// //                                       textAlign: TextAlign.right,
// //                                       style: _cellStyleBold,
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             );
// //                           }),
// //                           const SizedBox(height: 8),
// //                           Container(
// //                             decoration: BoxDecoration(
// //                               color: lightTeal,
// //                               borderRadius: BorderRadius.circular(8),
// //                             ),
// //                             padding: const EdgeInsets.symmetric(
// //                               vertical: 12,
// //                               horizontal: 12,
// //                             ),
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               children: [
// //                                 Text(
// //                                   "စုစုပေါင်းကျသင့်ပွိုင့်",
// //                                   style: TextStyle(
// //                                     fontSize: 13,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: darkTeal,
// //                                   ),
// //                                 ),
// //                                 Text(
// //                                   "$totalAmount ပွိုင့်",
// //                                   style: const TextStyle(
// //                                     fontSize: 15,
// //                                     fontWeight: FontWeight.w900,
// //                                     color: primaryTeal,
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     const SizedBox(height: 28),
// //                     if (canPickup)
// //                       Padding(
// //                         padding: const EdgeInsets.fromLTRB(20, 0, 20, 36),
// //                         child: Center(
// //                           child: Container(
// //                             decoration: BoxDecoration(
// //                               borderRadius: BorderRadius.circular(16),
// //                               boxShadow: [
// //                                 BoxShadow(
// //                                   color: primaryTeal.withOpacity(0.3),
// //                                   blurRadius: 10,
// //                                   offset: const Offset(0, 4),
// //                                 ),
// //                               ],
// //                             ),
// //                             child: Material(
// //                               color: Colors.transparent,
// //                               child: InkWell(
// //                                 // orderId နှင့် code ကို Dialog ထဲသို့ ထည့်သွင်းပေးခြင်း
// //                                 onTap: () => _showPickUpCodeDialog(context, orderId, code),
// //                                 borderRadius: BorderRadius.circular(16),
// //                                 child: Ink(
// //                                   padding: const EdgeInsets.symmetric(
// //                                     horizontal: 24,
// //                                     vertical: 12,
// //                                   ),
// //                                   decoration: BoxDecoration(
// //                                     gradient: LinearGradient(
// //                                       colors: [
// //                                         Colors.teal.shade500,
// //                                         Colors.teal.shade700,
// //                                       ],
// //                                       begin: Alignment.topLeft,
// //                                       end: Alignment.bottomRight,
// //                                     ),
// //                                     borderRadius: BorderRadius.circular(16),
// //                                   ),
// //                                   child: Row(
// //                                     mainAxisSize: MainAxisSize.min,
// //                                     children: const [
// //                                       Icon(
// //                                         Icons.qr_code_scanner_rounded,
// //                                         color: Colors.white,
// //                                         size: 20,
// //                                       ),
// //                                       SizedBox(width: 8),
// //                                       Text(
// //                                         "ပစ္စည်းယူရန် QR ကုဒ်",
// //                                         style: TextStyle(
// //                                           color: Colors.white,
// //                                           fontWeight: FontWeight.bold,
// //                                           fontSize: 14,
// //                                           letterSpacing: 0.3,
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       )
// //                     else
// //                       const SizedBox(height: 24),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildInfoRow(String label, String value) {
// //     return Row(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           "$label : ",
// //           style: TextStyle(
// //             fontSize: 12,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.teal.shade700,
// //           ),
// //         ),
// //         Expanded(
// //           child: Text(
// //             value,
// //             style: TextStyle(
// //               fontSize: 12,
// //               fontWeight: FontWeight.w600,
// //               color: darkTeal,
// //             ),
// //             overflow: TextOverflow.ellipsis,
// //             maxLines: 2,
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   static TextStyle _headerStyle(Color color) =>
// //       TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color);

// //   static const TextStyle _cellStyle = TextStyle(
// //     fontSize: 12,
// //     color: Color(0xFF334155),
// //   );

// //   static const TextStyle _cellStyleBold = TextStyle(
// //     fontSize: 12,
// //     fontWeight: FontWeight.bold,
// //     color: Colors.teal,
// //   );
// // }

// // class ReceiptClipper extends CustomClipper<Path> {
// //   @override
// //   Path getClip(Size size) {
// //     Path path = Path();
// //     path.lineTo(0, size.height - 10);

// //     double x = 0;
// //     double y = size.height - 10;
// //     double increment = 8;

// //     while (x < size.width) {
// //       x += increment;
// //       y = (y == size.height - 10) ? size.height : size.height - 10;
// //       path.lineTo(x, y);
// //     }

// //     path.lineTo(size.width, 0);
// //     path.close();
// //     return path;
// //   }

// //   @override
// //   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// // }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smartcanteen/view/order_screen.dart';
import 'package:smartcanteen/view/pickup_qr_screen.dart';

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailScreen({super.key, required this.order});

  // Teal Theme Color
  static const Color primaryTeal = Color(0xff117992);
  static final Color lightTeal = Colors.teal.shade50;
  static final Color darkTeal = const Color(0xff117992);

  // ရက်စွဲကို Formatted လုပ်ရန်
  String _formatEnglishDateTime(dynamic dateInput) {
    if (dateInput == null) return '';
    if (dateInput is String) {
      final parsedDate = DateTime.tryParse(dateInput);
      if (parsedDate != null) {
        return DateFormat('d/M/yyyy HH:mm:ss').format(parsedDate);
      }
      return dateInput; 
    }
    return '';
  }

  // QR ကုဒ်ပြမည့် Dialog (order_id နှင့် qr_code_token နှစ်ခုစလုံးကို ပေါင်းစပ်ထားသည်)
  void _showPickUpCodeDialog(BuildContext context, dynamic orderId, String qrCodeToken) {
    final String qrData = "$orderId";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "ပစ္စည်းထုတ်ယူရန် QR ကုဒ်",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff117992),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.teal.shade100),
                  ),
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: QrImageView(
                      data: qrData, // order_id နှင့် qr_code_token ပေါင်းစပ်ထားသော ဒေတာ
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor: Colors.white,
                      gapless: true,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "အော်ဒါနံပါတ်: $orderId",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "ကုဒ်: $qrCodeToken",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xff117992),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("ပိတ်မည်"),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // API မှ JSON Key များနှင့် ကိုက်ညီအောင် ပြင်ဆင်ထားခြင်း
    final String shopName = order['shop_name'] ?? 'အန်တီမွန် စားသောက်ဆိုင်';
    final String customerName = order['customer_name'] ?? 'Aung Aung';
    final String orderDate = order['order_time'] ?? '';
    final String phone = order['customer_phone'] ?? '09 790182418';
    final String code = order['qr_code_token'] ?? 'MBK-1000';
    
    // order_id ကို ထည့်သွင်းထုတ်ယူခြင်း
    final dynamic orderId = order['order_id'] ?? order['id'] ?? '';
    
    final List items = order['items'] ?? [];

    // can_pickup ကို order ၏ status သည် 'ready' ဖြစ်မှသာ true ဖြစ်စေရန် စစ်ဆေးခြင်း
    final String status = (order['status'] ?? '').toString().toLowerCase();
    final bool canPickup = status == 'ready';

    // စုစုပေါင်း ကျသင့်ပွိုင့် တွက်ချက်ခြင်း
    int totalAmount = 0;
    for (var itemData in items) {
      final int qty = itemData['quantity'] ?? 1;
      final int price = itemData['unit_price'] ?? 0;
      totalAmount += price * qty;
    }

    return Scaffold(
      backgroundColor: lightTeal,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90), // AppBar အမြင့်ကို အနည်းငယ် တိုးထားပါသည်[cite: 14]
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 8), // အပေါ်မှ အနည်းငယ် ခွာပေးထားသည်[cite: 14]
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryTeal, primaryTeal.withOpacity(0.85)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: primaryTeal.withOpacity(0.35),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "$shopName စားသောက်ဆိုင်",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.3,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        // အောက်ဘက် Content တစ်ခုလုံးကို အနည်းငယ် အောက်သို့ ရွှေ့ရန် top padding ကို တိုးမြှင့်ထားပါသည်[cite: 14]
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: Column(
          children: [
            ClipPath(
              clipper: ReceiptClipper(),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "အော်ဒါပြေစာ",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: darkTeal,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _buildInfoRow("ဝယ်ယူသူ", customerName),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildInfoRow("ရက်စွဲ", orderDate),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow("ဖုန်းနံပါတ်", phone),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: lightTeal,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 6,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                  child: Text(
                                    "စဉ်",
                                    textAlign: TextAlign.center,
                                    style: _headerStyle(darkTeal),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "အမျိုးအမည်",
                                    style: _headerStyle(darkTeal),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "အရေတွက်",
                                    textAlign: TextAlign.center,
                                    style: _headerStyle(darkTeal),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "ဈေးနှုန်း",
                                    textAlign: TextAlign.right,
                                    style: _headerStyle(darkTeal),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "သင့်ပွိုင့်",
                                    textAlign: TextAlign.right,
                                    style: _headerStyle(darkTeal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          ...List.generate(items.length, (index) {
                            final itemData = items[index];
                            final int qty = itemData['quantity'] ?? 1;
                            final int price = itemData['unit_price'] ?? 0;
                            final int subtotal = itemData['total_price'] ?? (price * qty);

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 6,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                    child: Text(
                                      "${index + 1}",
                                      textAlign: TextAlign.center,
                                      style: _cellStyle,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      itemData['name'] ?? '',
                                      style: _cellStyle,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "$qty",
                                      textAlign: TextAlign.center,
                                      style: _cellStyle,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "$price",
                                      textAlign: TextAlign.right,
                                      style: _cellStyle,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "$subtotal",
                                      textAlign: TextAlign.right,
                                      style: _cellStyleBold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: lightTeal,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 12,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "စုစုပေါင်းကျသင့်ပွိုင့်",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: darkTeal,
                                  ),
                                ),
                                Text(
                                  "$totalAmount ပွိုင့်",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: primaryTeal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    if (canPickup)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 36),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryTeal.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => _showPickUpCodeDialog(context, orderId, code),
                                borderRadius: BorderRadius.circular(16),
                                child: Ink(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.teal.shade500,
                                        Colors.teal.shade700,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(
                                        Icons.qr_code_scanner_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "ပစ္စည်းယူရန် QR ကုဒ်",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label : ",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade700,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: darkTeal,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  static TextStyle _headerStyle(Color color) =>
      TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color);

  static const TextStyle _cellStyle = TextStyle(
    fontSize: 12,
    color: Color(0xFF334155),
  );

  static const TextStyle _cellStyleBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.teal,
  );
}

class ReceiptClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 10);

    double x = 0;
    double y = size.height - 10;
    double increment = 8;

    while (x < size.width) {
      x += increment;
      y = (y == size.height - 10) ? size.height : size.height - 10;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}