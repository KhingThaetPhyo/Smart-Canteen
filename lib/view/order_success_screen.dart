
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// class OrderSuccessScreen extends StatefulWidget {
//   final String shopName;
//   final String orderType;
//   final String? selectedSeatId;
//   final List<Map<String, dynamic>> cartItems;
//   final int totalPoints;
//   final String note;
//   final String orderId;
//   final String qrCodeToken;
//   final String orderStatus;

//   const OrderSuccessScreen({
//     super.key,
//     required this.shopName,
//     required this.orderType,
//     required this.selectedSeatId,
//     required this.cartItems,
//     required this.totalPoints,
//     required this.orderId,
//     required this.qrCodeToken,
//     this.orderStatus = 'paid',
//     this.note = '',
//   });

//   @override
//   State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
// }

// class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
//   static const Color primaryColor = Color(0xff117992);

//   // State variable to toggle QR visibility
//   bool _isQrExpanded = false;

//   bool get isDineIn => widget.orderType == 'dine-in';

//   String get orderReference =>
//       widget.orderId.isNotEmpty ? 'ORD-${widget.orderId}' : 'ORD-SUCCESS';

//   String get orderQrData =>
//       widget.qrCodeToken.isNotEmpty ? widget.qrCodeToken : orderReference;

//   int _parsePrice(String value) {
//     final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
//     return int.tryParse(digits) ?? 0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF6F8FC),
//       body: Column(
//         children: [
//           _buildHeader(context),
//           Expanded(
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 20,),
//                   _buildSuccessHero(),
//                   const SizedBox(height: 22),
//                   _buildPreparationCard(),
//                   const SizedBox(height: 14),
//                   _buildOrderDetailsCard(),
//                   const SizedBox(height: 14),
//                   _buildFulfilmentCard(),
//                   const SizedBox(height: 14),
//                   _buildOrderQrCard(),
//                   const SizedBox(height: 24),
//                   _buildActionButtons(context),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xff117992), Color(0xff0D5B6E)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       // child: SafeArea(
//       //   bottom: false,
//       //   child: Padding(
//       //     padding: const EdgeInsets.fromLTRB(16, 44, 16, 14),
//       //     child: Stack(
//       //       alignment: Alignment.center,
//       //       children: [
//       //         Align(
//       //           alignment: Alignment.centerLeft,
//       //           child: Container(
//       //             width: 40,
//       //             height: 40,
//       //             decoration: BoxDecoration(
//       //               color: Colors.white.withOpacity(0.15),
//       //               shape: BoxShape.circle,
//       //             ),
//       //             child: IconButton(
//       //               padding: EdgeInsets.zero,
//       //               icon: const Icon(
//       //                 Icons.arrow_back_ios_new_rounded,
//       //                 color: Colors.white,
//       //                 size: 16,
//       //               ),
//       //               onPressed: () => Navigator.pop(context),
//       //             ),
//       //           ),
//       //         ),
//       //         const Padding(
//       //           padding: EdgeInsets.symmetric(horizontal: 52),
//       //           child: Text(
//       //             'အော်ဒါ အောင်မြင်ပါသည်',
//       //             textAlign: TextAlign.center,
//       //             maxLines: 1,
//       //             overflow: TextOverflow.ellipsis,
//       //             style: TextStyle(
//       //               color: Colors.white,
//       //               fontSize: 19,
//       //               fontWeight: FontWeight.bold,
//       //             ),
//       //           ),
//       //         ),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//     );
//   }

