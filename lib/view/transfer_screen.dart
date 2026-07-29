// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:smartcanteen/service/shared_preferences_service.dart';

// class TransferScreen extends StatefulWidget {
  
//   final int currentBalance;
//   final Function(int amount, String recipient) onTransferCompleted;

//   /// Values supplied by checkout. When [readOnlyTransfer] is true, the user
//   /// can review these values but cannot change the shop or the order total.
//   final String? initialRecipient;
//   final int? initialAmount;
//   final bool readOnlyTransfer;

//   const TransferScreen({
//     super.key,
//     required this.currentBalance,
//     required this.onTransferCompleted,
//     this.initialRecipient,
//     this.initialAmount,
//     this.readOnlyTransfer = false,
//   });

//   @override
//   State<TransferScreen> createState() => _TransferScreenState();
// }

// class _TransferScreenState extends State<TransferScreen> {
//   static const Color primaryColor = Color(0xff117992);

//   final TextEditingController _recipientController = TextEditingController();
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _pinController = TextEditingController();
//   final List<int> _presetAmounts = [100, 500, 1000, 5000];

//   bool _isPinModalOpen = false;

//   @override
//   void initState() {
//     super.initState();
//     _recipientController.text = widget.initialRecipient ?? '';
//     if (widget.initialAmount != null) {
//       _amountController.text = widget.initialAmount.toString();
//     }
//     // Execute after the widget has finished building
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     if (widget.readOnlyTransfer) {
//       _handleTransfer();
//     }
//   });
//   }

//   @override
//   void dispose() {
//     _recipientController.dispose();
//     _amountController.dispose();
//     _pinController.dispose();
//     super.dispose();
//   }

//   int? get _amount =>
//       int.tryParse(_amountController.text.replaceAll(',', '').trim());

//   String get _recipient => _recipientController.text.trim();

//   void _handleTransfer() {
//     final amount = _amount;
//     final recipient = _recipient;

//     if (amount == null || amount <= 0 || recipient.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter valid transfer details.')),
//       );
//       return;
//     }

//     if (amount > widget.currentBalance) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Insufficient points balance!')),
//       );
//       return;
//     }
//     else
//     _showPinBottomSheet(amount, recipient);
//   }

//   /// Opens a compact 6-digit PIN dialog using the phone's numeric keyboard.
//   Future<void> _showPinBottomSheet(int amount, String recipient) async {
//     _pinController.clear();
//     final pinFocusNode = FocusNode();
//     if (mounted) setState(() => _isPinModalOpen = true);

//     final confirmed = await showDialog<bool>(
//       context: context,
//       barrierDismissible: false,
//       barrierColor: Colors.black.withOpacity(0.55),
//       builder: (dialogContext) {
//         return StatefulBuilder(
//           builder: (context, setDialogState) {
//             final enteredDigits = _pinController.text.length;
//             final isPinComplete = enteredDigits == 6;
//             return PopScope(
//               canPop: false,
//               child: MediaQuery.removeViewInsets(
//                 context: context,
//                 removeBottom: true,
//                 child: Dialog(
//                   alignment: Alignment.center,
//                   insetPadding: const EdgeInsets.symmetric(horizontal: 22),
//                   backgroundColor: Colors.transparent,
//                   elevation: 0,
//                   child: Container(
//                     width: double.infinity,
//                     constraints: const BoxConstraints(maxWidth: 370),
//                     padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(24),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Color(0x3D000000),
//                           blurRadius: 28,
//                           offset: Offset(0, 12),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                               width: 42,
//                               height: 42,
//                               decoration: BoxDecoration(
//                                 color: primaryColor.withOpacity(0.1),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: const Icon(
//                                 Icons.lock_rounded,
//                                 color: primaryColor,
//                                 size: 21,
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             const Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'PIN ထည့်ပါ',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w800,
//                                       color: Color(0xff0F172A),
//                                     ),
//                                   ),
//                                   SizedBox(height: 2),
//                                   Text(
//                                     'PIN ၆ လုံးဖြင့် ငွေလွှဲမှုကို အတည်ပြုပါ',
//                                     style: TextStyle(
//                                       fontSize: 11,
//                                       color: Color(0xff64748B),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Material(
//                               color: const Color(0xffF1F5F9),
//                               shape: const CircleBorder(),
//                               child: InkWell(
//                                 customBorder: const CircleBorder(),
//                                 onTap: () =>
//                                     Navigator.pop(dialogContext, false),
//                                 child: const SizedBox(
//                                   width: 34,
//                                   height: 34,
//                                   child: Icon(
//                                     Icons.close_rounded,
//                                     size: 18,
//                                     color: Color(0xff64748B),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 14),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 6,
//                           ),
//                           decoration: BoxDecoration(
//                             color: primaryColor.withOpacity(0.08),
//                             borderRadius: BorderRadius.circular(9),
//                           ),
//                           child: Text(
//                             "${NumberFormat('#,###').format(amount)} ပွိုင့်",
//                             style: const TextStyle(
//                               color: primaryColor,
//                               fontSize: 13,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 18),
//                         SizedBox(
//                           width: 1,
//                           height: 1,
//                           child: TextField(
//                             controller: _pinController,
//                             focusNode: pinFocusNode,
//                             autofocus: true,
//                             maxLength: 6,
//                             keyboardType: TextInputType.number,
//                             textInputAction: TextInputAction.done,
//                             inputFormatters: [
//                               FilteringTextInputFormatter.digitsOnly,
//                               LengthLimitingTextInputFormatter(6),
//                             ],
//                             style: const TextStyle(color: Colors.transparent),
//                             cursorColor: Colors.transparent,
//                             decoration: const InputDecoration(
//                               counterText: '',
//                               border: InputBorder.none,
//                               enabledBorder: InputBorder.none,
//                               focusedBorder: InputBorder.none,
//                             ),
//                             onChanged: (_) => setDialogState(() {}),
//                             onSubmitted: (_) {
//                               if (_pinController.text.length == 6) {
//                                 Navigator.pop(dialogContext, true);
//                               }
//                             },
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () => pinFocusNode.requestFocus(),
//                           behavior: HitTestBehavior.opaque,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: List.generate(
//                               6,
//                               (index) => _buildPinBox(
//                                 index,
//                                 isActive:
//                                     index == enteredDigits && enteredDigits < 6,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           '$enteredDigits / 6',
//                           style: TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w600,
//                             color: isPinComplete
//                                 ? primaryColor
//                                 : Colors.grey.shade500,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         SizedBox(
//                           width: double.infinity,
//                           height: 48,
//                           child: ElevatedButton(
//                             onPressed: isPinComplete
//                                 ? () => Navigator.pop(dialogContext, true)
//                                 : null,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: primaryColor,
//                               disabledBackgroundColor: const Color(0xffE2E8F0),
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(14),
//                               ),
//                             ),
//                             child: Text(
//                               'ငွေလွှဲမှု အတည်ပြုမည်',
//                               style: TextStyle(
//                                 color: isPinComplete
//                                     ? Colors.white
//                                     : const Color(0xff94A3B8),
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );

