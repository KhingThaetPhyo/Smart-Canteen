
// // import 'package:flutter/material.dart';
// // import 'package:smartcanteen/view/order_success_screen.dart';
// // import 'package:smartcanteen/view/transfer_screen.dart';

// // class AddToCartScreen extends StatefulWidget {
// //   final int shopId;
// //   final String shopName;
// //   final List<Map<String, dynamic>> seats;
// //   final List<Map<String, dynamic>> menuItems;
// //   final Function(Map<String, dynamic>) onAddToCart;
// //   final Function(Map<String, dynamic>) onRemoveFromCart;
// //   final VoidCallback onConfirmOrder;
// //   final int currentBalance;
// //   const AddToCartScreen({
// //     super.key,
// //     required this.shopName,
// //     this.seats = const [],
// //     required this.menuItems,
// //     required this.onAddToCart,
// //     required this.onRemoveFromCart,
// //     required this.onConfirmOrder,
// //     required this.currentBalance, required this.shopId,
// //   });
// //   @override
// //   State<AddToCartScreen> createState() => _AddToCartScreenState();
// // }

// // class _AddToCartScreenState extends State<AddToCartScreen> {
// //   static const Color primaryColor = Color(0xff117992);
// //   // ORDER TYPE STATE: "dinein" (reserve table) or "takeaway"

// //   String orderType = "takeaway";
// //   String? selectedSeatId;
// //   String? selectedSeatLabel;

// //   // OPTIONAL NOTE STATE
// //   final TextEditingController _noteController = TextEditingController();

// //   int _parsePrice(String priceStr) {
// //     final numStr = priceStr.replaceAll(RegExp(r'[^0-9]'), '');
// //     return int.tryParse(numStr) ?? 0;
// //   }

// //   int get totalPoints {
// //     int total = 0;
// //     for (var item in widget.menuItems) {
// //       final int qty = item["cartQuantity"] ?? 0;
// //       if (qty > 0) {
// //         total += _parsePrice(item["price"]) * qty;
// //       }
// //     }
// //     print("Current Balance is ---------${widget.currentBalance}");
// //     return total;
// //   }

// //   bool get _isReadyToOrder {
// //     if (totalPoints == 0) return false;
// //     if (orderType == "dine-in" && selectedSeatId == null) return false;
// //     return true;
// //   }

// //   @override
// //   void dispose() {
// //     _noteController.dispose();
// //     super.dispose();
// //   }

// //   // Navigate to the separate Select Seat page and wait for the result.
// //   Future<void> _openSelectSeatPage() async {
// //     final result = await Navigator.push<Map<String, String>?>(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => SelectSeatScreen(
// //           shopName: widget.shopName,
// //           seats: widget.seats,
// //           currentSeatId: selectedSeatId,
// //         ),
// //       ),
// //     );
// //     if (result != null) {
// //       setState(() {
// //         selectedSeatId = result["id"];
// //         selectedSeatLabel = result["label"];
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final cartItems = widget.menuItems
// //         .where((item) => (item["cartQuantity"] as int? ?? 0) > 0)
// //         .toList();
// //     return Container(
// //       color: Colors.transparent,
// //       padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
// //       child: SingleChildScrollView(
// //         physics: const BouncingScrollPhysics(),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             /// RECEIPT PAPER BODY WITH ZIGZAG CLIPPER
// //             ClipPath(
// //               clipper: ReceiptClipper(),
// //               child: Container(
// //                 color: Colors.white,
// //                 padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.center,
// //                   children: [
// //                     /// RECEIPT HEADER
// //                     Container(
// //                       width: 44,
// //                       height: 44,
// //                       decoration: BoxDecoration(
// //                         color: primaryColor.withOpacity(0.1),
// //                         shape: BoxShape.circle,
// //                       ),
// //                       child: const Icon(
// //                         Icons.receipt_long_rounded,
// //                         color: primaryColor,
// //                         size: 24,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 10),
// //                     Text(
// //                       widget.shopName.toUpperCase(),
// //                       style: const TextStyle(
// //                         fontWeight: FontWeight.w900,
// //                         fontSize: 18,
// //                         letterSpacing: 1.5,
// //                         color: Color(0xff1E293B),
// //                       ),
// //                     ),
// //                     const SizedBox(height: 4),
// //                     Text(
// //                       "အော်ဒါ အနှစ်ချုပ်",
// //                       style: TextStyle(
// //                         fontSize: 14,
// //                         fontWeight: FontWeight.w600,
// //                         color: Colors.grey.shade500,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 18),

// //                     /// =========================================================
// //                     /// ORDER TYPE SELECTOR (Dine-in / Take Away)
// //                     /// =========================================================
// //                     Align(
// //                       alignment: Alignment.centerLeft,
// //                       child: Text(
// //                         "မှာယူပုံ ရွေးချယ်ပါ",
// //                         style: TextStyle(
// //                           fontSize: 12,
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.grey.shade700,
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Row(
// //                       children: [
// //                         _buildOrderTypeCard(
// //                           type: "dine-in",
// //                           icon: Icons.event_seat_rounded,
// //                           title: "ဆိုင်တွင်ထိုင်စား",
// //                         ),
// //                         const SizedBox(width: 10),
// //                         _buildOrderTypeCard(
// //                           type: "takeaway",
// //                           icon: Icons.shopping_bag_rounded,
// //                           title: "ပါဆယ်",
// //                         ),
// //                       ],
// //                     ),

// //                     /// =========================================================
// //                     /// TABLE RESERVATION ROW (only when dine-in)
// //                     /// Opens the SEPARATE select-seat page.
// //                     /// =========================================================
// //                     if (orderType == "dine-in") ...[
// //                       const SizedBox(height: 14),
// //                       selectedSeatId == null
// //                           ? _buildSelectTableButton()
// //                           : _buildReservedTableCard(),
// //                     ],
// //                     const SizedBox(height: 20),
// //                     _buildDottedDivider(),
// //                     const SizedBox(height: 16),

// //                     /// CART ITEMS LIST
// //                     if (cartItems.isEmpty)
// //                       Padding(
// //                         padding: const EdgeInsets.symmetric(vertical: 30),
// //                         child: Column(
// //                           children: [
// //                             Icon(
// //                               Icons.shopping_bag_outlined,
// //                               size: 40,
// //                               color: Colors.grey.shade300,
// //                             ),
// //                             const SizedBox(height: 8),
// //                             Text(
// //                               "ဈေးဝယ်ခြင်း ဗလာဖြစ်နေသည်",
// //                               style: TextStyle(
// //                                 color: Colors.grey.shade500,
// //                                 fontWeight: FontWeight.w500,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       )
// //                     else
// //                       ListView.separated(
// //                         shrinkWrap: true,
// //                         physics: const NeverScrollableScrollPhysics(),
// //                         itemCount: cartItems.length,
// //                         separatorBuilder: (context, index) =>
// //                             const SizedBox(height: 12),
// //                         itemBuilder: (context, index) {
// //                           final item = cartItems[index];
// //                           final int qty = item["cartQuantity"];
// //                           final int unitPrice = _parsePrice(item["price"]);
// //                           final int itemTotalPts = unitPrice * qty;
// //                           return Row(
// //                             children: [
// //                               /// ITEM DETAILS
// //                               Expanded(
// //                                 child: Column(
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     Text(
// //                                       item["name"],
// //                                       style: const TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                         fontSize: 14,
// //                                         color: Color(0xff1E293B),
// //                                       ),
// //                                     ),
// //                                     const SizedBox(height: 2),
// //                                     Text(
// //                                       "တစ်ခုလျှင် $unitPrice ပွိုင့်",
// //                                       style: TextStyle(
// //                                         fontSize: 11,
// //                                         color: Colors.grey.shade500,
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),

// //                               /// QUANTITY COUNT
// //                               Container(
// //                                 padding: const EdgeInsets.symmetric(
// //                                   horizontal: 10,
// //                                   vertical: 5,
// //                                 ),
// //                                 decoration: BoxDecoration(
// //                                   color: primaryColor.withOpacity(0.08),
// //                                   borderRadius: BorderRadius.circular(8),
// //                                 ),
// //                                 child: Text(
// //                                   "x$qty",
// //                                   style: const TextStyle(
// //                                     fontWeight: FontWeight.bold,
// //                                     fontSize: 13,
// //                                     color: primaryColor,
// //                                   ),
// //                                 ),
// //                               ),
// //                               const SizedBox(width: 14),

// //                               /// TOTAL POINTS FOR ITEM
// //                               SizedBox(
// //                                 width: 64,
// //                                 child: Text(
// //                                   "$itemTotalPts ပွိုင့်",
// //                                   textAlign: TextAlign.right,
// //                                   style: const TextStyle(
// //                                     fontWeight: FontWeight.w800,
// //                                     fontSize: 13,
// //                                     color: Color(0xff1E293B),
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           );
// //                         },
// //                       ),