//   Widget _buildSuccessHero() {
//     return Column(
//       children: [
//         Container(
//           width: 82,
//           height: 82,
//           decoration: BoxDecoration(
//             color: primaryColor.withOpacity(0.1),
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: primaryColor.withOpacity(0.18),
//               width: 1.5,
//             ),
//           ),
//           child: const Icon(
//             Icons.check_circle_rounded,
//             color: primaryColor,
//             size: 52,
//           ),
//         ),
//         const SizedBox(height: 14),
//         const Text(
//           'အော်ဒါ အတည်ပြုပြီးပါပြီ!',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.w900,
//             color: Color(0xff1E293B),
//           ),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           '${widget.shopName} ဆိုင်မှ သင့်အော်ဒါကို လက်ခံရရှိပါပြီ။',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 13,
//             color: Colors.grey.shade600,
//             height: 1.4,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPreparationCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: _cardDecoration(),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: primaryColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Icon(
//               Icons.access_time_rounded,
//               color: primaryColor,
//               size: 24,
//             ),
//           ),
//           const SizedBox(width: 14),
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'ခန့်မှန်း ပြင်ဆင်ချိန်',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Color(0xff64748B),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(height: 2),
//                 Text(
//                   '15-20 မိနစ်',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w900,
//                     color: Color(0xff1E293B),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
//             decoration: BoxDecoration(
//               color: const Color(0xffFEF3C7),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(
//               widget.orderStatus == 'paid' ? 'ပေးချေပြီး' : 'ပြင်ဆင်နေသည်',
//               style: const TextStyle(
//                 color: Color(0xffD97706),
//                 fontSize: 10,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOrderDetailsCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: _cardDecoration(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'အော်ဒါ အသေးစိတ်',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 15,
//                   color: Color(0xff1E293B),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 5,
//                 ),
//                 decoration: BoxDecoration(
//                   color: const Color(0xffF1F5F9),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   '#$orderReference',
//                   style: const TextStyle(
//                     fontSize: 11,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xff64748B),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 14),
//           Divider(height: 1, color: Colors.grey.shade200),
//           const SizedBox(height: 14),
//           ListView.separated(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: widget.cartItems.length,
//             separatorBuilder: (_, __) => const SizedBox(height: 13),
//             itemBuilder: (context, index) {
//               final item = widget.cartItems[index];
//               final int quantity =
//                   item['cartQuantity'] ?? item['quantity'] ?? 1;
//               final int itemTotal =
//                   _parsePrice(item['price'].toString()) * quantity;

