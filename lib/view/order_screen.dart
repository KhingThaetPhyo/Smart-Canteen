
// // import 'package:flutter/material.dart';
// // import 'package:smartcanteen/model/order_model.dart';
// // import 'package:smartcanteen/service/api_service.dart';
// // import 'package:smartcanteen/service/secure_storage_service.dart';
// // import 'package:smartcanteen/view/order_detail_screen.dart';

// // enum OrderStatus { paid, preparing, ready, completed, canceled }

// // enum DateFilter { allTime, Today, thisWeek, thisMonth }

// // class OrdersScreen extends StatefulWidget {
// //   const OrdersScreen({super.key});

// //   @override
// //   State<OrdersScreen> createState() => _OrdersScreenState();
// // }

// // class _OrdersScreenState extends State<OrdersScreen> {
// //   int _selectedTabIndex = 0;
// //   DateFilter _selectedDateFilter = DateFilter.allTime;
// //   static const Color primaryColor = Color(0xff117992);
  
// //   bool _isLoading = true;
// //   bool _isLoggedIn = false;
// //   late Future<List<OrderModel>> _ordersFuture;

// //   // Updated filter labels to match all 5 states if needed, or keeping them based on your tab requirements
// //   final List<String> _filters = [
// //     'အားလုံး',
// //     'ငွေပေးချေပြီး',
// //     'ပြင်ဆင်နေဆဲ',
// //     'အသင့်ဖြစ်ပြီ',
// //     'ပြီးစီးပြီ',
// //     'ပယ်ဖျက်ပြီး',
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _checkLoginStatusAndLoadOrders();
// //   }

// //   Future<void> _checkLoginStatusAndLoadOrders() async {
// //     final token = await SecureStorageService.getToken();
// //     _isLoggedIn = token != null && token.isNotEmpty;

// //     if (_isLoggedIn) {
// //       String? apiFilterParam;
// //       if (_selectedDateFilter == DateFilter.Today) {
// //         apiFilterParam = 'Today';
// //       }
      
// //       _ordersFuture = ApiService().getUserOrders(dateFilter: apiFilterParam);
// //     }

// //     if (mounted) {
// //       setState(() {
// //         _isLoading = false;
// //       });
// //     }
// //   }

// //   void _onDateFilterChanged(DateFilter filter) {
// //     setState(() {
// //       _selectedDateFilter = filter;
// //       _isLoading = true;
// //     });
    
// //     _checkLoginStatusAndLoadOrders();
// //   }

// //   OrderStatus _parseStatus(String status) {
// //     switch (status.toLowerCase()) {
// //       case 'paid':
// //         return OrderStatus.paid;
// //       case 'preparing':
// //         return OrderStatus.preparing;
// //       case 'ready':
// //         return OrderStatus.ready;
// //       case 'completed':
// //         return OrderStatus.completed;
// //       case 'canceled':
// //       case 'cancelled':
// //         return OrderStatus.canceled;
// //       default:
// //         return OrderStatus.completed;
// //     }
// //   }

// //   String _getDateFilterLabel(DateFilter filter) {
// //     switch (filter) {
// //       case DateFilter.Today:
// //         return 'ယနေ့';
// //       case DateFilter.thisWeek:
// //         return 'ဒီတစ်ပတ်';
// //       case DateFilter.thisMonth:
// //         return 'ဒီလ';
// //       case DateFilter.allTime:
// //       default:
// //         return 'အချိန်အားလုံး';
// //     }
// //   }

// //   bool _isToday(String dateStr) {
// //     if (dateStr.isEmpty) return false;
    
// //     final lowerStr = dateStr.toLowerCase();
// //     if (lowerStr.contains('today') || lowerStr.contains('ယနေ့')) {
// //       return true;
// //     }

// //     final parsedDate = DateTime.tryParse(dateStr);
// //     if (parsedDate == null) return false;
    
// //     final now = DateTime.now();
// //     return parsedDate.year == now.year &&
// //         parsedDate.month == now.month &&
// //         parsedDate.day == now.day;
// //   }