// //                     /// =========================================================
// //                     /// OPTIONAL NOTE FIELD
// //                     /// =========================================================
// //                     if (cartItems.isNotEmpty) ...[
// //                       const SizedBox(height: 16),
// //                       Align(
// //                         alignment: Alignment.centerLeft,
// //                         child: Row(
// //                           children: [
// //                             Icon(
// //                               Icons.edit_note_rounded,
// //                               size: 16,
// //                               color: Colors.grey.shade600,
// //                             ),
// //                             const SizedBox(width: 6),
// //                             Text(
// //                               "မှတ်ချက် (ရွေးချယ်ရန်)",
// //                               style: TextStyle(
// //                                 fontSize: 12,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: Colors.grey.shade700,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       const SizedBox(height: 8),
// //                       TextField(
// //                         controller: _noteController,
// //                         maxLines: 2,
// //                         minLines: 1,
// //                         textInputAction: TextInputAction.done,
// //                         style: const TextStyle(
// //                           fontSize: 13,
// //                           color: Color(0xff1E293B),
// //                         ),
// //                         decoration: InputDecoration(
// //                           hintText:
// //                               "ဥပမာ - အစပ်နည်းနည်း၊ ကြက်ဥ ပိုထည့်ပေးပါ...",
// //                           hintStyle: TextStyle(
// //                             color: Colors.grey.shade400,
// //                             fontSize: 12,
// //                           ),
// //                           filled: true,
// //                           fillColor: Colors.grey.shade50,
// //                           isDense: true,
// //                           contentPadding: const EdgeInsets.symmetric(
// //                             horizontal: 12,
// //                             vertical: 10,
// //                           ),
// //                           border: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12),
// //                             borderSide: BorderSide(color: Colors.grey.shade300),
// //                           ),
// //                           enabledBorder: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12),
// //                             borderSide: BorderSide(color: Colors.grey.shade300),
// //                           ),
// //                           focusedBorder: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12),
// //                             borderSide: const BorderSide(
// //                               color: primaryColor,
// //                               width: 1.4,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                     const SizedBox(height: 20),
// //                     _buildDottedDivider(),
// //                     const SizedBox(height: 16),