//     pinFocusNode.dispose();
//     if (mounted) setState(() => _isPinModalOpen = false);
//     if (confirmed == true && mounted) {
//       _completeTransfer(amount, recipient);
//     }
//   }

//   Widget _buildPinBox(int index, {required bool isActive}) {
//     final isFilled = index < _pinController.text.length;
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 150),
//       width: 39,
//       height: 48,
//       margin: const EdgeInsets.symmetric(horizontal: 3),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: isFilled
//             ? primaryColor.withOpacity(0.08)
//             : const Color(0xffF8FAFC),
//         borderRadius: BorderRadius.circular(11),
//         border: Border.all(
//           color: isFilled || isActive ? primaryColor : const Color(0xffCBD5E1),
//           width: isActive ? 2 : 1.3,
//         ),
//         boxShadow: isActive
//             ? [
//                 BoxShadow(
//                   color: primaryColor.withOpacity(0.14),
//                   blurRadius: 8,
//                   offset: const Offset(0, 3),
//                 ),
//               ]
//             : null,
//       ),
//       child: isFilled
//           ? const Text(
//               '•',
//               style: TextStyle(
//                 color: primaryColor,
//                 fontSize: 25,
//                 height: 1,
//                 fontWeight: FontWeight.bold,
//               ),
//             )
//           : null,
//     );
//   }

//   void _completeTransfer(int amount, String recipient) {
//     // Close TransferScreen before notifying checkout. The callback can then
//     // safely open OrderSuccessScreen using the parent navigator.
//     Navigator.pop(context);
//     widget.onTransferCompleted(amount, recipient);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final locked = widget.readOnlyTransfer;