// //   void _showDateFilterPicker() {
// //     showModalBottomSheet(
// //       context: context,
// //       shape: const RoundedRectangleBorder(
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// //       ),
// //       builder: (context) {
// //         return Container(
// //           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const Padding(
// //                 padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
// //                 child: Text(
// //                   "ရက်စွဲအလိုက် စစ်ဆေးရန်",
// //                   style: TextStyle(
// //                     fontSize: 18,
// //                     fontWeight: FontWeight.bold,
// //                     color: Color(0xff1E293B),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 12),
// //               ...DateFilter.values.map((filter) {
// //                 final isSelected = _selectedDateFilter == filter;
// //                 return ListTile(
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   selected: isSelected,
// //                   selectedTileColor: primaryColor.withOpacity(0.08),
// //                   leading: Icon(
// //                     Icons.calendar_today_rounded,
// //                     color: isSelected ? primaryColor : const Color(0xff64748B),
// //                     size: 20,
// //                   ),
// //                   title: Text(
// //                     _getDateFilterLabel(filter),
// //                     style: TextStyle(
// //                       fontWeight: isSelected
// //                           ? FontWeight.bold
// //                           : FontWeight.w500,
// //                       color: isSelected
// //                           ? primaryColor
// //                           : const Color(0xff1E293B),
// //                     ),
// //                   ),
// //                   trailing: isSelected
// //                       ? const Icon(Icons.check_rounded, color: primaryColor)
// //                       : null,
// //                   onTap: () {
// //                     _onDateFilterChanged(filter);
// //                     Navigator.pop(context);
// //                   },
// //                 );
// //               }),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFE3F2FD),
// //       body: SafeArea(
// //         child: _isLoading
// //             ? const Center(child: CircularProgressIndicator(color: primaryColor))
// //             : !_isLoggedIn
// //                 ? const Center(
// //                     child: Padding(
// //                       padding: EdgeInsets.all(24.0),
// //                       child: Text(
// //                         "‌အော်ဒါမှတ်တမ်းများကိုကြည့်ရှုရန် ကျေးဇူးပြု၍ အကောင့်ဝင်ပါ။",
// //                         textAlign: TextAlign.center,
// //                         style: TextStyle(
// //                           color: Colors.grey,
// //                           fontSize: 15,
// //                           fontWeight: FontWeight.w500,
// //                         ),
// //                       ),
// //                     ),
// //                   )
// //                 : Column(
// //                     children: [
// //                       /// FLOATING CARD HEADER
// //                       Container(
// //                         margin: EdgeInsets.only(
// //                           top: MediaQuery.of(context).padding.top + 16,
// //                           left: 16,
// //                           right: 16,
// //                           bottom: 12,
// //                         ),
// //                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
// //                         decoration: BoxDecoration(
// //                           color: primaryColor,
// //                           borderRadius: BorderRadius.circular(24),
// //                           boxShadow: [
// //                             BoxShadow(
// //                               color: primaryColor.withOpacity(0.25),
// //                               blurRadius: 16,
// //                               offset: const Offset(0, 8),
// //                             ),
// //                           ],
// //                         ),
// //                         child: Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           crossAxisAlignment: CrossAxisAlignment.center,
// //                           children: [
// //                             const Expanded(
// //                               child: Column(
// //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                 children: [
// //                                   Text(
// //                                     "မှာယူမှု မှတ်တမ်း",
// //                                     style: TextStyle(
// //                                       color: Colors.white,
// //                                       fontWeight: FontWeight.bold,
// //                                       fontSize: 22,
// //                                       letterSpacing: -0.3,
// //                                     ),
// //                                   ),
// //                                   SizedBox(height: 4),
// //                                   Text(
// //                                     "သင်မှာယူခဲ့သော အစားအသောက်များ",
// //                                     overflow: TextOverflow.ellipsis,
// //                                     style: TextStyle(
// //                                       color: Colors.white70,
// //                                       fontSize: 13,
// //                                       fontWeight: FontWeight.w400,
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                             const SizedBox(width: 8),
// //                             Material(
// //                               color: Colors.transparent,
// //                               child: InkWell(
// //                                 onTap: _showDateFilterPicker,
// //                                 borderRadius: BorderRadius.circular(16),
// //                                 child: Container(
// //                                   padding: const EdgeInsets.symmetric(
// //                                     horizontal: 12,
// //                                     vertical: 10,
// //                                   ),
// //                                   decoration: BoxDecoration(
// //                                     color: Colors.white,
// //                                     borderRadius: BorderRadius.circular(16),
// //                                   ),
// //                                   child: Row(
// //                                     mainAxisSize: MainAxisSize.min,
// //                                     children: [
// //                                       const Icon(
// //                                         Icons.calendar_month_rounded,
// //                                         color: primaryColor,
// //                                         size: 16,
// //                                       ),
// //                                       const SizedBox(width: 6),
// //                                       ConstrainedBox(
// //                                         constraints: const BoxConstraints(maxWidth: 85),
// //                                         child: Text(
// //                                           _getDateFilterLabel(_selectedDateFilter),
// //                                           overflow: TextOverflow.ellipsis,
// //                                           style: const TextStyle(
// //                                             color: primaryColor,
// //                                             fontSize: 12,
// //                                             fontWeight: FontWeight.bold,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
        
// //                       /// STATUS FILTER CHIPS
// //                       Container(
// //                         width: double.infinity,
// //                         padding: const EdgeInsets.symmetric(vertical: 4),
// //                         child: SingleChildScrollView(
// //                           scrollDirection: Axis.horizontal,
// //                           padding: const EdgeInsets.symmetric(horizontal: 16),
// //                           child: Row(
// //                             children: List.generate(_filters.length, (index) {
// //                               final isSelected = _selectedTabIndex == index;
// //                               return Padding(
// //                                 padding: const EdgeInsets.only(right: 8.0),
// //                                 child: ChoiceChip(
// //                                   label: Text(_filters[index]),
// //                                   selected: isSelected,
// //                                   onSelected: (selected) {
// //                                     if (selected) {
// //                                       setState(() => _selectedTabIndex = index);
// //                                     }
// //                                   },
// //                                   selectedColor: primaryColor,
// //                                   backgroundColor: Colors.white,
// //                                   labelStyle: TextStyle(
// //                                     color: isSelected
// //                                         ? Colors.white
// //                                         : const Color(0xff64748B),
// //                                     fontWeight: isSelected
// //                                         ? FontWeight.bold
// //                                         : FontWeight.w600,
// //                                     fontSize: 13,
// //                                   ),
// //                                   shape: RoundedRectangleBorder(
// //                                     borderRadius: BorderRadius.circular(12),
// //                                   ),
// //                                   side: isSelected
// //                                       ? BorderSide.none
// //                                       : BorderSide(color: Colors.grey.shade300),
// //                                 ),
// //                               );
// //                             }),
// //                           ),
// //                         ),
// //                       ),
        