// //                     /// ORDER TYPE SUMMARY ROW
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Text(
// //                           "မှာယူပုံ",
// //                           style: TextStyle(
// //                             fontSize: 13,
// //                             fontWeight: FontWeight.w600,
// //                             color: Colors.grey.shade600,
// //                           ),
// //                         ),
// //                         Text(
// //                           orderType == "dine-in"
// //                               ? (selectedSeatId != null
// //                                     ? "ဆိုင်တွင်ထိုင်စား · ${selectedSeatLabel ?? selectedSeatId}"
// //                                     : "ဆိုင်တွင်ထိုင်စား")
// //                               : "ပါဆယ်",
// //                           style: const TextStyle(
// //                             fontSize: 13,
// //                             fontWeight: FontWeight.bold,
// //                             color: primaryColor,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 12),

// //                     /// TOTAL POINTS DISPLAY
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         const Text(
// //                           "စုစုပေါင်း ပွိုင့်",
// //                           style: TextStyle(
// //                             fontWeight: FontWeight.w900,
// //                             fontSize: 15,
// //                             color: Color(0xff1E293B),
// //                           ),
// //                         ),
// //                         Text(
// //                           "$totalPoints ပွိုင့်",
// //                           style: const TextStyle(
// //                             fontWeight: FontWeight.w900,
// //                             fontSize: 20,
// //                             color: primaryColor,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 16),

// //             /// DINE-IN HINT (if table not yet picked)
// //             if (orderType == "dine-in" &&
// //                 selectedSeatId == null &&
// //                 cartItems.isNotEmpty) ...[
// //               Container(
// //                 width: double.infinity,
// //                 padding: const EdgeInsets.symmetric(
// //                   horizontal: 14,
// //                   vertical: 10,
// //                 ),
// //                 decoration: BoxDecoration(
// //                   color: const Color(0xffFEF3C7),
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //                 child: Row(
// //                   children: [
// //                     const Icon(
// //                       Icons.info_outline_rounded,
// //                       size: 18,
// //                       color: Color(0xffD97706),
// //                     ),
// //                     const SizedBox(width: 8),
// //                     Expanded(
// //                       child: Text(
// //                         "အော်ဒါမတင်မီ စားပွဲ ရွေးချယ်ပေးပါ။",
// //                         style: TextStyle(
// //                           fontSize: 12,
// //                           fontWeight: FontWeight.w600,
// //                           color: Colors.orange.shade900,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(height: 12),
// //             ],

// //             /// CONFIRM ORDER / PLACE ORDER BUTTON
// //             SizedBox(
// //               width: double.infinity,
// //               height: 52,
// //               child: ElevatedButton(
// //                onPressed: !_isReadyToOrder
// //     ? null
// //     : () {
// //     //     // 1. Filter selected items and map to exact API key names
// //     //     final selectedCartItems = widget.menuItems
// //     // .where((item) => ((item["cartQuantity"] as int?) ?? 0) > 0)
// //     // .map((item) {
// //     //   // Safely extract ID checking both potential keys
// //     //   final dynamic rawId = item["id"] ?? item["menu_item_id"] ?? item["menu_id"];
// //     //   final int itemId = rawId != null ? int.parse(rawId.toString()) : 0;

// //     //   // Safely extract Quantity
// //     //   final dynamic rawQty = item["cartQuantity"] ?? item["quantity"];
// //     //   final int qty = rawQty != null ? int.parse(rawQty.toString()) : 1;

// //     //   return {
// //     //     "menu_item_id": itemId,
// //     //     "quantity": qty,
// //     //     "name": item["name"] ?? item["item_name"] ?? "",
// //     //     "price": item["rawPrice"] ?? item["price"] ?? 0,
// //     //   };
// //     // })
// //     // .toList();
// //     final selectedCartItems = widget.menuItems
// //     .where((item) => ((item["cartQuantity"] as int?) ?? 0) > 0)
// //     .map((item) {
// //       final dynamic rawId = item["id"] ?? item["menu_id"] ?? item["menu_item_id"];
// //       final dynamic rawQty = item["cartQuantity"] ?? item["quantity"];

// //       return {
// //         "menu_id": rawId,                       // Primary key expected by Laravel
// //         "id": rawId,                            // Fallback key
// //         "quantity": rawQty,                     // Primary quantity key
// //         "cartQuantity": rawQty,                 // Fallback quantity key
// //         "name": item["name"] ?? "",
// //         "price": item["rawPrice"] ?? item["price"] ?? 0,
// //       };
// //     })
// //     .toList();

// // print("=== SELECTED ITEMS FROM ADD TO CART ===");
// // print(selectedCartItems);
// //         final capturedTotal = totalPoints;
// //         final String orderNote = _noteController.text.trim();
// //         final String capturedOrderType = orderType;
// //         final String? capturedSeat = selectedSeatLabel ?? selectedSeatId;
// //         final navigator = Navigator.of(context);

// //         // 2. Dismiss AddToCart Bottom Sheet
// //         Navigator.pop(context);

// //         // 3. Open TransferScreen with cartItems passed
// //         Future.microtask(() {
// //           navigator.push(
// //             MaterialPageRoute(
// //               builder: (_) => TransferScreen(
// //                 shopId: widget.shopId,
// //                 currentBalance: widget.currentBalance,
// //                 initialRecipient: widget.shopName,
// //                 initialAmount: capturedTotal,
// //                 readOnlyTransfer: true,
// //                 // --- PASS CARRIED DATA HERE ---
// //                 cartItems: selectedCartItems,
// //                 orderType: capturedOrderType,
// //                 selectedSeatId: capturedSeat,
// //                 note: orderNote,
// //                 onTransferCompleted: (amount, recipient) {
// //                   widget.onConfirmOrder();
// //                 },
// //               ),
// //             ),
// //           );
// //         });
// //       },
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: primaryColor,
// //                   disabledBackgroundColor: Colors.grey.shade400,
// //                   elevation: 2,
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(16),
// //                   ),
// //                 ),
// //                 child: Text(
// //                   cartItems.isEmpty
// //                       ? "ဈေးဝယ်ခြင်း ဗလာဖြစ်နေသည်"
// //                       : "အော်ဒါတင်မည် ($totalPoints ပွိုင့်)",
// //                   style: const TextStyle(
// //                     color: Colors.white,
// //                     fontWeight: FontWeight.bold,
// //                     fontSize: 15,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // ===========================================================================
// //   // ORDER TYPE CARD
// //   // ===========================================================================
// //   Widget _buildOrderTypeCard({
// //     required String type,
// //     required IconData icon,
// //     required String title,
// //   }) {
// //     final bool isSelected = orderType == type;
// //     return Expanded(
// //       child: GestureDetector(
// //         onTap: () {
// //           setState(() {
// //             orderType = type;
// //             if (type == "takeaway") {
// //               // clear reservation when switching to takeaway
// //               selectedSeatId = null;
// //               selectedSeatLabel = null;
// //             }
// //           });
// //         },
// //         child: AnimatedContainer(
// //           duration: const Duration(milliseconds: 180),
// //           padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
// //           decoration: BoxDecoration(
// //             color: isSelected ? primaryColor.withOpacity(0.08) : Colors.white,
// //             borderRadius: BorderRadius.circular(14),
// //             border: Border.all(
// //               color: isSelected ? primaryColor : Colors.grey.shade300,
// //               width: isSelected ? 1.6 : 1,
// //             ),
// //           ),
// //           child: Column(
// //             children: [
// //               Icon(
// //                 icon,
// //                 color: isSelected ? primaryColor : Colors.grey.shade500,
// //                 size: 26,
// //               ),
// //               const SizedBox(height: 8),
// //               Text(
// //                 title,
// //                 style: TextStyle(
// //                   fontWeight: FontWeight.bold,
// //                   fontSize: 13,
// //                   color: isSelected ? primaryColor : const Color(0xff1E293B),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // ===========================================================================
// //   // "SELECT TABLE" BUTTON (no table picked yet) -> opens separate page
// //   // ===========================================================================
// //   Widget _buildSelectTableButton() {
// //     return SizedBox(
// //       width: double.infinity,
// //       child: OutlinedButton.icon(
// //         onPressed: _openSelectSeatPage,
// //         icon: const Icon(Icons.event_seat_rounded, size: 18),
// //         label: const Text(
// //           "စားပွဲ ရွေးချယ်မည်",
// //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
// //         ),
// //         style: OutlinedButton.styleFrom(
// //           foregroundColor: primaryColor,
// //           side: const BorderSide(color: primaryColor, width: 1.4),
// //           padding: const EdgeInsets.symmetric(vertical: 14),
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(14),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // ===========================================================================
// //   // RESERVED TABLE CARD (table picked) -> shows table + "Change" button
// //   // ===========================================================================
// //   Widget _buildReservedTableCard() {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
// //       decoration: BoxDecoration(
// //         color: primaryColor.withOpacity(0.06),
// //         borderRadius: BorderRadius.circular(14),
// //         border: Border.all(color: primaryColor.withOpacity(0.4), width: 1.2),
// //       ),
// //       child: Row(
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(8),
// //             decoration: BoxDecoration(
// //               color: primaryColor.withOpacity(0.12),
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //             child: const Icon(
// //               Icons.event_seat_rounded,
// //               color: primaryColor,
// //               size: 20,
// //             ),
// //           ),
// //           const SizedBox(width: 12),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   "ရွေးထားသောစားပွဲ",
// //                   style: TextStyle(
// //                     fontSize: 11,
// //                     color: Colors.grey.shade600,
// //                     fontWeight: FontWeight.w500,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 2),
// //                 Text(
// //                   selectedSeatLabel ?? selectedSeatId ?? "-",
// //                   style: const TextStyle(
// //                     fontSize: 15,
// //                     fontWeight: FontWeight.bold,
// //                     color: primaryColor,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           TextButton(
// //             onPressed: _openSelectSeatPage,
// //             style: TextButton.styleFrom(
// //               foregroundColor: primaryColor,
// //               padding: const EdgeInsets.symmetric(horizontal: 10),
// //             ),
// //             child: const Text(
// //               "ပြောင်းမည်",
// //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildDottedDivider() {
// //     return LayoutBuilder(
// //       builder: (context, constraints) {
// //         final boxWidth = constraints.maxWidth;
// //         const dashWidth = 5.0;
// //         const dashHeight = 1.0;
// //         final dashCount = (boxWidth / (2 * dashWidth)).floor();
// //         return Flex(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           direction: Axis.horizontal,
// //           children: List.generate(dashCount, (_) {
// //             return SizedBox(
// //               width: dashWidth,
// //               height: dashHeight,
// //               child: DecoratedBox(
// //                 decoration: BoxDecoration(color: Colors.grey.shade300),
// //               ),
// //             );
// //           }),
// //         );
// //       },
// //     );
// //   }
// // }

// // // =============================================================================
// // // SELECT SEAT SCREEN
// // // =============================================================================
// // class SelectSeatScreen extends StatefulWidget {
// //   final String shopName;
// //   final List<Map<String, dynamic>> seats;
// //   final String? currentSeatId;
// //   const SelectSeatScreen({
// //     super.key,
// //     required this.shopName,
// //     required this.seats,
// //     this.currentSeatId,
// //   });
// //   @override
// //   State<SelectSeatScreen> createState() => _SelectSeatScreenState();
// // }

// // class _SelectSeatScreenState extends State<SelectSeatScreen> {
// //   static const Color primaryColor = Color(0xff117992);
// //   String? selectedSeatId;
// //   @override
// //   void initState() {
// //     super.initState();
// //     selectedSeatId = widget.currentSeatId;
// //   }

// //   Map<String, dynamic>? get _selectedSeat {
// //     for (var s in widget.seats) {
// //       if (s["id"] == selectedSeatId) return s;
// //     }
// //     return null;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xffF6F8FC),
// //       body: Column(
// //         children: [
// //           /// CUSTOM GRADIENT HEADER (spaced below the status bar)
// //           Container(
// //             decoration: const BoxDecoration(
// //               gradient: LinearGradient(
// //                 colors: [Color(0xff117992), Color(0xff0D5B6E)],
// //                 begin: Alignment.topLeft,
// //                 end: Alignment.bottomRight,
// //               ),
// //             ),
// //             child: SafeArea(
// //               bottom: false,
// //               child: Padding(
// //                 padding: const EdgeInsets.fromLTRB(16, 44, 16, 14),
// //                 child: Row(
// //                   children: [
// //                     Material(
// //                       color: Colors.white.withOpacity(0.15),
// //                       shape: const CircleBorder(),
// //                       child: InkWell(
// //                         customBorder: const CircleBorder(),
// //                         onTap: () => Navigator.pop(context),
// //                         child: const SizedBox(
// //                           width: 40,
// //                           height: 40,
// //                           child: Icon(
// //                             Icons.arrow_back_ios_new_rounded,
// //                             color: Colors.white,
// //                             size: 16,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(width: 14),
// //                     const Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             "စားပွဲ ရွေးချယ်ပါ",
// //                             style: TextStyle(
// //                               color: Colors.white,
// //                               fontSize: 19,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                           SizedBox(height: 2),
// //                           Text(
// //                             "ဆိုင်တွင်ထိုင်စားရန် စားပွဲရွေးပါ",
// //                             style: TextStyle(
// //                               color: Colors.white70,
// //                               fontSize: 11,
// //                               fontWeight: FontWeight.w500,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),

// //           /// BODY
// //           Expanded(
// //             child: SingleChildScrollView(
// //               physics: const BouncingScrollPhysics(),
// //               padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
// //               child: Container(
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius: BorderRadius.circular(20),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.black.withOpacity(0.03),
// //                       blurRadius: 10,
// //                       offset: const Offset(0, 2),
// //                     ),
// //                   ],
// //                 ),
// //                 padding: const EdgeInsets.all(18),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     const Text(
// //                       "စားပွဲ အပြင်အဆင်",
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 18,
// //                         color: Color(0xff1E293B),
// //                       ),
// //                     ),
// //                     const SizedBox(height: 4),
// //                     Text(
// //                       "စားပွဲတစ်ခုစီတွင် ထိုင်ခုံ ၄ ခုံ ပါဝင်မှာ ဖြစ်ပါသည်။",
// //                       style: TextStyle(
// //                         fontSize: 12,
// //                         color: Colors.grey.shade500,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 16),

// //                     /// COUNTER banner
// //                     Container(
// //                       width: double.infinity,
// //                       padding: const EdgeInsets.symmetric(vertical: 10),
// //                       decoration: BoxDecoration(
// //                         color: Colors.grey.shade100,
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                       child: Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Icon(
// //                             Icons.point_of_sale_rounded,
// //                             size: 16,
// //                             color: Colors.grey.shade600,
// //                           ),
// //                           const SizedBox(width: 6),
// //                           Text(
// //                             "ကောင်တာ",
// //                             style: TextStyle(
// //                               fontSize: 13,
// //                               fontWeight: FontWeight.w700,
// //                               color: Colors.grey.shade600,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     const SizedBox(height: 18),

// //                     /// TABLE GRID (4 per row, like the shop-owner layout)
// //                     GridView.builder(
// //                       shrinkWrap: true,
// //                       physics: const NeverScrollableScrollPhysics(),
// //                       itemCount: widget.seats.length,
// //                       gridDelegate:
// //                           const SliverGridDelegateWithFixedCrossAxisCount(
// //                             crossAxisCount: 4,
// //                             mainAxisSpacing: 12,
// //                             crossAxisSpacing: 12,
// //                             childAspectRatio: 0.9,
// //                           ),
// //                       itemBuilder: (context, index) {
// //                         final seat = widget.seats[index];
// //                         return _buildSeatCard(seat);
// //                       },
// //                     ),
// //                     const SizedBox(height: 18),
// //                     const Divider(height: 1),
// //                     const SizedBox(height: 14),

// //                     /// LEGEND
// //                     Wrap(
// //                       spacing: 16,
// //                       runSpacing: 8,
// //                       children: [
// //                         _buildLegendItem(
// //                           color: const Color(0xff34D399),
// //                           label: "အားလပ်",
// //                         ),
// //                         _buildLegendItem(
// //                           color: const Color(0xffF87171),
// //                           label: "လူရှိ",
// //                         ),
// //                         _buildLegendItem(
// //                           color: const Color(0xffFBBF24),
// //                           label: "မှာထား",
// //                         ),
// //                         _buildLegendItem(
// //                           color: Colors.grey.shade400,
// //                           label: "ပိတ်ထား",
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),

// //       /// BOTTOM CONFIRM BAR
// //       bottomNavigationBar: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
// //           child: SizedBox(
// //             width: double.infinity,
// //             height: 52,
// //             child: ElevatedButton(
// //               onPressed: selectedSeatId == null
// //                   ? null
// //                   : () {
// //                       final seat = _selectedSeat;
// //                       Navigator.pop(context, {
// //                         "id": selectedSeatId!,
// //                         "label": (seat?["label"] ?? selectedSeatId).toString(),
// //                       });
// //                     },
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: primaryColor,
// //                 disabledBackgroundColor: Colors.grey.shade400,
// //                 elevation: 2,
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(16),
// //                 ),
// //               ),
// //               child: Text(
// //                 selectedSeatId == null
// //                     ? "စားပွဲ ရွေးချယ်ပါ"
// //                     : "${_selectedSeat?["label"] ?? selectedSeatId} ကို အတည်ပြုမည်",
// //                 style: const TextStyle(
// //                   color: Colors.white,
// //                   fontWeight: FontWeight.bold,
// //                   fontSize: 15,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildSeatCard(Map<String, dynamic> seat) {
// //     final String seatId = seat["id"];
// //     final String label = seat["label"] ?? seatId;
// //     final String status = seat["status"];
// //     final bool isSelected = selectedSeatId == seatId;
// //     final bool isAvailable = status == "available";
// //     Color bgColor;
// //     Color borderColor;
// //     Color iconColor;
// //     Color textColor;
// //     Color statusColor;
// //     String statusText;
// //     if (isSelected) {
// //       bgColor = primaryColor;
// //       borderColor = primaryColor;
// //       iconColor = Colors.white;
// //       textColor = Colors.white;
// //       statusColor = Colors.white;
// //       statusText = "ရွေးထားသည်";
// //     } else {
// //       switch (status) {
// //         case "occupied":
// //           bgColor = const Color(0xffFEE2E2);
// //           borderColor = const Color(0xffFCA5A5);
// //           iconColor = const Color(0xffEF4444);
// //           textColor = const Color(0xff1E293B);
// //           statusColor = const Color(0xffEF4444);
// //           statusText = "လူရှိ";
// //           break;
// //         case "reserved":
// //           bgColor = const Color(0xffFEF3C7);
// //           borderColor = const Color(0xffFCD34D);
// //           iconColor = const Color(0xffF59E0B);
// //           textColor = const Color(0xff1E293B);
// //           statusColor = const Color(0xffD97706);
// //           statusText = "မှာထား";
// //           break;
// //         case "disabled":
// //           bgColor = Colors.grey.shade100;
// //           borderColor = Colors.grey.shade200;
// //           iconColor = Colors.grey.shade400;
// //           textColor = Colors.grey.shade400;
// //           statusColor = Colors.grey.shade400;
// //           statusText = "ပိတ်ထား";
// //           break;
// //         case "available":
// //         default:
// //           bgColor = const Color(0xffECFDF5);
// //           borderColor = const Color(0xffA7F3D0);
// //           iconColor = const Color(0xff10B981);
// //           textColor = const Color(0xff1E293B);
// //           statusColor = const Color(0xff10B981);
// //           statusText = "အားလပ်";
// //           break;
// //       }
// //     }
// //     return GestureDetector(
// //       onTap: isAvailable
// //           ? () {
// //               setState(() {
// //                 selectedSeatId = isSelected ? null : seatId;
// //               });
// //             }
// //           : null,
// //       child: AnimatedContainer(
// //         duration: const Duration(milliseconds: 160),
// //         padding: const EdgeInsets.all(6),
// //         decoration: BoxDecoration(
// //           color: bgColor,
// //           borderRadius: BorderRadius.circular(14),
// //           border: Border.all(color: borderColor, width: 1.4),
// //         ),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Stack(
// //               clipBehavior: Clip.none,
// //               children: [
// //                 Icon(
// //                   Icons.table_restaurant_rounded,
// //                   size: 26,
// //                   color: iconColor,
// //                 ),
// //                 Positioned(
// //                   right: -15,
// //                   top: -2,
// //                   child: Container(
// //                     width: 7,
// //                     height: 7,
// //                     decoration: BoxDecoration(
// //                       color: statusColor,
// //                       shape: BoxShape.circle,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 4),
// //             Text(
// //               seatId,
// //               maxLines: 1,
// //               overflow: TextOverflow.ellipsis,
// //               style: TextStyle(
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 13,
// //                 color: textColor,
// //               ),
// //             ),
// //             const SizedBox(height: 1),
// //             Text(
// //               statusText,
// //               maxLines: 1,
// //               overflow: TextOverflow.ellipsis,
// //               style: TextStyle(
// //                 fontSize: 9,
// //                 fontWeight: FontWeight.w600,
// //                 color: statusColor,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildLegendItem({required Color color, required String label}) {
// //     return Row(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         Container(
// //           width: 10,
// //           height: 10,
// //           decoration: BoxDecoration(color: color, shape: BoxShape.circle),
// //         ),
// //         const SizedBox(width: 6),
// //         Text(
// //           label,
// //           style: TextStyle(
// //             fontSize: 12,
// //             fontWeight: FontWeight.w500,
// //             color: Colors.grey.shade600,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // class ReceiptClipper extends CustomClipper<Path> {
// //   @override
// //   Path getClip(Size size) {
// //     Path path = Path();
// //     path.lineTo(0, size.height - 12);
// //     const double waveWidth = 8.0;
// //     const double waveHeight = 8.0;
// //     double x = 0;
// //     while (x < size.width) {
// //       x += waveWidth;
// //       path.lineTo(x - (waveWidth / 2), size.height - 12 + waveHeight);
// //       path.lineTo(x, size.height - 12);
// //     }
// //     path.lineTo(size.width, 0);
// //     path.close();
// //     return path;
// //   }

// //   @override
// //   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// // }

// import 'package:flutter/material.dart';
// import 'package:smartcanteen/service/api_service.dart';
// import 'package:smartcanteen/view/transfer_screen.dart';

// /// ============================================================================
// /// MAIN ADD TO CART / ORDER CONFIRMATION SHEET WIDGET
// /// ============================================================================
// class AddToCartScreen extends StatefulWidget {
//   final int shopId;
//   final String shopName;
//   final int currentBalance;
//   final List<Map<String, dynamic>> menuItems;
//   final VoidCallback onConfirmOrder;

//   const AddToCartScreen({
//     super.key,
//     required this.shopId,
//     required this.shopName,
//     required this.currentBalance,
//     required this.menuItems,
//     required this.onConfirmOrder, required void Function(Map<String, dynamic> item) onAddToCart, required void Function(Map<String, dynamic> item) onRemoveFromCart,
//   });

//   @override
//   State<AddToCartScreen> createState() => _AddToCartScreenState();
// }

// class _AddToCartScreenState extends State<AddToCartScreen> {
//   static const Color primaryColor = Color(0xff117992);
//   final TextEditingController _noteController = TextEditingController();

//   String orderType = "dine-in"; // "dine-in" or "takeaway"
//   String? selectedSeatId;
//   String? selectedSeatLabel;

//   @override
//   void dispose() {
//     _noteController.dispose();
//     super.dispose();
//   }

//   /// Calculates total points/price for items currently in cart
//   int get totalPoints {
//     int total = 0;
//     for (var item in widget.menuItems) {
//       final qty = (item["cartQuantity"] as int?) ?? 0;
//       final price = (item["rawPrice"] ?? item["price"] ?? 0) as num;
//       total += (qty * price).toInt();
//     }
//     return total;
//   }

//   /// Filters out items with 0 quantity
//   List<Map<String, dynamic>> get cartItems {
//     return widget.menuItems
//         .where((item) => ((item["cartQuantity"] as int?) ?? 0) > 0)
//         .toList();
//   }

//   /// Checks whether the user is ready to place the order
//   bool get _isReadyToOrder {
//     if (cartItems.isEmpty) return false;
//     if (orderType == "dine-in" && selectedSeatId == null) return false;
//     return true;
//   }

//   /// Opens the integrated SelectSeatScreen and awaits result
//   Future<void> _openSelectSeatPage() async {
//     final result = await Navigator.push<Map<String, String>?>(
//       context,
//       MaterialPageRoute(
//         builder: (context) => SelectSeatScreen(
//           shopName: widget.shopName,
//           shopId: widget.shopId,
//           currentSeatId: selectedSeatId,
//         ),
//       ),
//     );

//     if (result != null) {
//       setState(() {
//         selectedSeatId = result["id"];
//         selectedSeatLabel = result["label"];
//       });
//     }
//   }

//   Widget _buildDottedDivider() {
//     return Row(
//       children: List.generate(
//         30,
//         (index) => Expanded(
//           child: Container(
//             color: index % 2 == 0 ? Colors.transparent : Colors.grey.shade300,
//             height: 1,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             /// ORDER TYPE SELECTOR (Dine-In / Takeaway)
//             Row(
//               children: [
//                 Expanded(
//                   child: ChoiceChip(
//                     label: const Center(child: Text("ဆိုင်တွင်ထိုင်စား")),
//                     selected: orderType == "dine-in",
//                     selectedColor: primaryColor.withOpacity(0.15),
//                     labelStyle: TextStyle(
//                       color: orderType == "dine-in" ? primaryColor : Colors.black87,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     onSelected: (selected) {
//                       if (selected) setState(() => orderType = "dine-in");
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: ChoiceChip(
//                     label: const Center(child: Text("ပါဆယ်")),
//                     selected: orderType == "takeaway",
//                     selectedColor: primaryColor.withOpacity(0.15),
//                     labelStyle: TextStyle(
//                       color: orderType == "takeaway" ? primaryColor : Colors.black87,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     onSelected: (selected) {
//                       if (selected) {
//                         setState(() {
//                           orderType = "takeaway";
//                           selectedSeatId = null;
//                           selectedSeatLabel = null;
//                         });
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),

//             /// TABLE SELECTION BUTTON (Available if Dine-In selected)
//             if (orderType == "dine-in") ...[
//               const SizedBox(height: 12),
//               OutlinedButton.icon(
//                 onPressed: _openSelectSeatPage,
//                 icon: const Icon(Icons.table_restaurant_rounded, color: primaryColor),
//                 label: Text(
//                   selectedSeatLabel != null
//                       ? "စားပွဲ: $selectedSeatLabel (ပြောင်းရန် နှိပ်ပါ)"
//                       : "စားပွဲ ခုံရွေးချယ်ပါ",
//                   style: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
//                 ),
//                 style: OutlinedButton.styleFrom(
//                   minimumSize: const Size(double.infinity, 45),
//                   side: const BorderSide(color: primaryColor),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//               ),
//             ],

//             /// OPTIONAL NOTE FIELD
//             if (cartItems.isNotEmpty) ...[
//               const SizedBox(height: 16),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.edit_note_rounded,
//                       size: 16,
//                       color: Colors.grey.shade600,
//                     ),
//                     const SizedBox(width: 6),
//                     Text(
//                       "မှတ်ချက် (ရွေးချယ်ရန်)",
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey.shade700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _noteController,
//                 maxLines: 2,
//                 minLines: 1,
//                 textInputAction: TextInputAction.done,
//                 style: const TextStyle(
//                   fontSize: 13,
//                   color: Color(0xff1E293B),
//                 ),
//                 decoration: InputDecoration(
//                   hintText: "ဥပမာ - အစပ်နည်းနည်း၊ ကြက်ဥ ပိုထည့်ပေးပါ...",
//                   hintStyle: TextStyle(
//                     color: Colors.grey.shade400,
//                     fontSize: 12,
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey.shade50,
//                   isDense: true,
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 10,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: const BorderSide(
//                       color: primaryColor,
//                       width: 1.4,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//             const SizedBox(height: 20),
//             _buildDottedDivider(),
//             const SizedBox(height: 16),

//             /// ORDER TYPE SUMMARY ROW
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "မှာယူပုံ",
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//                 Text(
//                   orderType == "dine-in"
//                       ? (selectedSeatId != null
//                           ? "ဆိုင်တွင်ထိုင်စား · ${selectedSeatLabel ?? selectedSeatId}"
//                           : "ဆိုင်တွင်ထိုင်စား")
//                       : "ပါဆယ်",
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.bold,
//                     color: primaryColor,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),

//             /// TOTAL POINTS DISPLAY
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "စုစုပေါင်း ပွိုင့်",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w900,
//                     fontSize: 15,
//                     color: Color(0xff1E293B),
//                   ),
//                 ),
//                 Text(
//                   "$totalPoints ပွိုင့်",
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w900,
//                     fontSize: 20,
//                     color: primaryColor,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),

//             /// DINE-IN WARNING HINT (if table is not yet chosen)
//             if (orderType == "dine-in" &&
//                 selectedSeatId == null &&
//                 cartItems.isNotEmpty) ...[
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 14,
//                   vertical: 10,
//                 ),
//                 decoration: BoxDecoration(
//                   color: const Color(0xffFEF3C7),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.info_outline_rounded,
//                       size: 18,
//                       color: Color(0xffD97706),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         "အော်ဒါမတင်မီ စားပွဲ ရွေးချယ်ပေးပါ။",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.orange.shade900,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 12),
//             ],

//             /// CONFIRM ORDER BUTTON
//             SizedBox(
//               width: double.infinity,
//               height: 52,
//               child: ElevatedButton(
//                 onPressed: !_isReadyToOrder
//                     ? null
//                     : () {
//                         // Prepare payloads
//                         final selectedCartItems = widget.menuItems
//                             .where((item) => ((item["cartQuantity"] as int?) ?? 0) > 0)
//                             .map((item) {
//                           final dynamic rawId =
//                               item["id"] ?? item["menu_id"] ?? item["menu_item_id"];
//                           final dynamic rawQty = item["cartQuantity"] ?? item["quantity"];

//                           return {
//                             "menu_id": rawId,
//                             "id": rawId,
//                             "quantity": rawQty,
//                             "cartQuantity": rawQty,
//                             "name": item["name"] ?? "",
//                             "price": item["rawPrice"] ?? item["price"] ?? 0,
//                           };
//                         }).toList();

//                         final capturedTotal = totalPoints;
//                         final String orderNote = _noteController.text.trim();
//                         final String capturedOrderType = orderType;
//                         final String? capturedSeat = selectedSeatId;
//                         final navigator = Navigator.of(context);

//                         // Pop bottom sheet
//                         navigator.pop();

//                         // Navigate to TransferScreen
//                         Future.microtask(() {
//                           navigator.push(
//                             MaterialPageRoute(
//                               builder: (_) => TransferScreen(
//                                 shopId: widget.shopId,
//                                 currentBalance: widget.currentBalance,
//                                 initialRecipient: widget.shopName,
//                                 initialAmount: capturedTotal,
//                                 readOnlyTransfer: true,
//                                 cartItems: selectedCartItems,
//                                 orderType: capturedOrderType,
//                                 selectedSeatId: capturedSeat,
//                                 note: orderNote,
//                                 onTransferCompleted: (amount, recipient) {
//                                   widget.onConfirmOrder();
//                                 },
//                               ),
//                             ),
//                           );
//                         });
//                       },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: primaryColor,
//                   disabledBackgroundColor: Colors.grey.shade400,
//                   elevation: 2,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 child: Text(
//                   cartItems.isEmpty
//                       ? "ဈေးဝယ်ခြင်း ဗလာဖြစ်နေသည်"
//                       : "အော်ဒါတင်မည် ($totalPoints ပွိုင့်)",
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// ============================================================================
// /// DYNAMIC TABLE SELECTOR SCREEN (API FETCHING)
// /// ============================================================================
// class SelectSeatScreen extends StatefulWidget {
//   final String shopName;
//   final int shopId;
//   final String? currentSeatId;

//   const SelectSeatScreen({
//     super.key,
//     required this.shopName,
//     required this.shopId,
//     this.currentSeatId,
//   });

//   @override
//   State<SelectSeatScreen> createState() => _SelectSeatScreenState();
// }

// class _SelectSeatScreenState extends State<SelectSeatScreen> {
//   static const Color primaryColor = Color(0xff117992);
//   final ApiService _apiService = ApiService();

//   List<Map<String, dynamic>> seats = [];
//   bool isLoading = true;
//   String? errorMessage;

//   int? selectedTableId;
//   String? selectedTableNumber;

//   @override
//   void initState() {
//     super.initState();
//     _fetchTables();
//   }

//   Future<void> _fetchTables() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });

//     try {
//       final tableData = await _apiService.getShopTables(widget.shopId);
//       setState(() {
//         seats = tableData.where((item) => (item["is_active"] ?? 1) == 1).toList();
//         isLoading = false;

//         // Auto-select existing seat if already passed
//         if (widget.currentSeatId != null) {
//           final found = seats.firstWhere(
//             (s) => s["food_tables_id"].toString() == widget.currentSeatId,
//             orElse: () => {},
//           );
//           if (found.isNotEmpty) {
//             selectedTableId = found["food_tables_id"];
//             selectedTableNumber = found["table_number"];
//           }
//         }
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = "စားပွဲခုံများ ရယူရာတွင် အဆင်မပြေပါ";
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF6F8FC),
//       body: Column(
//         children: [
//           /// HEADER
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xff117992), Color(0xff0D5B6E)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: SafeArea(
//               bottom: false,
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(16, 20, 16, 14),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     const SizedBox(width: 8),
//                     const Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "စားပွဲ ရွေးချယ်ပါ",
//                             style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             "ဆိုင်တွင်ထိုင်စားရန် စားပွဲရွေးပါ",
//                             style: TextStyle(color: Colors.white70, fontSize: 11),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           /// SEAT GRID DISPLAY
//           Expanded(
//             child: isLoading
//                 ? const Center(child: CircularProgressIndicator(color: primaryColor))
//                 : errorMessage != null
//                     ? Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(errorMessage!, style: TextStyle(color: Colors.grey.shade600)),
//                             const SizedBox(height: 12),
//                             ElevatedButton(
//                               onPressed: _fetchTables,
//                               style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
//                               child: const Text("ထပ်မံကြိုးစားမည်", style: TextStyle(color: Colors.white)),
//                             )
//                           ],
//                         ),
//                       )
//                     : SingleChildScrollView(
//                         padding: const EdgeInsets.all(20),
//                         child: Container(
//                           padding: const EdgeInsets.all(18),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               /// COUNTER BAR
//                               Container(
//                                 width: double.infinity,
//                                 padding: const EdgeInsets.symmetric(vertical: 10),
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade100,
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(Icons.point_of_sale_rounded, size: 16, color: Colors.grey.shade600),
//                                     const SizedBox(width: 6),
//                                     Text(
//                                       "ကောင်တာ",
//                                       style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.grey.shade600),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 18),

//                               /// DYNAMIC GRID
//                               GridView.builder(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemCount: seats.length,
//                                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 4,
//                                   mainAxisSpacing: 12,
//                                   crossAxisSpacing: 12,
//                                   childAspectRatio: 0.85,
//                                 ),
//                                 itemBuilder: (context, index) {
//                                   return _buildSeatCard(seats[index]);
//                                 },
//                               ),
//                               const SizedBox(height: 18),
//                               const Divider(height: 1),
//                               const SizedBox(height: 14),

//                               /// STATUS LEGEND
//                               Wrap(
//                                 spacing: 16,
//                                 runSpacing: 8,
//                                 children: [
//                                   _buildLegendItem(color: const Color(0xff10B981), label: "အားလပ်"),
//                                   _buildLegendItem(color: const Color(0xffF59E0B), label: "မှာထား"),
//                                   _buildLegendItem(color: const Color(0xffEF4444), label: "လူရှိ"),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//           ),
//         ],
//       ),

//       /// CONFIRM SELECTION FOOTER
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
//           child: SizedBox(
//             width: double.infinity,
//             height: 52,
//             child: ElevatedButton(
//               onPressed: selectedTableId == null
//                   ? null
//                   : () {
//                       Navigator.pop(context, {
//                         "id": selectedTableId.toString(),
//                         "label": selectedTableNumber ?? "",
//                       });
//                     },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: primaryColor,
//                 disabledBackgroundColor: Colors.grey.shade400,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//               ),
//               child: Text(
//                 selectedTableNumber == null ? "စားပွဲ ရွေးချယ်ပါ" : "$selectedTableNumber ကို အတည်ပြုမည်",
//                 style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSeatCard(Map<String, dynamic> table) {
//     final int tableId = table["food_tables_id"];
//     final String tableNumber = table["table_number"] ?? "";
//     final String status = table["status"] ?? "available";

//     final bool isSelected = selectedTableId == tableId;
//     final bool isAvailable = status == "available";

//     Color bgColor;
//     Color borderColor;
//     Color iconColor;
//     Color textColor;
//     Color statusColor;
//     String statusText;

//     if (isSelected) {
//       bgColor = primaryColor;
//       borderColor = primaryColor;
//       iconColor = Colors.white;
//       textColor = Colors.white;
//       statusColor = Colors.white;
//       statusText = "ရွေးထားသည်";
//     } else {
//       switch (status) {
//         case "reserved":
//           bgColor = const Color(0xffFEF3C7);
//           borderColor = const Color(0xffFCD34D);
//           iconColor = const Color(0xffF59E0B);
//           textColor = const Color(0xff1E293B);
//           statusColor = const Color(0xffD97706);
//           statusText = "မှာထား";
//           break;
//         case "occupied":
//           bgColor = const Color(0xffFEE2E2);
//           borderColor = const Color(0xffFCA5A5);
//           iconColor = const Color(0xffEF4444);
//           textColor = const Color(0xff1E293B);
//           statusColor = const Color(0xffEF4444);
//           statusText = "လူရှိ";
//           break;
//         case "available":
//         default:
//           bgColor = const Color(0xffECFDF5);
//           borderColor = const Color(0xffA7F3D0);
//           iconColor = const Color(0xff10B981);
//           textColor = const Color(0xff1E293B);
//           statusColor = const Color(0xff10B981);
//           statusText = "အားလပ်";
//           break;
//       }
//     }

//     return GestureDetector(
//       onTap: isAvailable
//           ? () {
//               setState(() {
//                 if (isSelected) {
//                   selectedTableId = null;
//                   selectedTableNumber = null;
//                 } else {
//                   selectedTableId = tableId;
//                   selectedTableNumber = tableNumber;
//                 }
//               });
//             }
//           : null,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 160),
//         padding: const EdgeInsets.all(6),
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: borderColor, width: 1.4),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.table_restaurant_rounded, size: 24, color: iconColor),
//             const SizedBox(height: 4),
//             Text(
//               tableNumber,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: textColor),
//             ),
//             const SizedBox(height: 1),
//             Text(
//               statusText,
//               style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: statusColor),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLegendItem({required Color color, required String label}) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
//         const SizedBox(width: 6),
//         Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:smartcanteen/service/api_service.dart';
import 'package:smartcanteen/view/transfer_screen.dart';