//               return Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                       vertical: 4,
//                     ),
//                     decoration: BoxDecoration(
//                       color: primaryColor.withOpacity(0.08),
//                       borderRadius: BorderRadius.circular(7),
//                     ),
//                     child: Text(
//                       'x$quantity',
//                       style: const TextStyle(
//                         color: primaryColor,
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Text(
//                       item['name'].toString(),
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 13,
//                         color: Color(0xff1E293B),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Text(
//                     '${NumberFormat('#,###').format(itemTotal)} ပွိုင့်',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 13,
//                       color: Color(0xff1E293B),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//           if (widget.note.trim().isNotEmpty) ...[
//             const SizedBox(height: 14),
//             Divider(height: 1, color: Colors.grey.shade200),
//             const SizedBox(height: 14),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Icon(
//                   Icons.edit_note_rounded,
//                   size: 19,
//                   color: Colors.grey.shade600,
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'မှတ်ချက်',
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: Colors.grey.shade500,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 3),
//                       Text(
//                         widget.note.trim(),
//                         style: const TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xff1E293B),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//           const SizedBox(height: 14),
//           Divider(height: 1, color: Colors.grey.shade200),
//           const SizedBox(height: 14),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'ပေးချေပြီး ပွိုင့်',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 13,
//                   color: Color(0xff1E293B),
//                 ),
//               ),
//               Text(
//                 '${NumberFormat('#,###').format(widget.totalPoints)} ပွိုင့်',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w900,
//                   fontSize: 18,
//                   color: primaryColor,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFulfilmentCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: _cardDecoration(),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(9),
//             decoration: BoxDecoration(
//               color: primaryColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(11),
//             ),
//             child: Icon(
//               isDineIn ? Icons.event_seat_rounded : Icons.shopping_bag_rounded,
//               color: primaryColor,
//               size: 21,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   isDineIn ? 'ထိုင်စားမည့်နေရာ' : 'ထုပ်ယူမည့်နေရာ',
//                   style: TextStyle(
//                     fontSize: 11,
//                     color: Colors.grey.shade500,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   widget.shopName,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                     color: Color(0xff1E293B),
//                   ),
//                 ),
//                 const SizedBox(height: 7),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 9,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: primaryColor.withOpacity(0.09),
//                     borderRadius: BorderRadius.circular(7),
//                   ),
//                   child: Text(
//                     isDineIn
//                         ? (widget.selectedSeatId ?? 'စားပွဲ မသတ်မှတ်ရသေးပါ')
//                         : 'ပါဆယ်',
//                     style: const TextStyle(
//                       color: primaryColor,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 11,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOrderQrCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: _cardDecoration(),
//       child: Column(
//         children: [
//           // Header Row with InkWell to toggle dropdown state
//           InkWell(
//             onTap: () {
//               setState(() {
//                 _isQrExpanded = !_isQrExpanded;
//               });
//             },
//             borderRadius: BorderRadius.circular(8),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(9),
//                   decoration: BoxDecoration(
//                     color: primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(11),
//                   ),
//                   child: const Icon(
//                     Icons.qr_code_2_rounded,
//                     color: primaryColor,
//                     size: 23,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         isDineIn ? 'ထိုင်စားရန် QR' : 'ပါဆယ်ထုတ်ယူရန် QR',
//                         style: const TextStyle(
//                           color: Color(0xff1E293B),
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         isDineIn
//                             ? 'စားပွဲအော်ဒါ အတည်ပြုရန် Scan ဖတ်ပါ'
//                             : 'အစားအစာ ထုတ်ယူရန် Scan ဖတ်ပါ',
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                           fontSize: 11,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Dropdown icon at the right side
//                 Icon(
//                   _isQrExpanded
//                       ? Icons.keyboard_arrow_up_rounded
//                       : Icons.keyboard_arrow_down_rounded,
//                   color: const Color(0xff64748B),
//                   size: 26,
//                 ),
//               ],
//             ),
//           ),
//           // Conditionally display the QR code content below when expanded
//           if (_isQrExpanded) ...[
//             const SizedBox(height: 16),
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: Colors.grey.shade200),
//               ),
//               child: QrImageView(
//                 data: orderQrData,
//                 version: QrVersions.auto,
//                 size: 170,
//                 backgroundColor: Colors.white,
//                 eyeStyle: const QrEyeStyle(
//                   eyeShape: QrEyeShape.square,
//                   color: Color(0xff117992),
//                 ),
//                 dataModuleStyle: const QrDataModuleStyle(
//                   dataModuleShape: QrDataModuleShape.square,
//                   color: Color(0xff0F172A),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               orderQrData,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: primaryColor,
//                 fontSize: 13,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 0.5,
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               isDineIn
//                   ? 'ဆိုင်ဝန်ထမ်းအား QR ကိုပြပြီး ရွေးထားသောစားပွဲအတွက် အော်ဒါကို အတည်ပြုပါ။'
//                   : 'အစားအစာအသင့်ဖြစ်သောအခါ ဆိုင်ကောင်တာတွင် QR ကိုပြပါ။',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//                 fontSize: 11,
//                 height: 1.4,
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButtons(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           width: double.infinity,
//           height: 50,
//           child: ElevatedButton.icon(
//             onPressed: () {
//               Navigator.of(context).popUntil((route) => route.isFirst);
//             },
//             icon: const Icon(
//               Icons.track_changes_rounded,
//               color: Colors.white,
//               size: 18,
//             ),
//             label: const Text(
//               'အော်ဒါ ခြေရာခံမည်',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//               ),
//             ),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: primaryColor,
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           width: double.infinity,
//           height: 50,
//           child: OutlinedButton.icon(
//             onPressed: () =>
//                 Navigator.of(context).popUntil((route) => route.isFirst),
//             icon: Icon(
//               Icons.home_outlined,
//               color: Colors.grey.shade700,
//               size: 18,
//             ),
//             label: Text(
//               'ပင်မသို့ ပြန်သွားမည်',
//               style: TextStyle(
//                 color: Colors.grey.shade700,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//               ),
//             ),
//             style: OutlinedButton.styleFrom(
//               side: BorderSide(color: Colors.grey.shade300),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   BoxDecoration _cardDecoration() {
//     return BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(16),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.035),
//           blurRadius: 12,
//           offset: const Offset(0, 3),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smartcanteen/provider/user_provider.dart';
// Import your UserProvider file here
// import 'path/to/user_provider.dart';

class OrderSuccessScreen extends StatefulWidget {
  final String shopName;
  final String orderType;
  final String? selectedSeatId;
  final List<Map<String, dynamic>> cartItems;
  final int totalPoints;
  final String note;
  final String orderId;
  final String qrCodeToken;
  final String orderStatus;

  const OrderSuccessScreen({
    super.key,
    required this.shopName,
    required this.orderType,
    required this.selectedSeatId,
    required this.cartItems,
    required this.totalPoints,
    required this.orderId,
    required this.qrCodeToken,
    this.orderStatus = 'paid',
    this.note = '',
  });

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  static const Color primaryColor = Color(0xff117992);

  bool _isQrExpanded = false;

  bool get isDineIn => widget.orderType == 'dine-in';

  String get orderReference =>
      widget.orderId.isNotEmpty ? 'ORD-${widget.orderId}' : '';

  String get orderQrData =>
      widget.qrCodeToken.isNotEmpty ? widget.qrCodeToken : orderReference;

  @override
  void initState() {
    super.initState();
    // Deduct points from Provider right after screen renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<UserProvider>().deductPoints(widget.totalPoints);
      }
    });
  }

  int _parsePrice(String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(digits) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildSuccessHero(),
                    const SizedBox(height: 22),
                    _buildPreparationCard(),
                    const SizedBox(height: 14),
                    _buildOrderDetailsCard(),
                    const SizedBox(height: 14),
                    _buildFulfilmentCard(),
                    const SizedBox(height: 14),
                    _buildOrderQrCard(),
                    const SizedBox(height: 24),
                    _buildActionButtons(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff117992), Color(0xff0D5B6E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const SafeArea(
        bottom: false,
        child: SizedBox(height: 50),
      ),
    );
  }

  Widget _buildSuccessHero() {
    return Column(
      children: [
        Container(
          width: 82,
          height: 82,
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: primaryColor.withOpacity(0.18),
              width: 1.5,
            ),
          ),
          child: const Icon(
            Icons.check_circle_rounded,
            color: primaryColor,
            size: 52,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'အော်ဒါ အတည်ပြုပြီးပါပြီ!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Color(0xff1E293B),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '${widget.shopName} ဆိုင်မှ သင့်အော်ဒါကို လက်ခံရရှိပါပြီ။',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildPreparationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.access_time_rounded,
              color: primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ခန့်မှန်း ပြင်ဆင်ချိန်',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '15-20 မိနစ်',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff1E293B),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xffFEF3C7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.orderStatus == 'paid' ? 'ပေးချေပြီး' : 'ပြင်ဆင်နေသည်',
              style: const TextStyle(
                color: Color(0xffD97706),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetailsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'အော်ဒါ အသေးစိတ်',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xff1E293B),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '#$orderReference',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff64748B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Divider(height: 1, color: Colors.grey.shade200),
          const SizedBox(height: 14),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.cartItems.length,
            separatorBuilder: (_, __) => const SizedBox(height: 13),
            itemBuilder: (context, index) {
              final item = widget.cartItems[index];
              final int quantity =
                  item['cartQuantity'] ?? item['quantity'] ?? 1;
              final int itemTotal =
                  _parsePrice(item['price'].toString()) * quantity;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      'x$quantity',
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item['name'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Color(0xff1E293B),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${NumberFormat('#,###').format(itemTotal)} ပွိုင့်',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: Color(0xff1E293B),
                    ),
                  ),
                ],
              );
            },
          ),
          if (widget.note.trim().isNotEmpty) ...[
            const SizedBox(height: 14),
            Divider(height: 1, color: Colors.grey.shade200),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.edit_note_rounded,
                  size: 19,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'မှတ်ချက်',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        widget.note.trim(),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff1E293B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 14),
          Divider(height: 1, color: Colors.grey.shade200),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ပေးချေပြီး ပွိုင့်',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xff1E293B),
                ),
              ),
              Text(
                '${NumberFormat('#,###').format(widget.totalPoints)} ပွိုင့်',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFulfilmentCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              isDineIn ? Icons.event_seat_rounded : Icons.shopping_bag_rounded,
              color: primaryColor,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isDineIn ? 'ထိုင်စားမည့်နေရာ' : 'ထုပ်ယူမည့်နေရာ',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.shopName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xff1E293B),
                  ),
                ),
                const SizedBox(height: 7),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    isDineIn
                        ? (widget.selectedSeatId ?? 'စားပွဲ မသတ်မှတ်ရသေးပါ')
                        : 'ပါဆယ်',
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderQrCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isQrExpanded = !_isQrExpanded;
              });
            },
            borderRadius: BorderRadius.circular(8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: const Icon(
                    Icons.qr_code_2_rounded,
                    color: primaryColor,
                    size: 23,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isDineIn ? 'ထိုင်စားရန် QR' : 'ပါဆယ်ထုတ်ယူရန် QR',
                        style: const TextStyle(
                          color: Color(0xff1E293B),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isDineIn
                            ? 'စားပွဲအော်ဒါ အတည်ပြုရန် Scan ဖတ်ပါ'
                            : 'အစားအစာ ထုတ်ယူရန် Scan ဖတ်ပါ',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  _isQrExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: const Color(0xff64748B),
                  size: 26,
                ),
              ],
            ),
          ),
          if (_isQrExpanded) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: QrImageView(
                data: orderQrData,
                version: QrVersions.auto,
                size: 170,
                backgroundColor: Colors.white,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: Color(0xff117992),
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: Color(0xff0F172A),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              orderQrData,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              isDineIn
                  ? 'ဆိုင်ဝန်ထမ်းအား QR ကိုပြပြီး ရွေးထားသောစားပွဲအတွက် အော်ဒါကို အတည်ပြုပါ။'
                  : 'အစားအစာအသင့်ဖြစ်သောအခါ ဆိုင်ကောင်တာတွင် QR ကိုပြပါ။',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 11,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            icon: const Icon(
              Icons.track_changes_rounded,
              color: Colors.white,
              size: 18,
            ),
            label: const Text(
              'အော်ဒါ ခြေရာခံမည်',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            onPressed: () =>
                context.go('/navigation'),
            icon: Icon(
              Icons.home_outlined,
              color: Colors.grey.shade700,
              size: 18,
            ),
            label: Text(
              'ပင်မသို့ ပြန်သွားမည်',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.035),
          blurRadius: 12,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}