// //                       const SizedBox(height: 4),
        
// //                       /// ORDERS LIST WITH FUTURE BUILDER
// //                       Expanded(
// //                         child: FutureBuilder<List<OrderModel>>(
// //                           future: _ordersFuture,
// //                           builder: (context, snapshot) {
// //                             if (snapshot.connectionState == ConnectionState.waiting) {
// //                               return const Center(child: CircularProgressIndicator(color: primaryColor));
// //                             } else if (snapshot.hasError) {
// //                               return Center(
// //                                 child: Padding(
// //                                   padding: const EdgeInsets.all(16.0),
// //                                   child: Text(
// //                                     "Error: ${snapshot.error}",
// //                                     textAlign: TextAlign.center,
// //                                     style: const TextStyle(color: Colors.red, fontSize: 12),
// //                                   ),
// //                                 ),
// //                               );
// //                             }
// //                             final orders = snapshot.data ?? [];
        
// //                             final filteredOrders = orders.where((order) {
// //                               final OrderStatus orderStatus = _parseStatus(order.status);
                              
// //                               // 1. Status Filter check mapping to 5 indices
// //                               bool matchesStatus = true;
// //                               if (_selectedTabIndex == 1) {
// //                                 matchesStatus = orderStatus == OrderStatus.paid;
// //                               } else if (_selectedTabIndex == 2) {
// //                                 matchesStatus = orderStatus == OrderStatus.preparing;
// //                               } else if (_selectedTabIndex == 3) {
// //                                 matchesStatus = orderStatus == OrderStatus.ready;
// //                               } else if (_selectedTabIndex == 4) {
// //                                 matchesStatus = orderStatus == OrderStatus.completed;
// //                               } else if (_selectedTabIndex == 5) {
// //                                 matchesStatus = orderStatus == OrderStatus.canceled;
// //                               }
        
// //                               if (!matchesStatus) return false;
        
// //                               // 2. Date Filter check
// //                               if (_selectedDateFilter == DateFilter.Today) {
// //                                 if (!_isToday(order.orderTime)) {
// //                                   return false;
// //                                 }
// //                               }
        
// //                               return true;
// //                             }).toList();
        
// //                             if (filteredOrders.isEmpty) {
// //                               return _buildEmptyState();
// //                             }
        
// //                             return ListView.builder(
// //                               padding: EdgeInsets.only(
// //                                 top: 8,
// //                                 bottom: MediaQuery.of(context).padding.bottom + 90,
// //                               ),
// //                               itemCount: filteredOrders.length,
// //                               itemBuilder: (context, index) {
// //                                 final order = filteredOrders[index];
// //                                 return _buildCanteenOrderCard(order);
// //                               },
// //                             );
// //                           },
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //       ),
// //     );
// //   }

// //   Widget _buildCanteenOrderCard(OrderModel order) {
// //     final OrderStatus status = _parseStatus(order.status);

// //     int totalPoints = 0;
// //     for (var item in order.items) {
// //       totalPoints += item.totalPrice;
// //     }