class AddToCartScreen extends StatefulWidget {
  final int shopId;
  final String shopName;
  final List<Map<String, dynamic>> seats;
  final List<Map<String, dynamic>> menuItems;
  final Function(Map<String, dynamic>) onAddToCart;
  final Function(Map<String, dynamic>) onRemoveFromCart;
  final VoidCallback onConfirmOrder;
  final int currentBalance;

  const AddToCartScreen({
    super.key,
    required this.shopName,
    this.seats = const [],
    required this.menuItems,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    required this.onConfirmOrder,
    required this.currentBalance,
    required this.shopId,
  });

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  static const Color primaryColor = Color(0xff117992);

  // ORDER TYPE STATE: "dine-in" (reserve table) or "takeaway"
  String orderType = "takeaway";
  dynamic selectedSeatId; // Stores food_tables_id
  String? selectedSeatLabel; // Stores table_number (e.g. "T-02")

  // OPTIONAL NOTE STATE
  final TextEditingController _noteController = TextEditingController();

  int _parsePrice(dynamic priceVal) {
    if (priceVal == null) return 0;
    if (priceVal is int) return priceVal;
    if (priceVal is double) return priceVal.toInt();
    final numStr = priceVal.toString().replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(numStr) ?? 0;
  }

  int get totalPoints {
    int total = 0;
    for (var item in widget.menuItems) {
      final int qty = (item["cartQuantity"] as int?) ?? 0;
      if (qty > 0) {
        total += _parsePrice(item["rawPrice"] ?? item["price"]) * qty;
      }
    }
    return total;
  }