//     return Scaffold(
//       backgroundColor: const Color(0xff0D6B80),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               margin: const EdgeInsets.fromLTRB(16, 44, 16, 8),
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.15),
//                 borderRadius: BorderRadius.circular(22),
//                 border: Border.all(color: Colors.white.withOpacity(0.2)),
//               ),
//               child: Row(
//                 children: [
//                   Material(
//                     color: Colors.white.withOpacity(0.18),
//                     shape: const CircleBorder(),
//                     child: IconButton(
//                       icon: const Icon(
//                         Icons.arrow_back_ios_new_rounded,
//                         color: Colors.white,
//                         size: 17,
//                       ),
//                       onPressed: _isPinModalOpen
//                           ? null
//                           : () => Navigator.pop(context),
//                     ),
//                   ),
//                   const Expanded(
//                     child: Text(
//                       'ပွိုင့် လွှဲမည်',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 48),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 12),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'လက်ကျန် ပွိုင့်',
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.72),
//                           fontSize: 13,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         '${NumberFormat('#,###').format(widget.currentBalance)} ပွိုင့်',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 27,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.15),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.account_balance_wallet_rounded,
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
//                 decoration: const BoxDecoration(
//                   color: Color(0xffF4F6F9),
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
//                 ),
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const Text(
//                         'လက်ခံမည့်ဆိုင်',
//                         style: TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff64748B),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       TextField(
//                         controller: _recipientController,
//                         readOnly: locked,
//                         decoration: _inputDecoration(
//                           hint: 'Shop name or ID',
//                           icon: Icons.storefront_rounded,
//                           locked: locked,
//                         ),
//                       ),
//                       const SizedBox(height: 24),
//                       const Text(
//                         'လွှဲမည့်ပွိုင့်',
//                         style: TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff64748B),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Container(
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(22),
//                           border: Border.all(
//                             color: primaryColor.withOpacity(0.12),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   locked
//                                       ? 'အော်ဒါအတွက် ပေးချေရမည့်ပွိုင့်'
//                                       : 'ပွိုင့်ထည့်ပါ',
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color(0xff64748B),
//                                   ),
//                                 ),
//                                 if (locked)
//                                   const Icon(
//                                     Icons.lock_rounded,
//                                     size: 17,
//                                     color: primaryColor,
//                                   ),
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             TextField(
//                               controller: _amountController,
//                               readOnly: locked,
//                               keyboardType: TextInputType.number,
//                               inputFormatters: [
//                                 FilteringTextInputFormatter.digitsOnly,
//                               ],
//                               style: const TextStyle(
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xff0F172A),
//                               ),
//                               decoration: const InputDecoration(
//                                 hintText: '0',
//                                 suffixText: 'ပွိုင့်',
//                                 suffixStyle: TextStyle(
//                                   color: primaryColor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 13,
//                                 ),
//                                 border: InputBorder.none,
//                                 contentPadding: EdgeInsets.zero,
//                               ),
//                             ),
//                             if (!locked) ...[
//                               const Divider(height: 28),
//                               Row(
//                                 children: _presetAmounts.map((preset) {
//                                   return Expanded(
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 3,
//                                       ),
//                                       child: InkWell(
//                                         onTap: () => setState(() {
//                                           _amountController.text = preset
//                                               .toString();
//                                         }),
//                                         borderRadius: BorderRadius.circular(10),
//                                         child: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                             vertical: 8,
//                                           ),
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                             color: const Color(0xffF8FAFC),
//                                             borderRadius: BorderRadius.circular(
//                                               10,
//                                             ),
//                                             border: Border.all(
//                                               color: Colors.grey.shade200,
//                                             ),
//                                           ),
//                                           child: Text(
//                                             '+${NumberFormat.compact().format(preset)}',
//                                             style: const TextStyle(
//                                               fontSize: 11,
//                                               fontWeight: FontWeight.bold,
//                                               color: Color(0xff475569),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                       if (locked) ...[
//                         const SizedBox(height: 12),
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: const Color(0xffEAF7F9),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Row(
//                             children: [
//                               Icon(
//                                 Icons.verified_user_outlined,
//                                 color: primaryColor,
//                                 size: 18,
//                               ),
//                               SizedBox(width: 8),
//                               Expanded(
//                                 child: Text(
//                                   'ဆိုင်နှင့် ပေးချေရမည့်ပွိုင့်ကို အော်ဒါအတိုင်း သတ်မှတ်ထား၍ ပြင်ဆင်၍မရပါ။',
//                                   style: TextStyle(
//                                     fontSize: 11,
//                                     color: primaryColor,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                       const SizedBox(height: 30),
//                       SizedBox(
//                         height: 54,
//                         child: ElevatedButton(
//                           onPressed: _handleTransfer,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: primaryColor,
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                           ),
//                           child: Text(
//                             locked ? 'ပေးချေမည်' : 'ငွေလွှဲမည်',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   InputDecoration _inputDecoration({
//     required String hint,
//     required IconData icon,
//     required bool locked,
//   }) {
//     return InputDecoration(
//       hintText: hint,
//       prefixIcon: Icon(icon, color: primaryColor, size: 20),
//       suffixIcon: locked
//           ? const Icon(Icons.lock_rounded, color: primaryColor, size: 18)
//           : null,
//       filled: true,
//       fillColor: locked ? const Color(0xffF8FAFC) : Colors.white,
//       contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide(color: Colors.grey.shade200),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide(color: Colors.grey.shade200),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: const BorderSide(color: primaryColor, width: 1.5),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:smartcanteen/view/order_success_screen.dart';


// class TransferScreen extends StatefulWidget {
//   final int currentBalance;
//   final Function(int amount, String recipient)? onTransferCompleted;

//   /// Values supplied by checkout. When [readOnlyTransfer] is true, the user
//   /// can review these values but cannot change the shop or the order total.
//   final String? initialRecipient;
//   final int? initialAmount;
//   final bool readOnlyTransfer;

//   /// Optional parameters passed forward to OrderSuccessScreen
//   final String orderType;
//   final String? selectedSeatId;
//   final List<Map<String, dynamic>> cartItems;
//   final String note;

//   const TransferScreen({
//     super.key,
//     required this.currentBalance,
//     this.onTransferCompleted,
//     this.initialRecipient,
//     this.initialAmount,
//     this.readOnlyTransfer = false,
//     this.orderType = 'dine-in',
//     this.selectedSeatId,
//     this.cartItems = const [],
//     this.note = '',
//   });

//   @override
//   State<TransferScreen> createState() => _TransferScreenState();
// }

// class _TransferScreenState extends State<TransferScreen> {
//   static const Color primaryColor = Color(0xff117992);

//   late final TextEditingController _recipientController;
//   late final TextEditingController _amountController;
//   final TextEditingController _pinController = TextEditingController();
//   final List<int> _presetAmounts = [100, 500, 1000, 5000];

//   bool _isPinModalOpen = false;

//   @override
//   void initState() {
//     super.initState();
//     _recipientController = TextEditingController(
//       text: widget.initialRecipient ?? '',
//     );
//     _amountController = TextEditingController(
//       text: widget.initialAmount != null ? widget.initialAmount.toString() : '',
//     );

//     // Initial check: if currentBalance < initialAmount on load, show Insufficient Dialog
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final amount = _amount;
//       if (amount != null && widget.currentBalance < amount) {
//         _showInsufficientBalanceDialog(amount);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _recipientController.dispose();
//     _amountController.dispose();
//     _pinController.dispose();
//     super.dispose();
//   }

//   int? get _amount =>
//       int.tryParse(_amountController.text.replaceAll(',', '').trim());

//   String get _recipient => _recipientController.text.trim();

//   void _handleTransfer() {
//     final amount = _amount;
//     final recipient = _recipient;

//     if (amount == null || amount <= 0 || recipient.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter valid transfer details.')),
//       );
//       return;
//     }

//     // Check balance: If balance is insufficient, show dialog
//     if (widget.currentBalance < amount) {
//       _showInsufficientBalanceDialog(amount);
//       return;
//     }

//     // If balance is sufficient, show the bottom PIN sheet
//     _showPinBottomSheet(amount, recipient);
//   }

//   /// Dialog shown when current balance is less than required amount
//   void _showInsufficientBalanceDialog(int requiredAmount) {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (dialogContext) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(24),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 56,
//                   height: 56,
//                   decoration: const BoxDecoration(
//                     color: Color(0xffFEE2E2),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.account_balance_wallet_outlined,
//                     color: Color(0xffEF4444),
//                     size: 28,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'လက်ကျန် မလုံလောက်ပါ',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xff0F172A),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'သင့်လက်ကျန်ပွိုင့် (${NumberFormat('#,###').format(widget.currentBalance)} ပွိုင့်) သည် ပေးချေလိုသောပွိုင့် (${NumberFormat('#,###').format(requiredAmount)} ပွိုင့်) ထက် နည်းနေပါသည်။',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 13,
//                     color: Color(0xff64748B),
//                     height: 1.4,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 44,
//                   child: ElevatedButton(
//                     onPressed: () => Navigator.pop(dialogContext),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xffEF4444),
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       'လက်ခံပါပြီ',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   /// Opens 6-digit PIN bottom modal on clicking ပေးချေမည်
//   Future<void> _showPinBottomSheet(int amount, String recipient) async {
//     _pinController.clear();
//     final pinFocusNode = FocusNode();
//     if (mounted) setState(() => _isPinModalOpen = true);

//     final confirmed = await showModalBottomSheet<bool>(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (modalContext) {
//         return StatefulBuilder(
//           builder: (context, setModalState) {
//             final enteredDigits = _pinController.text.length;
//             final isPinComplete = enteredDigits == 6;

//             return Padding(
//               padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom,
//               ),
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       width: 38,
//                       height: 4,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade300,
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Container(
//                           width: 42,
//                           height: 42,
//                           decoration: BoxDecoration(
//                             color: primaryColor.withOpacity(0.1),
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Icon(
//                             Icons.lock_rounded,
//                             color: primaryColor,
//                             size: 21,
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         const Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'PIN ထည့်ပါ',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w800,
//                                   color: Color(0xff0F172A),
//                                 ),
//                               ),
//                               SizedBox(height: 2),
//                               Text(
//                                 'PIN ၆ လုံးဖြင့် ပေးချေမှုကို အတည်ပြုပါ',
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   color: Color(0xff64748B),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Material(
//                           color: const Color(0xffF1F5F9),
//                           shape: const CircleBorder(),
//                           child: InkWell(
//                             customBorder: const CircleBorder(),
//                             onTap: () => Navigator.pop(modalContext, false),
//                             child: const SizedBox(
//                               width: 34,
//                               height: 34,
//                               child: Icon(
//                                 Icons.close_rounded,
//                                 size: 18,
//                                 color: Color(0xff64748B),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 14,
//                         vertical: 8,
//                       ),
//                       decoration: BoxDecoration(
//                         color: primaryColor.withOpacity(0.08),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Text(
//                         "${NumberFormat('#,###').format(amount)} ပွိုင့်",
//                         style: const TextStyle(
//                           color: primaryColor,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     SizedBox(
//                       width: 1,
//                       height: 1,
//                       child: TextField(
//                         controller: _pinController,
//                         focusNode: pinFocusNode,
//                         autofocus: true,
//                         maxLength: 6,
//                         keyboardType: TextInputType.number,
//                         textInputAction: TextInputAction.done,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                           LengthLimitingTextInputFormatter(6),
//                         ],
//                         style: const TextStyle(color: Colors.transparent),
//                         cursorColor: Colors.transparent,
//                         decoration: const InputDecoration(
//                           counterText: '',
//                           border: InputBorder.none,
//                         ),
//                         onChanged: (_) => setModalState(() {}),
//                         onSubmitted: (_) {
//                           if (_pinController.text.length == 6) {
//                             Navigator.pop(modalContext, true);
//                           }
//                         },
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () => pinFocusNode.requestFocus(),
//                       behavior: HitTestBehavior.opaque,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(
//                           6,
//                           (index) => _buildPinBox(
//                             index,
//                             isActive: index == enteredDigits && enteredDigits < 6,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       '$enteredDigits / 6',
//                       style: TextStyle(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w600,
//                         color: isPinComplete
//                             ? primaryColor
//                             : Colors.grey.shade500,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 48,
//                       child: ElevatedButton(
//                         onPressed: isPinComplete
//                             ? () => Navigator.pop(modalContext, true)
//                             : null,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: primaryColor,
//                           disabledBackgroundColor: const Color(0xffE2E8F0),
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                         ),
//                         child: Text(
//                           'အတည်ပြုမည်',
//                           style: TextStyle(
//                             color: isPinComplete
//                                 ? Colors.white
//                                 : const Color(0xff94A3B8),
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );

//     pinFocusNode.dispose();
//     if (mounted) setState(() => _isPinModalOpen = false);

//     // If PIN is entered, proceed to OrderSuccessScreen
//     if (confirmed == true && mounted) {
//       _completeTransferAndNavigate(amount, recipient);
//     }
//   }

//   Widget _buildPinBox(int index, {required bool isActive}) {
//     final isFilled = index < _pinController.text.length;
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 150),
//       width: 42,
//       height: 50,
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: isFilled
//             ? primaryColor.withOpacity(0.08)
//             : const Color(0xffF8FAFC),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: isFilled || isActive ? primaryColor : const Color(0xffCBD5E1),
//           width: isActive ? 2 : 1.3,
//         ),
//       ),
//       child: isFilled
//           ? const Text(
//               '•',
//               style: TextStyle(
//                 color: primaryColor,
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//               ),
//             )
//           : null,
//     );
//   }

//   void _completeTransferAndNavigate(int amount, String recipient) {
//     if (widget.onTransferCompleted != null) {
//       widget.onTransferCompleted!(amount, recipient);
//     }

//     // Navigate to Order Success Screen
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => OrderSuccessScreen(
//           shopName: recipient,
//           orderType: widget.orderType,
//           selectedSeatId: widget.selectedSeatId,
//           cartItems: widget.cartItems,
//           totalPoints: amount,
//           note: widget.note,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final locked = widget.readOnlyTransfer;

//     return Scaffold(
//       backgroundColor: const Color(0xff0D6B80),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               margin: const EdgeInsets.fromLTRB(16, 44, 16, 8),
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.15),
//                 borderRadius: BorderRadius.circular(22),
//                 border: Border.all(color: Colors.white.withOpacity(0.2)),
//               ),
//               child: Row(
//                 children: [
//                   Material(
//                     color: Colors.white.withOpacity(0.18),
//                     shape: const CircleBorder(),
//                     child: IconButton(
//                       icon: const Icon(
//                         Icons.arrow_back_ios_new_rounded,
//                         color: Colors.white,
//                         size: 17,
//                       ),
//                       onPressed: _isPinModalOpen
//                           ? null
//                           : () => Navigator.pop(context),
//                     ),
//                   ),
//                   const Expanded(
//                     child: Text(
//                       'ပွိုင့် လွှဲမည်',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 48),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 12),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'လက်ကျန် ပွိုင့်',
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.72),
//                           fontSize: 13,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         '${NumberFormat('#,###').format(widget.currentBalance)} ပွိုင့်',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 27,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.15),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.account_balance_wallet_rounded,
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
//                 decoration: const BoxDecoration(
//                   color: Color(0xffF4F6F9),
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
//                 ),
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const Text(
//                         'လက်ခံမည့်ဆိုင်',
//                         style: TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff64748B),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       TextField(
//                         controller: _recipientController,
//                         readOnly: locked,
//                         decoration: _inputDecoration(
//                           hint: 'Shop name or ID',
//                           icon: Icons.storefront_rounded,
//                           locked: locked,
//                         ),
//                       ),
//                       const SizedBox(height: 24),
//                       const Text(
//                         'လွှဲမည့်ပွိုင့်',
//                         style: TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff64748B),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Container(
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(22),
//                           border: Border.all(
//                             color: primaryColor.withOpacity(0.12),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   locked
//                                       ? 'အော်ဒါအတွက် ပေးချေရမည့်ပွိုင့်'
//                                       : 'ပွိုင့်ထည့်ပါ',
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color(0xff64748B),
//                                   ),
//                                 ),
//                                 if (locked)
//                                   const Icon(
//                                     Icons.lock_rounded,
//                                     size: 17,
//                                     color: primaryColor,
//                                   ),
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             TextField(
//                               controller: _amountController,
//                               readOnly: locked,
//                               keyboardType: TextInputType.number,
//                               inputFormatters: [
//                                 FilteringTextInputFormatter.digitsOnly,
//                               ],
//                               style: const TextStyle(
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xff0F172A),
//                               ),
//                               decoration: const InputDecoration(
//                                 hintText: '0',
//                                 suffixText: 'ပွိုင့်',
//                                 suffixStyle: TextStyle(
//                                   color: primaryColor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 13,
//                                 ),
//                                 border: InputBorder.none,
//                                 contentPadding: EdgeInsets.zero,
//                               ),
//                             ),
//                             if (!locked) ...[
//                               const Divider(height: 28),
//                               Row(
//                                 children: _presetAmounts.map((preset) {
//                                   return Expanded(
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 3,
//                                       ),
//                                       child: InkWell(
//                                         onTap: () => setState(() {
//                                           _amountController.text = preset
//                                               .toString();
//                                         }),
//                                         borderRadius: BorderRadius.circular(10),
//                                         child: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                             vertical: 8,
//                                           ),
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                             color: const Color(0xffF8FAFC),
//                                             borderRadius: BorderRadius.circular(
//                                               10,
//                                             ),
//                                             border: Border.all(
//                                               color: Colors.grey.shade200,
//                                             ),
//                                           ),
//                                           child: Text(
//                                             '+${NumberFormat.compact().format(preset)}',
//                                             style: const TextStyle(
//                                               fontSize: 11,
//                                               fontWeight: FontWeight.bold,
//                                               color: Color(0xff475569),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                       if (locked) ...[
//                         const SizedBox(height: 12),
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: const Color(0xffEAF7F9),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Row(
//                             children: [
//                               Icon(
//                                 Icons.verified_user_outlined,
//                                 color: primaryColor,
//                                 size: 18,
//                               ),
//                               SizedBox(width: 8),
//                               Expanded(
//                                 child: Text(
//                                   'ဆိုင်နှင့် ပေးချေရမည့်ပွိုင့်ကို အော်ဒါအတိုင်း သတ်မှတ်ထား၍ ပြင်ဆင်၍မရပါ။',
//                                   style: TextStyle(
//                                     fontSize: 11,
//                                     color: primaryColor,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                       const SizedBox(height: 30),
//                       SizedBox(
//                         height: 54,
//                         child: ElevatedButton(
//                           onPressed: _handleTransfer,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: primaryColor,
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                           ),
//                           child: Text(
//                             locked ? 'ပေးချေမည်' : 'ငွေလွှဲမည်',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   InputDecoration _inputDecoration({
//     required String hint,
//     required IconData icon,
//     required bool locked,
//   }) {
//     return InputDecoration(
//       hintText: hint,
//       prefixIcon: Icon(icon, color: primaryColor, size: 20),
//       suffixIcon: locked
//           ? const Icon(Icons.lock_rounded, color: primaryColor, size: 18)
//           : null,
//       filled: true,
//       fillColor: locked ? const Color(0xffF8FAFC) : Colors.white,
//       contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide(color: Colors.grey.shade200),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide(color: Colors.grey.shade200),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: const BorderSide(color: primaryColor, width: 1.5),
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:smartcanteen/service/api_service.dart';
import 'package:smartcanteen/view/order_success_screen.dart';

// class TransferScreen extends StatefulWidget {
//   final int shopId;
//   final int currentBalance;
//   final Function(int amount, String recipient)? onTransferCompleted;
//   final String? initialRecipient;
//   final int? initialAmount;
//   final bool readOnlyTransfer;

//   // PASS-THROUGH ORDER DATA
//   final String orderType;
//   final String? selectedSeatId;
//   final List<Map<String, dynamic>> cartItems;
//   final String note;

//   const TransferScreen({
//     super.key,
//     required this.shopId,
//     required this.currentBalance,
//     this.onTransferCompleted,
//     this.initialRecipient,
//     this.initialAmount,
//     this.readOnlyTransfer = false,
//     this.orderType = 'takeaway',
//     this.selectedSeatId,
//     this.cartItems = const [],
//     this.note = '',
//   });

//   @override
//   State<TransferScreen> createState() => _TransferScreenState();
// }
class TransferScreen extends StatefulWidget {
  final int shopId;
  final int currentBalance;
  final Function(int amount, String recipient)? onTransferCompleted;
  final String? initialRecipient;
  final int? initialAmount;
  final bool readOnlyTransfer;

  // Add these fields
  final List<Map<String, dynamic>> cartItems;
  final String orderType;
  final String? selectedSeatId;
  final String note;

  const TransferScreen({
    super.key,
    required this.shopId,
    required this.currentBalance,
    this.onTransferCompleted,
    this.initialRecipient,
    this.initialAmount,
    this.readOnlyTransfer = false,
    // Add default initializers
    this.cartItems = const [],
    this.orderType = 'takeaway',
    this.selectedSeatId,
    this.note = '',
  });

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}
class _TransferScreenState extends State<TransferScreen> {
  static const Color primaryColor = Color(0xff117992);

  late final TextEditingController _recipientController;
  late final TextEditingController _amountController;
  final TextEditingController _pinController = TextEditingController();
  final List<int> _presetAmounts = [100, 500, 1000, 5000];

  bool _isPinModalOpen = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // 🔍 TEST PRINT 2: Check received cart items in TransferScreen
  print("=== DEBUG: Received cartItems in TransferScreen ===");
  print(widget.cartItems);
    _recipientController = TextEditingController(
      text: widget.initialRecipient ?? '',
    );
    _amountController = TextEditingController(
      text: widget.initialAmount != null ? widget.initialAmount.toString() : '',
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final amount = _amount;
      if (amount != null && widget.currentBalance < amount) {
        _showInsufficientBalanceDialog(amount);
      }
    });
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  int? get _amount =>
      int.tryParse(_amountController.text.replaceAll(',', '').trim());

  String get _recipient => _recipientController.text.trim();

  void _handleTransfer() {
    final amount = _amount;
    final recipient = _recipient;

    if (amount == null || amount <= 0 || recipient.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid transfer details.')),
      );
      return;
    }

    if (widget.currentBalance < amount) {
      _showInsufficientBalanceDialog(amount);
      return;
    }

    _showPinBottomSheet(amount, recipient);
  }

  void _showInsufficientBalanceDialog(int requiredAmount) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Color(0xffFEE2E2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Color(0xffEF4444),
                    size: 28,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'လက်ကျန် မလုံလောက်ပါ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'သင့်လက်ကျန်ပွိုင့် (${NumberFormat('#,###').format(widget.currentBalance)} ပွိုင့်) သည် ပေးချေလိုသောပွိုင့် (${NumberFormat('#,###').format(requiredAmount)} ပွိုင့်) ထက် နည်းနေပါသည်။',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xff64748B),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffEF4444),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'လက်ခံပါပြီ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Show Error Message from API Response in a Dialog Box
  void _showApiErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Color(0xffFEE2E2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.error_outline_rounded,
                    color: Color(0xffEF4444),
                    size: 32,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'အမှားအယွင်းရှိပါသည်',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xff64748B),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffEF4444),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'ပြန်လည်ကြိုးစားမည်',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showPinBottomSheet(int amount, String recipient) async {
    _pinController.clear();
    final pinFocusNode = FocusNode();
    if (mounted) setState(() => _isPinModalOpen = true);

    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final enteredDigits = _pinController.text.length;
            final isPinComplete = enteredDigits == 6;

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 38,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.lock_rounded,
                            color: primaryColor,
                            size: 21,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PIN ထည့်ပါ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xff0F172A),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'PIN ၆ လုံးဖြင့် ပေးချေမှုကို အတည်ပြုပါ',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xff64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Material(
                          color: const Color(0xffF1F5F9),
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () => Navigator.pop(modalContext, false),
                            child: const SizedBox(
                              width: 34,
                              height: 34,
                              child: Icon(
                                Icons.close_rounded,
                                size: 18,
                                color: Color(0xff64748B),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${NumberFormat('#,###').format(amount)} ပွိုင့်",
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 1,
                      height: 1,
                      child: TextField(
                        controller: _pinController,
                        focusNode: pinFocusNode,
                        autofocus: true,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        style: const TextStyle(color: Colors.transparent),
                        cursorColor: Colors.transparent,
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                        ),
                        onChanged: (_) => setModalState(() {}),
                        onSubmitted: (_) {
                          if (_pinController.text.length == 6) {
                            Navigator.pop(modalContext, true);
                          }
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () => pinFocusNode.requestFocus(),
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          6,
                          (index) => _buildPinBox(
                            index,
                            isActive: index == enteredDigits && enteredDigits < 6,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '$enteredDigits / 6',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isPinComplete
                            ? primaryColor
                            : Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: isPinComplete
                            ? () => Navigator.pop(modalContext, true)
                            : _submitOrderAndTransfer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          disabledBackgroundColor: const Color(0xffE2E8F0),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          'အတည်ပြုမည်',
                          style: TextStyle(
                            color: isPinComplete
                                ? Colors.white
                                : const Color(0xff94A3B8),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    pinFocusNode.dispose();
    if (mounted) setState(() => _isPinModalOpen = false);

    if (confirmed == true && mounted) {
      final enteredPin = _pinController.text;
      _completeTransferAndNavigate(amount, recipient, enteredPin);
    }
  }
Future<void> _completeTransferAndNavigate(
    int amount, String recipient, String walletPassword) async {
  setState(() => _isLoading = true);

  // Format items for ApiService createOrder
final formattedItems = widget.cartItems.map((item) {
  return {
    "menu_id": item["id"], // Ensure this key matches your Menu model ID
    "quantity": item["cartQuantity"],
  };
}).toList();

  try {
    // Automatically uses the token retrieved via SecureStorageService
    final response = await ApiService().createOrder(
      shopId: widget.shopId,
      orderType: widget.orderType,
      walletPassword: _pinController.text,
      deliveryLocation: widget.selectedSeatId.toString(),
      items: formattedItems,
    );

    setState(() => _isLoading = false);

    if (response != null && response['success'] == true) {
      final data = response['data'] ?? {};

      if (widget.onTransferCompleted != null) {
        widget.onTransferCompleted!(amount, recipient);
      }

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrderSuccessScreen(
            shopName: recipient,
            orderType: widget.orderType,
            selectedSeatId: widget.selectedSeatId,
            cartItems: widget.cartItems,
            totalPoints: data['total_price'] ?? amount,
            note: widget.note,
            orderId: data['order_id']?.toString() ?? '',
            qrCodeToken: data['qr_code_token'] ?? '',
            orderStatus: data['order_status'] ?? 'paid',
          ),
        ),
      );
    } else {
      _showApiErrorDialog(response?['message'] ?? 'အော်ဒါ မှာယူမှု မအောင်မြင်ပါ။');
    }
  } catch (e) {
    setState(() => _isLoading = false);
    _showApiErrorDialog(e.toString());
  }
}
  Widget _buildPinBox(int index, {required bool isActive}) {
    final isFilled = index < _pinController.text.length;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 42,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isFilled
            ? primaryColor.withOpacity(0.08)
            : const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFilled || isActive ? primaryColor : const Color(0xffCBD5E1),
          width: isActive ? 2 : 1.3,
        ),
      ),
      child: isFilled
          ? const Text(
              '•',
              style: TextStyle(
                color: primaryColor,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );
  }
Future<void> _submitOrderAndTransfer() async {
  final pin = _pinController.text.trim();
  if (pin.length < 6) {
    _showSnackBar('PIN နံပါတ် (၆) လုံး အပြည့်အစုံ ရိုက်ထည့်ပါ');
    return;
  }

 // Ensure the key name in the Map is strictly "menu_id"
final List<Map<String, dynamic>> itemsPayload = widget.cartItems.map((item) {
  // Extract ID checking all possible incoming key names
  final dynamic rawId = item["menu_id"] ?? item["menu_item_id"] ?? item["id"];
  final dynamic rawQty = item["quantity"] ?? item["cartQuantity"];

  return {
    "menu_id": rawId != null ? int.parse(rawId.toString()) : 0, // <--- MUST BE "menu_id"
    "quantity": rawQty != null ? int.parse(rawQty.toString()) : 1,
  };
}).toList();
  // 2. Parse foodTableId safely
  int? parsedTableId;
  if (widget.selectedSeatId != null) {
    parsedTableId = int.tryParse(widget.selectedSeatId.toString());
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );

  try {
    // 3. Call ApiService with parameters
    final response = await ApiService().createOrder(
      shopId: widget.shopId,
      orderType: widget.orderType, // e.g. "dine-in" or "takeaway"
      foodTableId: parsedTableId ?? 1, // Matches food_table_id
      walletPassword: pin,
      deliveryLocation: null,
      items: itemsPayload,
    );

    if (mounted) Navigator.pop(context); // Close progress dialog

    if (response != null && response['success'] == true) {
      final String orderId = response['data']?['id']?.toString() ?? '';
      final String qrToken = response['data']?['qr_code_token'] ?? '';

      if (widget.onTransferCompleted != null) {
        widget.onTransferCompleted!(
          widget.initialAmount ?? 0,
          widget.initialRecipient ?? '',
        );
      }

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => OrderSuccessScreen(
              shopName: widget.initialRecipient ?? '',
              orderType: widget.orderType,
              selectedSeatId: widget.selectedSeatId,
              cartItems: widget.cartItems,
              totalPoints: widget.initialAmount ?? 0,
              note: widget.note,
              orderId: orderId,
              qrCodeToken: qrToken,
            ),
          ),
        );
      }
    } else {
      _showSnackBar(response?['message'] ?? 'မှာယူမှု မအောင်မြင်ပါ။');
    }
  } catch (error) {
    if (mounted) Navigator.pop(context);
    _showSnackBar(error.toString());
  }
}
void _showSnackBar(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), backgroundColor: Colors.red),
  );
}
  @override
  Widget build(BuildContext context) {
    final locked = widget.readOnlyTransfer;

    return Scaffold(
      backgroundColor: const Color(0xff0D6B80),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 44, 16, 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Material(
                    color: Colors.white.withOpacity(0.18),
                    shape: const CircleBorder(),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 17,
                      ),
                      onPressed: _isPinModalOpen || _isLoading
                          ? null
                          : () => Navigator.pop(context),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'ပွိုင့် လွှဲမည်',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'လက်ကျန် ပွိုင့်',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.72),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${NumberFormat('#,###').format(widget.currentBalance)} ပွိုင့်',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                decoration: const BoxDecoration(
                  color: Color(0xffF4F6F9),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'လက်ခံမည့်ဆိုင်',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff64748B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _recipientController,
                        readOnly: locked,
                        decoration: _inputDecoration(
                          hint: 'Shop name or ID',
                          icon: Icons.storefront_rounded,
                          locked: locked,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'လွှဲမည့်ပွိုင့်',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff64748B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: primaryColor.withOpacity(0.12),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  locked
                                      ? 'အော်ဒါအတွက် ပေးချေရမည့်ပွိုင့်'
                                      : 'ပွိုင့်ထည့်ပါ',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff64748B),
                                  ),
                                ),
                                if (locked)
                                  const Icon(
                                    Icons.lock_rounded,
                                    size: 17,
                                    color: primaryColor,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _amountController,
                              readOnly: locked,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0F172A),
                              ),
                              decoration: const InputDecoration(
                                hintText: '0',
                                suffixText: 'ပွိုင့်',
                                suffixStyle: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                            if (!locked) ...[
                              const Divider(height: 28),
                              Row(
                                children: _presetAmounts.map((preset) {
                                  return Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 3,
                                      ),
                                      child: InkWell(
                                        onTap: () => setState(() {
                                          _amountController.text =
                                              preset.toString();
                                        }),
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffF8FAFC),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                          child: Text(
                                            '+${NumberFormat.compact().format(preset)}',
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff475569),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (locked) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xffEAF7F9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.verified_user_outlined,
                                color: primaryColor,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'ဆိုင်နှင့် ပေးချေရမည့်ပွိုင့်ကို အော်ဒါအတိုင်း သတ်မှတ်ထား၍ ပြင်ဆင်၍မရပါ။',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 54,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleTransfer,
                          //onPressed: _submitOrderAndTransfer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Text(
                                  locked ? 'ပေးချေမည်' : 'ငွေလွှဲမည်',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    required bool locked,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: primaryColor, size: 20),
      suffixIcon: locked
          ? const Icon(Icons.lock_rounded, color: primaryColor, size: 18)
          : null,
      filled: true,
      fillColor: locked ? const Color(0xffF8FAFC) : Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryColor, width: 1.5),
      ),
    );
  }
}