// //     return Container(
// //       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(20),
// //         border: Border.all(color: const Color(0xffCBD5E1), width: 1),
// //         boxShadow: [
// //           BoxShadow(
// //             color: const Color(0xff0F172A).withOpacity(0.08),
// //             blurRadius: 16,
// //             offset: const Offset(0, 6),
// //           ),
// //         ],
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Expanded(
// //                   child: Row(
// //                     children: [
// //                       Container(
// //                         padding: const EdgeInsets.all(8),
// //                         decoration: BoxDecoration(
// //                           color: primaryColor.withOpacity(0.08),
// //                           borderRadius: BorderRadius.circular(10),
// //                         ),
// //                         child: const Icon(
// //                           Icons.soup_kitchen_rounded,
// //                           size: 20,
// //                           color: primaryColor,
// //                         ),
// //                       ),
// //                       const SizedBox(width: 12),
// //                       Expanded(
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               order.shopName,
// //                               overflow: TextOverflow.ellipsis,
// //                               style: const TextStyle(
// //                                 fontSize: 15,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: Color(0xff1E293B),
// //                               ),
// //                             ),
// //                             const SizedBox(height: 2),
// //                             Text(
// //                               order.orderTime,
// //                               style: TextStyle(
// //                                 color: Colors.grey.shade500,
// //                                 fontSize: 11,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 _buildStatusBadge(status),
// //               ],
// //             ),
// //             const Padding(
// //               padding: EdgeInsets.symmetric(vertical: 12),
// //               child: Divider(height: 1, color: Color(0xffE2E8F0)),
// //             ),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     const Text(
// //                       "စုစုပေါင်းကျသင့်ပွိုင့်",
// //                       style: TextStyle(
// //                         fontSize: 10,
// //                         fontWeight: FontWeight.bold,
// //                         letterSpacing: 0.8,
// //                         color: Color(0xff64748B),
// //                       ),
// //                     ),
// //                     const SizedBox(height: 2),
// //                     Text(
// //                       "$totalPoints ပွိုင့်",
// //                       style: const TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.w900,
// //                         color: primaryColor,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(
// //                   height: 38,
// //                   child: ElevatedButton(
// //                     onPressed: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => OrderDetailScreen(order: order.toJson()),
// //                         ),
// //                       );
// //                     },
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: primaryColor,
// //                       foregroundColor: Colors.white,
// //                       elevation: 0,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                     ),
// //                     child: const Text(
// //                       "အသေးစိတ်ကြည့်ရန်",
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 13,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildStatusBadge(OrderStatus status) {
// //     Color bg;
// //     Color fg;
// //     String text;
// //     IconData icon;

// //     switch (status) {
// //       case OrderStatus.paid:
// //         bg = const Color(0xffFEF3C7);
// //         fg = const Color(0xffD97706);
// //         text = "ငွေပေးချေပြီး";
// //         icon = Icons.payment_rounded;
// //         break;
// //       case OrderStatus.preparing:
// //         bg = const Color(0xffE0F2FE);
// //         fg = const Color(0xff0284C7);
// //         text = "ပြင်ဆင်နေဆဲ";
// //         icon = Icons.soup_kitchen_rounded;
// //         break;
// //       case OrderStatus.ready:
// //         bg = const Color(0xffDCFCE7);
// //         fg = const Color(0xff16A34A);
// //         text = "အသင့်ဖြစ်ပြီ";
// //         icon = Icons.check_circle_rounded;
// //         break;
// //       case OrderStatus.completed:
// //         bg = const Color(0xffF1F5F9);
// //         fg = const Color(0xff64748B);
// //         text = "ပြီးစီးပြီ";
// //         icon = Icons.task_alt_rounded;
// //         break;
// //       case OrderStatus.canceled:
// //         bg = const Color(0xffFEE2E2);
// //         fg = const Color(0xffDC2626);
// //         text = "ပယ်ဖျက်ပြီး";
// //         icon = Icons.cancel_rounded;
// //         break;
// //     }

// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// //       decoration: BoxDecoration(
// //         color: bg,
// //         borderRadius: BorderRadius.circular(20),
// //       ),
// //       child: Row(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           Icon(icon, size: 12, color: fg),
// //           const SizedBox(width: 4),
// //           Text(
// //             text,
// //             style: TextStyle(
// //               color: fg,
// //               fontSize: 11,
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildEmptyState() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.no_meals_rounded, size: 60, color: Colors.grey.shade300),
// //           const SizedBox(height: 16),
// //           Text(
// //             "မှာယူထားသော အော်ဒါ မရှိပါ",
// //             style: TextStyle(
// //               fontSize: 16,
// //               fontWeight: FontWeight.bold,
// //               color: Colors.grey.shade600,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:smartcanteen/model/order_model.dart';
// import 'package:smartcanteen/service/api_service.dart';
// import 'package:smartcanteen/service/secure_storage_service.dart';
// import 'package:smartcanteen/view/order_detail_screen.dart';

// enum OrderStatus { paid, preparing, ready, completed, canceled }

// enum DateFilter { allTime, Today, thisWeek, thisMonth }

// class OrdersScreen extends StatefulWidget {
//   const OrdersScreen({super.key});

//   @override
//   State<OrdersScreen> createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen> {
//   int _selectedTabIndex = 0;
//   DateFilter _selectedDateFilter = DateFilter.allTime;
//   static const Color primaryColor = Color(0xff117992);
  
//   bool _isLoading = true;
//   bool _isLoggedIn = false;
//   late Future<List<OrderModel>> _ordersFuture;

//   final List<String> _filters = [
//     'အားလုံး',
//     'ငွေပေးချေပြီး',
//     'ပြင်ဆင်နေဆဲ',
//     'အသင့်ဖြစ်ပြီ',
//     'ပြီးစီးပြီ',
//     'ပယ်ဖျက်ပြီး',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatusAndLoadOrders();
//   }

//   Future<void> _checkLoginStatusAndLoadOrders() async {
//     final token = await SecureStorageService.getToken();
//     _isLoggedIn = token != null && token.isNotEmpty;

//     if (_isLoggedIn) {
//       String? apiFilterParam;
//       if (_selectedDateFilter == DateFilter.Today) {
//         apiFilterParam = 'Today';
//       }
      
//       _ordersFuture = ApiService().getUserOrders(dateFilter: apiFilterParam);
//     }

//     if (mounted) {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _onDateFilterChanged(DateFilter filter) {
//     setState(() {
//       _selectedDateFilter = filter;
//       _isLoading = true;
//     });
    
//     _checkLoginStatusAndLoadOrders();
//   }

//   OrderStatus _parseStatus(String status) {
//     switch (status.toLowerCase()) {
//       case 'paid':
//         return OrderStatus.paid;
//       case 'preparing':
//         return OrderStatus.preparing;
//       case 'ready':
//         return OrderStatus.ready;
//       case 'completed':
//         return OrderStatus.completed;
//       case 'canceled':
//       case 'cancelled':
//         return OrderStatus.canceled;
//       default:
//         return OrderStatus.completed;
//     }
//   }

//   String _getDateFilterLabel(DateFilter filter) {
//     switch (filter) {
//       case DateFilter.Today:
//         return 'ယနေ့';
//       case DateFilter.thisWeek:
//         return 'ဒီတစ်ပတ်';
//       case DateFilter.thisMonth:
//         return 'ဒီလ';
//       case DateFilter.allTime:
//       default:
//         return 'အချိန်အားလုံး';
//     }
//   }

//   bool _isToday(String dateStr) {
//     if (dateStr.isEmpty) return false;
    
//     final lowerStr = dateStr.toLowerCase();
//     if (lowerStr.contains('today') || lowerStr.contains('ယနေ့')) {
//       return true;
//     }

//     final parsedDate = DateTime.tryParse(dateStr);
//     if (parsedDate == null) return false;
    
//     final now = DateTime.now();
//     return parsedDate.year == now.year &&
//         parsedDate.month == now.month &&
//         parsedDate.day == now.day;
//   }

//   void _showDateFilterPicker() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Container(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
//                 child: Text(
//                   "ရက်စွဲအလိုက် စစ်ဆေးရန်",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xff1E293B),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               ...DateFilter.values.map((filter) {
//                 final isSelected = _selectedDateFilter == filter;
//                 return ListTile(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   selected: isSelected,
//                   selectedTileColor: primaryColor.withOpacity(0.08),
//                   leading: Icon(
//                     Icons.calendar_today_rounded,
//                     color: isSelected ? primaryColor : const Color(0xff64748B),
//                     size: 20,
//                   ),
//                   title: Text(
//                     _getDateFilterLabel(filter),
//                     style: TextStyle(
//                       fontWeight: isSelected
//                           ? FontWeight.bold
//                           : FontWeight.w500,
//                       color: isSelected
//                           ? primaryColor
//                           : const Color(0xff1E293B),
//                     ),
//                   ),
//                   trailing: isSelected
//                       ? const Icon(Icons.check_rounded, color: primaryColor)
//                       : null,
//                   onTap: () {
//                     _onDateFilterChanged(filter);
//                     Navigator.pop(context);
//                   },
//                 );
//               }),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFE3F2FD),
//       // SafeArea ၏ အစား Padding ထည့်သွင်းပြီး အောက်ဘက်သို့ အနည်းငယ် ရွှေ့ထားပါသည်[cite: 13]
//       body: Padding(
//         padding: const EdgeInsets.only(top: 16.0),
//         child: _isLoading
//             ? const Center(child: CircularProgressIndicator(color: primaryColor))
//             : !_isLoggedIn
//                 ? const Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(24.0),
//                       child: Text(
//                         "‌အော်ဒါမှတ်တမ်းများကိုကြည့်ရှုရန် ကျေးဇူးပြု၍ အကောင့်ဝင်ပါ။",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   )
//                 : Column(
//                     children: [
//                       /// FLOATING CARD HEADER
//                       Container(
//                         margin: EdgeInsets.only(
//                           top: MediaQuery.of(context).padding.top + 16,
//                           left: 16,
//                           right: 16,
//                           bottom: 12,
//                         ),
//                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                         decoration: BoxDecoration(
//                           color: primaryColor,
//                           borderRadius: BorderRadius.circular(24),
//                           boxShadow: [
//                             BoxShadow(
//                               color: primaryColor.withOpacity(0.25),
//                               blurRadius: 16,
//                               offset: const Offset(0, 8),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "မှာယူမှု မှတ်တမ်း",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 22,
//                                       letterSpacing: -0.3,
//                                     ),
//                                   ),
//                                   SizedBox(height: 4),
//                                   Text(
//                                     "သင်မှာယူခဲ့သော အစားအသောက်များ",
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       color: Colors.white70,
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             Material(
//                               color: Colors.transparent,
//                               child: InkWell(
//                                 onTap: _showDateFilterPicker,
//                                 borderRadius: BorderRadius.circular(16),
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 12,
//                                     vertical: 10,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(16),
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       const Icon(
//                                         Icons.calendar_month_rounded,
//                                         color: primaryColor,
//                                         size: 16,
//                                       ),
//                                       const SizedBox(width: 6),
//                                       ConstrainedBox(
//                                         constraints: const BoxConstraints(maxWidth: 85),
//                                         child: Text(
//                                           _getDateFilterLabel(_selectedDateFilter),
//                                           overflow: TextOverflow.ellipsis,
//                                           style: const TextStyle(
//                                             color: primaryColor,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
        
//                       /// STATUS FILTER CHIPS
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.symmetric(vertical: 4),
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: Row(
//                             children: List.generate(_filters.length, (index) {
//                               final isSelected = _selectedTabIndex == index;
//                               return Padding(
//                                 padding: const EdgeInsets.only(right: 8.0),
//                                 child: ChoiceChip(
//                                   label: Text(_filters[index]),
//                                   selected: isSelected,
//                                   onSelected: (selected) {
//                                     if (selected) {
//                                       setState(() => _selectedTabIndex = index);
//                                     }
//                                   },
//                                   selectedColor: primaryColor,
//                                   backgroundColor: Colors.white,
//                                   labelStyle: TextStyle(
//                                     color: isSelected
//                                         ? Colors.white
//                                         : const Color(0xff64748B),
//                                     fontWeight: isSelected
//                                         ? FontWeight.bold
//                                         : FontWeight.w600,
//                                     fontSize: 13,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   side: isSelected
//                                       ? BorderSide.none
//                                       : BorderSide(color: Colors.grey.shade300),
//                                 ),
//                               );
//                             }),
//                           ),
//                         ),
//                       ),
        
//                       const SizedBox(height: 4),
        
//                       /// ORDERS LIST WITH FUTURE BUILDER
//                       Expanded(
//                         child: FutureBuilder<List<OrderModel>>(
//                           future: _ordersFuture,
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState == ConnectionState.waiting) {
//                               return const Center(child: CircularProgressIndicator(color: primaryColor));
//                             } else if (snapshot.hasError) {
//                               return Center(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Text(
//                                     "Error: ${snapshot.error}",
//                                     textAlign: TextAlign.center,
//                                     style: const TextStyle(color: Colors.red, fontSize: 12),
//                                   ),
//                                 ),
//                               );
//                             }
//                             final orders = snapshot.data ?? [];
        
//                             final filteredOrders = orders.where((order) {
//                               final OrderStatus orderStatus = _parseStatus(order.status);
                              
//                               bool matchesStatus = true;
//                               if (_selectedTabIndex == 1) {
//                                 matchesStatus = orderStatus == OrderStatus.paid;
//                               } else if (_selectedTabIndex == 2) {
//                                 matchesStatus = orderStatus == OrderStatus.preparing;
//                               } else if (_selectedTabIndex == 3) {
//                                 matchesStatus = orderStatus == OrderStatus.ready;
//                               } else if (_selectedTabIndex == 4) {
//                                 matchesStatus = orderStatus == OrderStatus.completed;
//                               } else if (_selectedTabIndex == 5) {
//                                 matchesStatus = orderStatus == OrderStatus.canceled;
//                               }
        
//                               if (!matchesStatus) return false;
        
//                               if (_selectedDateFilter == DateFilter.Today) {
//                                 if (!_isToday(order.orderTime)) {
//                                   return false;
//                                 }
//                               }
        
//                               return true;
//                             }).toList();
        
//                             if (filteredOrders.isEmpty) {
//                               return _buildEmptyState();
//                             }
        
//                             return ListView.builder(
//                               padding: EdgeInsets.only(
//                                 top: 8,
//                                 bottom: MediaQuery.of(context).padding.bottom + 90,
//                               ),
//                               itemCount: filteredOrders.length,
//                               itemBuilder: (context, index) {
//                                 final order = filteredOrders[index];
//                                 return _buildCanteenOrderCard(order);
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//       ),
//     );
//   }

//   Widget _buildCanteenOrderCard(OrderModel order) {
//     final OrderStatus status = _parseStatus(order.status);

//     int totalPoints = 0;
//     for (var item in order.items) {
//       totalPoints += item.totalPrice;
//     }

//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: const Color(0xffCBD5E1), width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xff0F172A).withOpacity(0.08),
//             blurRadius: 16,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: primaryColor.withOpacity(0.08),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Icon(
//                           Icons.soup_kitchen_rounded,
//                           size: 20,
//                           color: primaryColor,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               order.shopName,
//                               overflow: TextOverflow.ellipsis,
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xff1E293B),
//                               ),
//                             ),
//                             const SizedBox(height: 2),
//                             Text(
//                               order.orderTime,
//                               style: TextStyle(
//                                 color: Colors.grey.shade500,
//                                 fontSize: 11,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 _buildStatusBadge(status),
//               ],
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 12),
//               child: Divider(height: 1, color: Color(0xffE2E8F0)),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "စုစုပေါင်းကျသင့်ပွိုင့်",
//                       style: TextStyle(
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 0.8,
//                         color: Color(0xff64748B),
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       "$totalPoints ပွိုင့်",
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w900,
//                         color: primaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 38,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => OrderDetailScreen(order: order.toJson()),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: primaryColor,
//                       foregroundColor: Colors.white,
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       "အသေးစိတ်ကြည့်ရန်",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStatusBadge(OrderStatus status) {
//     Color bg;
//     Color fg;
//     String text;
//     IconData icon;

//     switch (status) {
//       case OrderStatus.paid:
//         bg = const Color(0xffFEF3C7);
//         fg = const Color(0xffD97706);
//         text = "ငွေပေးချေပြီး";
//         icon = Icons.payment_rounded;
//         break;
//       case OrderStatus.preparing:
//         bg = const Color(0xffE0F2FE);
//         fg = const Color(0xff0284C7);
//         text = "ပြင်ဆင်နေဆဲ";
//         icon = Icons.soup_kitchen_rounded;
//         break;
//       case OrderStatus.ready:
//         bg = const Color(0xffDCFCE7);
//         fg = const Color(0xff16A34A);
//         text = "အသင့်ဖြစ်ပြီ";
//         icon = Icons.check_circle_rounded;
//         break;
//       case OrderStatus.completed:
//         bg = const Color(0xffF1F5F9);
//         fg = const Color(0xff64748B);
//         text = "ပြီးစီးပြီ";
//         icon = Icons.task_alt_rounded;
//         break;
//       case OrderStatus.canceled:
//         bg = const Color(0xffFEE2E2);
//         fg = const Color(0xffDC2626);
//         text = "ပယ်ဖျက်ပြီး";
//         icon = Icons.cancel_rounded;
//         break;
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: bg,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 12, color: fg),
//           const SizedBox(width: 4),
//           Text(
//             text,
//             style: TextStyle(
//               color: fg,
//               fontSize: 11,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.no_meals_rounded, size: 60, color: Colors.grey.shade300),
//           const SizedBox(height: 16),
//           Text(
//             "မှာယူထားသော အော်ဒါ မရှိပါ",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey.shade600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:smartcanteen/model/order_model.dart';
import 'package:smartcanteen/service/api_service.dart';
import 'package:smartcanteen/service/secure_storage_service.dart';
import 'package:smartcanteen/view/order_detail_screen.dart';

enum OrderStatus { paid, preparing, ready, completed, canceled }

enum DateFilter { allTime, Today, thisWeek, thisMonth }

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _selectedTabIndex = 0;
  DateFilter _selectedDateFilter = DateFilter.allTime;
  static const Color primaryColor = Color(0xff117992);
  
  bool _isLoading = true;
  bool _isLoggedIn = false;
  late Future<List<OrderModel>> _ordersFuture;

  final List<String> _filters = [
    'အားလုံး',
    'ငွေပေးချေပြီး',
    'ပြင်ဆင်နေဆဲ',
    'အသင့်ဖြစ်ပြီ',
    'ပြီးစီးပြီ',
    'ပယ်ဖျက်ပြီး',
  ];

  @override
  void initState() {
    super.initState();
    _checkLoginStatusAndLoadOrders();
  }

  Future<void> _checkLoginStatusAndLoadOrders() async {
    final token = await SecureStorageService.getToken();
    _isLoggedIn = token != null && token.isNotEmpty;

    if (_isLoggedIn) {
      String? apiFilterParam;
      if (_selectedDateFilter == DateFilter.Today) {
        apiFilterParam = 'Today';
      }
      
      _ordersFuture = ApiService().getUserOrders(dateFilter: apiFilterParam);
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Refreshes order data when pulling down screen
  Future<void> _onRefresh() async {
    setState(() {
      _checkLoginStatusAndLoadOrders();
    });
    await _ordersFuture;
  }

  void _onDateFilterChanged(DateFilter filter) {
    setState(() {
      _selectedDateFilter = filter;
      _isLoading = true;
    });
    
    _checkLoginStatusAndLoadOrders();
  }

  OrderStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return OrderStatus.paid;
      case 'preparing':
        return OrderStatus.preparing;
      case 'ready':
        return OrderStatus.ready;
      case 'completed':
        return OrderStatus.completed;
      case 'canceled':
      case 'cancelled':
        return OrderStatus.canceled;
      default:
        return OrderStatus.completed;
    }
  }

  String _getDateFilterLabel(DateFilter filter) {
    switch (filter) {
      case DateFilter.Today:
        return 'ယနေ့';
      case DateFilter.thisWeek:
        return 'ဒီတစ်ပတ်';
      case DateFilter.thisMonth:
        return 'ဒီလ';
      case DateFilter.allTime:
      default:
        return 'အချိန်အားလုံး';
    }
  }

  bool _isToday(String dateStr) {
    if (dateStr.isEmpty) return false;
    
    final lowerStr = dateStr.toLowerCase();
    if (lowerStr.contains('today') || lowerStr.contains('ယနေ့')) {
      return true;
    }

    final parsedDate = DateTime.tryParse(dateStr);
    if (parsedDate == null) return false;
    
    final now = DateTime.now();
    return parsedDate.year == now.year &&
        parsedDate.month == now.month &&
        parsedDate.day == now.day;
  }

  void _showDateFilterPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Text(
                  "ရက်စွဲအလိုက် စစ်ဆေးရန်",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1E293B),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ...DateFilter.values.map((filter) {
                final isSelected = _selectedDateFilter == filter;
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  selected: isSelected,
                  selectedTileColor: primaryColor.withOpacity(0.08),
                  leading: Icon(
                    Icons.calendar_today_rounded,
                    color: isSelected ? primaryColor : const Color(0xff64748B),
                    size: 20,
                  ),
                  title: Text(
                    _getDateFilterLabel(filter),
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: isSelected
                          ? primaryColor
                          : const Color(0xff1E293B),
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check_rounded, color: primaryColor)
                      : null,
                  onTap: () {
                    _onDateFilterChanged(filter);
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: primaryColor))
            : !_isLoggedIn
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text(
                        "‌အော်ဒါမှတ်တမ်းများကိုကြည့်ရှုရန် ကျေးဇူးပြု၍ အကောင့်ဝင်ပါ။",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                : RefreshIndicator(
                    color: primaryColor,
                    onRefresh: _onRefresh,
                    child: Column(
                      children: [
                        /// FLOATING CARD HEADER
                        Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top + 16,
                            left: 16,
                            right: 16,
                            bottom: 12,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.25),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "မှာယူမှု မှတ်တမ်း",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "သင်မှာယူခဲ့သော အစားအသောက်များ",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: _showDateFilterPicker,
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.calendar_month_rounded,
                                          color: primaryColor,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 6),
                                        ConstrainedBox(
                                          constraints: const BoxConstraints(maxWidth: 85),
                                          child: Text(
                                            _getDateFilterLabel(_selectedDateFilter),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
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
          
                        /// STATUS FILTER CHIPS
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: List.generate(_filters.length, (index) {
                                final isSelected = _selectedTabIndex == index;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ChoiceChip(
                                    label: Text(_filters[index]),
                                    selected: isSelected,
                                    onSelected: (selected) {
                                      if (selected) {
                                        setState(() => _selectedTabIndex = index);
                                      }
                                    },
                                    selectedColor: primaryColor,
                                    backgroundColor: Colors.white,
                                    labelStyle: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : const Color(0xff64748B),
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    side: isSelected
                                        ? BorderSide.none
                                        : BorderSide(color: Colors.grey.shade300),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
          
                        const SizedBox(height: 4),
          
                        /// ORDERS LIST WITH FUTURE BUILDER
                        Expanded(
                          child: FutureBuilder<List<OrderModel>>(
                            future: _ordersFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator(color: primaryColor));
                              } else if (snapshot.hasError) {
                                return ListView(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  children: [
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          "Error: ${snapshot.error}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(color: Colors.red, fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              final orders = snapshot.data ?? [];
          
                              final filteredOrders = orders.where((order) {
                                final OrderStatus orderStatus = _parseStatus(order.status);
                                
                                bool matchesStatus = true;
                                if (_selectedTabIndex == 1) {
                                  matchesStatus = orderStatus == OrderStatus.paid;
                                } else if (_selectedTabIndex == 2) {
                                  matchesStatus = orderStatus == OrderStatus.preparing;
                                } else if (_selectedTabIndex == 3) {
                                  matchesStatus = orderStatus == OrderStatus.ready;
                                } else if (_selectedTabIndex == 4) {
                                  matchesStatus = orderStatus == OrderStatus.completed;
                                } else if (_selectedTabIndex == 5) {
                                  matchesStatus = orderStatus == OrderStatus.canceled;
                                }
          
                                if (!matchesStatus) return false;
          
                                if (_selectedDateFilter == DateFilter.Today) {
                                  if (!_isToday(order.orderTime)) {
                                    return false;
                                  }
                                }
          
                                return true;
                              }).toList();
          
                              if (filteredOrders.isEmpty) {
                                return ListView(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  children: [
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                                    _buildEmptyState(),
                                  ],
                                );
                              }
          
                              return ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.only(
                                  top: 8,
                                  bottom: MediaQuery.of(context).padding.bottom + 90,
                                ),
                                itemCount: filteredOrders.length,
                                itemBuilder: (context, index) {
                                  final order = filteredOrders[index];
                                  return _buildCanteenOrderCard(order);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildCanteenOrderCard(OrderModel order) {
    final OrderStatus status = _parseStatus(order.status);

    int totalPoints = 0;
    for (var item in order.items) {
      totalPoints += item.totalPrice;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffCBD5E1), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff0F172A).withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.soup_kitchen_rounded,
                          size: 20,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.shopName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1E293B),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              order.orderTime,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(status),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1, color: Color(0xffE2E8F0)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "စုစုပေါင်းကျသင့်ပွိုင့်",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        color: Color(0xff64748B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "$totalPoints ပွိုင့်",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailScreen(order: order.toJson()),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "အသေးစိတ်ကြည့်ရန်",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(OrderStatus status) {
    Color bg;
    Color fg;
    String text;
    IconData icon;

    switch (status) {
      case OrderStatus.paid:
        bg = const Color(0xffFEF3C7);
        fg = const Color(0xffD97706);
        text = "ငွေပေးချေပြီး";
        icon = Icons.payment_rounded;
        break;
      case OrderStatus.preparing:
        bg = const Color(0xffE0F2FE);
        fg = const Color(0xff0284C7);
        text = "ပြင်ဆင်နေဆဲ";
        icon = Icons.soup_kitchen_rounded;
        break;
      case OrderStatus.ready:
        bg = const Color(0xffDCFCE7);
        fg = const Color(0xff16A34A);
        text = "အသင့်ဖြစ်ပြီ";
        icon = Icons.check_circle_rounded;
        break;
      case OrderStatus.completed:
        bg = const Color(0xffF1F5F9);
        fg = const Color(0xff64748B);
        text = "ပြီးစီးပြီ";
        icon = Icons.task_alt_rounded;
        break;
      case OrderStatus.canceled:
        bg = const Color(0xffFEE2E2);
        fg = const Color(0xffDC2626);
        text = "ပယ်ဖျက်ပြီး";
        icon = Icons.cancel_rounded;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: fg),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: fg,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.no_meals_rounded, size: 60, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            "မှာယူထားသော အော်ဒါ မရှိပါ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}