  bool get _isReadyToOrder {
    if (totalPoints == 0) return false;
    if (orderType == "dine-in" && selectedSeatId == null) return false;
    return true;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  // Navigate to the separate Select Seat page and wait for the result.
  Future<void> _openSelectSeatPage() async {
    final result = await Navigator.push<Map<String, dynamic>?>(
      context,
      MaterialPageRoute(
        builder: (context) => SelectSeatScreen(
          shopName: widget.shopName,
          shopId: widget.shopId,
          currentSeatId: selectedSeatId,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        selectedSeatId = result["id"];
        selectedSeatLabel = result["label"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = widget.menuItems
        .where((item) => (item["cartQuantity"] as int? ?? 0) > 0)
        .toList();

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// RECEIPT PAPER BODY WITH ZIGZAG CLIPPER
            ClipPath(
              clipper: ReceiptClipper(),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// RECEIPT HEADER
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.receipt_long_rounded,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.shopName.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        letterSpacing: 1.5,
                        color: Color(0xff1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "အော်ဒါ အနှစ်ချုပ်",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 18),

                    /// ORDER TYPE SELECTOR (Dine-in / Take Away)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "မှာယူပုံ ရွေးချယ်ပါ",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildOrderTypeCard(
                          type: "dine-in",
                          icon: Icons.event_seat_rounded,
                          title: "ဆိုင်တွင်ထိုင်စား",
                        ),
                        const SizedBox(width: 10),
                        _buildOrderTypeCard(
                          type: "takeaway",
                          icon: Icons.shopping_bag_rounded,
                          title: "ပါဆယ်",
                        ),
                      ],
                    ),

                    /// TABLE RESERVATION ROW (only when dine-in)
                    if (orderType == "dine-in") ...[
                      const SizedBox(height: 14),
                      selectedSeatId == null
                          ? _buildSelectTableButton()
                          : _buildReservedTableCard(),
                    ],
                    const SizedBox(height: 20),
                    _buildDottedDivider(),
                    const SizedBox(height: 16),

                    /// CART ITEMS LIST
                    if (cartItems.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Column(
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              size: 40,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "ဈေးဝယ်ခြင်း ဗလာဖြစ်နေသည်",
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          final int qty = item["cartQuantity"];
                          final int unitPrice = _parsePrice(item["rawPrice"] ?? item["price"]);
                          final int itemTotalPts = unitPrice * qty;
                          return Row(
                            children: [
                              /// ITEM DETAILS
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["name"] ?? "",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Color(0xff1E293B),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "တစ်ခုလျှင် $unitPrice ပွိုင့်",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// QUANTITY COUNT
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "x$qty",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),

                              /// TOTAL POINTS FOR ITEM
                              SizedBox(
                                width: 64,
                                child: Text(
                                  "$itemTotalPts ပွိုင့်",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                    color: Color(0xff1E293B),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                    /// OPTIONAL NOTE FIELD
                    if (cartItems.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit_note_rounded,
                              size: 16,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "မှတ်ချက် (ရွေးချယ်ရန်)",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _noteController,
                        maxLines: 2,
                        minLines: 1,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xff1E293B),
                        ),
                        decoration: InputDecoration(
                          hintText:
                              "ဥပမာ - အစပ်နည်းနည်း၊ ကြက်ဥ ပိုထည့်ပေးပါ...",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 12,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: primaryColor,
                              width: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    _buildDottedDivider(),
                    const SizedBox(height: 16),

                    /// ORDER TYPE SUMMARY ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "မှာယူပုံ",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          orderType == "dine-in"
                              ? (selectedSeatLabel != null
                                  ? "ဆိုင်တွင်ထိုင်စား · $selectedSeatLabel"
                                  : "ဆိုင်တွင်ထိုင်စား")
                              : "ပါဆယ်",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    /// TOTAL POINTS DISPLAY
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "စုစုပေါင်း ပွိုင့်",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: Color(0xff1E293B),
                          ),
                        ),
                        Text(
                          "$totalPoints ပွိုင့်",
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// DINE-IN HINT (if table not yet picked)
            if (orderType == "dine-in" &&
                selectedSeatId == null &&
                cartItems.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffFEF3C7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 18,
                      color: Color(0xffD97706),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "အော်ဒါမတင်မီ စားပွဲ ရွေးချယ်ပေးပါ။ အော်ဒါတင်ပြီး မိနစ်30အတွင်း pickupမလုပ်ပါက auto takeaway ဖြစ်မည်။",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            /// CONFIRM ORDER / PLACE ORDER BUTTON
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: !_isReadyToOrder
                    ? null
                    : () {
                        final selectedCartItems = widget.menuItems
                            .where((item) => ((item["cartQuantity"] as int?) ?? 0) > 0)
                            .map((item) {
                          final dynamic rawId = item["id"] ?? item["menu_id"] ?? item["menu_item_id"];
                          final dynamic rawQty = item["cartQuantity"] ?? item["quantity"];

                          return {
                            "menu_id": rawId,
                            "id": rawId,
                            "quantity": rawQty,
                            "cartQuantity": rawQty,
                            "name": item["name"] ?? "",
                            "price": item["rawPrice"] ?? item["price"] ?? 0,
                          };
                        }).toList();

                        final capturedTotal = totalPoints;
                        final String orderNote = _noteController.text.trim();
                        final String capturedOrderType = orderType;
                        final String? capturedSeat = selectedSeatId?.toString();
                        final navigator = Navigator.of(context);

                        // Dismiss AddToCart Bottom Sheet
                        Navigator.pop(context);

                        // Open TransferScreen with carried parameters
                        Future.microtask(() {
                          navigator.push(
                            MaterialPageRoute(
                              builder: (_) => TransferScreen(
                                shopId: widget.shopId,
                                currentBalance: widget.currentBalance,
                                initialRecipient: widget.shopName,
                                initialAmount: capturedTotal,
                                readOnlyTransfer: true,
                                cartItems: selectedCartItems,
                                orderType: capturedOrderType,
                                selectedSeatId: capturedSeat,
                                note: orderNote,
                                onTransferCompleted: (amount, recipient) {
                                  widget.onConfirmOrder();
                                },
                              ),
                            ),
                          );
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  disabledBackgroundColor: Colors.grey.shade400,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  cartItems.isEmpty
                      ? "ဈေးဝယ်ခြင်း ဗလာဖြစ်နေသည်"
                      : "အော်ဒါတင်မည် ($totalPoints ပွိုင့်)",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderTypeCard({
    required String type,
    required IconData icon,
    required String title,
  }) {
    final bool isSelected = orderType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            orderType = type;
            if (type == "takeaway") {
              selectedSeatId = null;
              selectedSeatLabel = null;
            }
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor.withOpacity(0.08) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? primaryColor : Colors.grey.shade300,
              width: isSelected ? 1.6 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? primaryColor : Colors.grey.shade500,
                size: 26,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: isSelected ? primaryColor : const Color(0xff1E293B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectTableButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: _openSelectSeatPage,
        icon: const Icon(Icons.event_seat_rounded, size: 18),
        label: const Text(
          "စားပွဲ ရွေးချယ်မည်",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 1.4),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  Widget _buildReservedTableCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primaryColor.withOpacity(0.4), width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.event_seat_rounded,
              color: primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ရွေးထားသောစားပွဲ",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  selectedSeatLabel ?? selectedSeatId.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: _openSelectSeatPage,
            style: TextButton.styleFrom(
              foregroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            child: const Text(
              "ပြောင်းမည်",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDottedDivider() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.maxWidth;
        const dashWidth = 5.0;
        const dashHeight = 1.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey.shade300),
              ),
            );
          }),
        );
      },
    );
  }
}

// =============================================================================
// SELECT SEAT SCREEN (FETCHES TABLES FROM API & FILTER AVAILABLE TABLES)
// =============================================================================
class SelectSeatScreen extends StatefulWidget {
  final String shopName;
  final int shopId;
  final dynamic currentSeatId;

  const SelectSeatScreen({
    super.key,
    required this.shopName,
    required this.shopId,
    this.currentSeatId,
  });

  @override
  State<SelectSeatScreen> createState() => _SelectSeatScreenState();
}

class _SelectSeatScreenState extends State<SelectSeatScreen> {
  static const Color primaryColor = Color(0xff117992);
  final ApiService _apiService = ApiService();

  List<Map<String, dynamic>> seats = [];
  bool isLoading = true;
  String? errorMessage;

  dynamic selectedSeatId;
  String? selectedSeatLabel;

  @override
  void initState() {
    super.initState();
    selectedSeatId = widget.currentSeatId;
    _fetchShopTables();
  }

  Future<void> _fetchShopTables() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final fetchedSeats = await _apiService.getShopTables(widget.shopId);
      setState(() {
        // Filter active tables only
        seats = fetchedSeats.where((s) => (s["is_active"] ?? 1) == 1).toList();
        isLoading = false;

        // Restore current seat label if already selected
        if (selectedSeatId != null) {
          final found = seats.firstWhere(
            (s) => s["food_tables_id"] == selectedSeatId || s["food_tables_id"].toString() == selectedSeatId.toString(),
            orElse: () => {},
          );
          if (found.isNotEmpty) {
            selectedSeatLabel = found["table_number"]?.toString();
          }
        }
      });
    } catch (e) {
      setState(() {
        errorMessage = "စားပွဲခုံများ ရယူရာတွင် အဆင်မပြေပါ";
        isLoading = false;
      });
    }
  }

  Map<String, dynamic>? get _selectedSeat {
    for (var s in seats) {
      if (s["food_tables_id"] == selectedSeatId || s["food_tables_id"].toString() == selectedSeatId.toString()) {
        return s;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),
      body: Column(
        children: [
          /// CUSTOM GRADIENT HEADER
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff117992), Color(0xff0D5B6E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 44, 16, 14),
                child: Row(
                  children: [
                    Material(
                      color: Colors.white.withOpacity(0.15),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => Navigator.pop(context),
                        child: const SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "စားပွဲ ရွေးချယ်ပါ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "ဆိုင်တွင်ထိုင်စားရန် စားပွဲရွေးပါ",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// BODY
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  )
                : errorMessage != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              errorMessage!,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: _fetchShopTables,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                              child: const Text(
                                "ထပ်မံကြိုးစားမည်",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "စားပွဲ အပြင်အဆင်",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xff1E293B),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "အားလပ်သော စားပွဲများကိုသာ ရွေးချယ်နိုင်ပါမည်။",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              const SizedBox(height: 16),

                              /// COUNTER BANNER
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.point_of_sale_rounded,
                                      size: 16,
                                      color: Colors.grey.shade600,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      "ကောင်တာ",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 18),

                              /// TABLE GRID
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: seats.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 0.9,
                                ),
                                itemBuilder: (context, index) {
                                  final seat = seats[index];
                                  return _buildSeatCard(seat);
                                },
                              ),
                              const SizedBox(height: 18),
                              const Divider(height: 1),
                              const SizedBox(height: 14),

                              /// LEGEND
                              Wrap(
                                spacing: 16,
                                runSpacing: 8,
                                children: [
                                  _buildLegendItem(
                                    color: const Color(0xff34D399),
                                    label: "အားလပ်",
                                  ),
                                  // _buildLegendItem(
                                  //   color: const Color(0xffF87171),
                                  //   label: "လူရှိ",
                                  // ),
                                  _buildLegendItem(
                                    color: const Color(0xffFBBF24),
                                    label: "မှာထား",
                                  ),
                                  // _buildLegendItem(
                                  //   color: Colors.grey.shade400,
                                  //   label: "ပိတ်ထား",
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
          ),
        ],
      ),

      /// BOTTOM CONFIRM BUTTON
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: selectedSeatId == null
                  ? null
                  : () {
                      final seat = _selectedSeat;
                      Navigator.pop(context, {
                        "id": selectedSeatId,
                        "label": (seat?["table_number"] ?? selectedSeatLabel ?? selectedSeatId).toString(),
                      });
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                disabledBackgroundColor: Colors.grey.shade400,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                selectedSeatId == null
                    ? "စားပွဲ ရွေးချယ်ပါ"
                    : "${_selectedSeat?["table_number"] ?? selectedSeatLabel ?? selectedSeatId} ကို အတည်ပြုမည်",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeatCard(Map<String, dynamic> seat) {
    final dynamic seatId = seat["food_tables_id"];
    final String label = (seat["table_number"] ?? "T-$seatId").toString();
    final String status = (seat["status"] ?? "available").toString().toLowerCase();

    // STRICT CHECK: User can only select if status is 'available'
    final bool isAvailable = status == "available";
    final bool isSelected = selectedSeatId != null && selectedSeatId.toString() == seatId.toString();

    Color bgColor;
    Color borderColor;
    Color iconColor;
    Color textColor;
    Color statusColor;
    String statusText;

    if (isSelected) {
      bgColor = primaryColor;
      borderColor = primaryColor;
      iconColor = Colors.white;
      textColor = Colors.white;
      statusColor = Colors.white;
      statusText = "ရွေးထားသည်";
    } else {
      switch (status) {
        // case "occupied":
        //   bgColor = const Color(0xffFEE2E2);
        //   borderColor = const Color(0xffFCA5A5);
        //   iconColor = const Color(0xffEF4444);
        //   textColor = const Color(0xff1E293B);
        //   statusColor = const Color(0xffEF4444);
        //   statusText = "လူရှိ";
        //   break;
        case "reserved":
          bgColor = const Color(0xffFEF3C7);
          borderColor = const Color(0xffFCD34D);
          iconColor = const Color(0xffF59E0B);
          textColor = const Color(0xff1E293B);
          statusColor = const Color(0xffD97706);
          statusText = "မှာထား";
          break;
        // case "disabled":
        //   bgColor = Colors.grey.shade100;
        //   borderColor = Colors.grey.shade200;
        //   iconColor = Colors.grey.shade400;
        //   textColor = Colors.grey.shade400;
        //   statusColor = Colors.grey.shade400;
        //   statusText = "ပိတ်ထား";
        //   break;
        case "available":
        default:
          bgColor = const Color(0xffECFDF5);
          borderColor = const Color(0xffA7F3D0);
          iconColor = const Color(0xff10B981);
          textColor = const Color(0xff1E293B);
          statusColor = const Color(0xff10B981);
          statusText = "အားလပ်";
          break;
      }
    }

    return InkWell(
      // ONLY ALLOW CLICK ON AVAILABLE TABLES
      onTap: isAvailable
          ? () {
              setState(() {
                if (isSelected) {
                  selectedSeatId = null;
                  selectedSeatLabel = null;
                } else {
                  selectedSeatId = seatId;
                  selectedSeatLabel = label;
                }
              });
            }
          : null,
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.table_restaurant_rounded,
                  size: 26,
                  color: iconColor,
                ),
                Positioned(
                  right: -15,
                  top: -2,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: textColor,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              statusText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem({required Color color, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class ReceiptClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 12);
    const double waveWidth = 8.0;
    const double waveHeight = 8.0;
    double x = 0;
    while (x < size.width) {
      x += waveWidth;
      path.lineTo(x - (waveWidth / 2), size.height - 12 + waveHeight);
      path.lineTo(x, size.height - 12);
    }
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}