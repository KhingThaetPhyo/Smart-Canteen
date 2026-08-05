// // // import 'package:flutter/material.dart';

// // // enum NotificationType { order, transaction }

// // // class NotificationModel {
// // //   final String id;
// // //   final NotificationType type;
// // //   final String title;
// // //   final String message;
// // //   final String time;
// // //   bool isRead;

// // //   NotificationModel({
// // //     required this.id,
// // //     required this.type,
// // //     required this.title,
// // //     required this.message,
// // //     required this.time,
// // //     this.isRead = false,
// // //   });
// // // }

// // // class NotificationScreen extends StatefulWidget {
// // //   const NotificationScreen({super.key});

// // //   @override
// // //   State<NotificationScreen> createState() => _NotificationScreenState();
// // // }

// // // class _NotificationScreenState extends State<NotificationScreen> {
// // //   int selectedTab = 0;
// // //   static const Color primaryColor = Color(0xff117992);

// // //   final List<NotificationModel> notifications = [
// // //     NotificationModel(
// // //       id: '1',
// // //       type: NotificationType.order,
// // //       title: 'Order Ready',
// // //       message: 'Your Milk Tea is ready for pickup at Coffee Corner.',
// // //       time: '2 min ago',
// // //       isRead: false,
// // //     ),
// // //     NotificationModel(
// // //       id: '2',
// // //       type: NotificationType.order,
// // //       title: 'Order Completed',
// // //       message: 'Your Shan Noodle order has been completed successfully.',
// // //       time: '1 hour ago',
// // //       isRead: true,
// // //     ),
// // //     NotificationModel(
// // //       id: '3',
// // //       type: NotificationType.transaction,
// // //       title: 'Points Received',
// // //       message: 'You received 500 pts from Mg Mg.',
// // //       time: 'Today • 10:30 AM',
// // //       isRead: false,
// // //     ),
// // //     NotificationModel(
// // //       id: '4',
// // //       type: NotificationType.transaction,
// // //       title: 'Payment Successful',
// // //       message: '1,500 pts paid to Coffee Corner.',
// // //       time: 'Yesterday',
// // //       isRead: true,
// // //     ),
// // //   ];

// // //   List<NotificationModel> get filteredNotifications {
// // //     switch (selectedTab) {
// // //       case 1:
// // //         return notifications
// // //             .where((n) => n.type == NotificationType.order)
// // //             .toList();
// // //       case 2:
// // //         return notifications
// // //             .where((n) => n.type == NotificationType.transaction)
// // //             .toList();
// // //       default:
// // //         return notifications;
// // //     }
// // //   }

// // //   int get unreadCount => notifications.where((n) => !n.isRead).length;

// // //   void _markAllAsRead() {
// // //     setState(() {
// // //       for (var item in notifications) {
// // //         item.isRead = true;
// // //       }
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final displayedList = filteredNotifications;

// // //     return Scaffold(
// // //       backgroundColor: const Color(0xffF6F8FC),
// // //       body: SafeArea(
// // //         child: Column(
// // //           children: [
// // //             Container(
// // //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// // //               margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
// // //               decoration: BoxDecoration(
// // //                 gradient: const LinearGradient(
// // //                   colors: [Color(0xff0D6B80), Color(0xff117992)],
// // //                   begin: Alignment.topLeft,
// // //                   end: Alignment.bottomRight,
// // //                 ),
// // //                 borderRadius: BorderRadius.circular(22),
// // //                 boxShadow: [
// // //                   BoxShadow(
// // //                     color: primaryColor.withOpacity(0.3),
// // //                     blurRadius: 12,
// // //                     offset: const Offset(0, 4),
// // //                   ),
// // //                 ],
// // //               ),
// // //               child: Row(
// // //                 children: [
// // //                   InkWell(
// // //                     onTap: () => Navigator.pop(context),
// // //                     borderRadius: BorderRadius.circular(12),
// // //                     child: Container(
// // //                       padding: const EdgeInsets.all(8),
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.white.withOpacity(0.18),
// // //                         borderRadius: BorderRadius.circular(12),
// // //                       ),
// // //                       child: const Icon(
// // //                         Icons.arrow_back_ios_new_rounded,
// // //                         color: Colors.white,
// // //                         size: 18,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                   const SizedBox(width: 14),
// // //                   const Expanded(
// // //                     child: Text(
// // //                       'Notifications',
// // //                       style: TextStyle(
// // //                         color: Colors.white,
// // //                         fontSize: 18,
// // //                         fontWeight: FontWeight.bold,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                   if (unreadCount > 0)
// // //                     GestureDetector(
// // //                       onTap: _markAllAsRead,
// // //                       child: Container(
// // //                         padding: const EdgeInsets.symmetric(
// // //                           horizontal: 12,
// // //                           vertical: 6,
// // //                         ),
// // //                         decoration: BoxDecoration(
// // //                           color: Colors.white.withOpacity(0.2),
// // //                           borderRadius: BorderRadius.circular(12),
// // //                           border: Border.all(
// // //                             color: Colors.white.withOpacity(0.25),
// // //                           ),
// // //                         ),
// // //                         child: Row(
// // //                           children: [
// // //                             Container(
// // //                               width: 6,
// // //                               height: 6,
// // //                               decoration: const BoxDecoration(
// // //                                 color: Color(0xff34D399),
// // //                                 shape: BoxShape.circle,
// // //                               ),
// // //                             ),
// // //                             const SizedBox(width: 6),
// // //                             Text(
// // //                               '$unreadCount New',
// // //                               style: const TextStyle(
// // //                                 color: Colors.white,
// // //                                 fontWeight: FontWeight.bold,
// // //                                 fontSize: 11,
// // //                               ),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     ),
// // //                 ],
// // //               ),
// // //             ),
// // //             NotificationTabBar(
// // //               selectedIndex: selectedTab,
// // //               onChanged: (index) {
// // //                 setState(() {
// // //                   selectedTab = index;
// // //                 });
// // //               },
// // //             ),
// // //             const SizedBox(height: 12),
// // //             Expanded(
// // //               child: displayedList.isEmpty
// // //                   ? _buildEmptyState()
// // //                   : ListView.builder(
// // //                       padding: const EdgeInsets.symmetric(horizontal: 20),
// // //                       itemCount: displayedList.length,
// // //                       itemBuilder: (context, index) {
// // //                         final item = displayedList[index];
// // //                         return NotificationCard(
// // //                           type: item.type,
// // //                           title: item.title,
// // //                           message: item.message,
// // //                           time: item.time,
// // //                           isRead: item.isRead,
// // //                           onTap: () {
// // //                             setState(() {
// // //                               item.isRead = true;
// // //                             });
// // //                           },
// // //                         );
// // //                       },
// // //                     ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:smartcanteen/model/notification_model.dart';
// // import 'package:smartcanteen/provider/notification_provider.dart';

// // class NotificationScreen extends StatefulWidget {
// //   const NotificationScreen({super.key});

// //   @override
// //   State<NotificationScreen> createState() => _NotificationScreenState();
// // }

// // class _NotificationScreenState extends State<NotificationScreen> {
// //   int selectedTab = 0;
// //   static const Color primaryColor = Color(0xff117992);
// // // notification_screen.dart

// // @override
// // void initState() {
// //   super.initState();
// //   WidgetsBinding.instance.addPostFrameCallback((_) {
// //     // Replace with your actual user token and backend API base URL
// //     final provider = Provider.of<NotificationProvider>(context, listen: false);
// //     // provider.fetchNotifications(userToken: 'YOUR_TOKEN', baseUrl: 'YOUR_BASE_URL');
// //   });
// // }
// //   @override
// //   Widget build(BuildContext context) {
// //     final provider = context.watch<NotificationProvider>();

// //     // Filter notifications based on selected tab
// //     List<NotificationModel> displayedList;
// //     switch (selectedTab) {
// //       case 1:
// //         displayedList = provider.notifications
// //             .where((n) => n.type == NotificationType.order)
// //             .toList();
// //         break;
// //       case 2:
// //         displayedList = provider.notifications
// //             .where((n) => n.type == NotificationType.transaction)
// //             .toList();
// //         break;
// //       default:
// //         displayedList = provider.notifications;
// //     }

// //     return Scaffold(
// //       backgroundColor: const Color(0xffF6F8FC),
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             // Top Header Bar
// //             Container(
// //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //               margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
// //               decoration: BoxDecoration(
// //                 gradient: const LinearGradient(
// //                   colors: [Color(0xff0D6B80), Color(0xff117992)],
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                 ),
// //                 borderRadius: BorderRadius.circular(22),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: primaryColor.withOpacity(0.3),
// //                     blurRadius: 12,
// //                     offset: const Offset(0, 4),
// //                   ),
// //                 ],
// //               ),
// //               child: Row(
// //                 children: [
// //                   InkWell(
// //                     onTap: () => Navigator.pop(context),
// //                     borderRadius: BorderRadius.circular(12),
// //                     child: Container(
// //                       padding: const EdgeInsets.all(8),
// //                       decoration: BoxDecoration(
// //                         color: Colors.white.withOpacity(0.18),
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                       child: const Icon(
// //                         Icons.arrow_back_ios_new_rounded,
// //                         color: Colors.white,
// //                         size: 18,
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(width: 14),
// //                   const Expanded(
// //                     child: Text(
// //                       'Notifications',
// //                       style: TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                   ),
// //                   if (provider.unreadCount > 0)
// //                     GestureDetector(
// //                       onTap: () => provider.markAllAsRead(),
// //                       child: Container(
// //                         padding: const EdgeInsets.symmetric(
// //                           horizontal: 12,
// //                           vertical: 6,
// //                         ),
// //                         decoration: BoxDecoration(
// //                           color: Colors.white.withOpacity(0.2),
// //                           borderRadius: BorderRadius.circular(12),
// //                           border: Border.all(
// //                             color: Colors.white.withOpacity(0.25),
// //                           ),
// //                         ),
// //                         child: Row(
// //                           children: [
// //                             Container(
// //                               width: 6,
// //                               height: 6,
// //                               decoration: const BoxDecoration(
// //                                 color: Color(0xff34D399),
// //                                 shape: BoxShape.circle,
// //                               ),
// //                             ),
// //                             const SizedBox(width: 6),
// //                             Text(
// //                               '${provider.unreadCount} New',
// //                               style: const TextStyle(
// //                                 color: Colors.white,
// //                                 fontWeight: FontWeight.bold,
// //                                 fontSize: 11,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                 ],
// //               ),
// //             ),

// //             // Tab Bar Switcher
// //             NotificationTabBar(
// //               selectedIndex: selectedTab,
// //               onChanged: (index) {
// //                 setState(() {
// //                   selectedTab = index;
// //                 });
// //               },
// //             ),
// //             const SizedBox(height: 12),

// //             // Main Notification List View
// //             Expanded(
// //               child: provider.isLoading
// //                   ? const Center(child: CircularProgressIndicator())
// //                   : displayedList.isEmpty
// //                       ? _buildEmptyState()
// //                       : // notification_screen.dart

// // ListView.builder(
// //   padding: const EdgeInsets.symmetric(horizontal: 20),
// //   itemCount: displayedList.length,
// //   itemBuilder: (context, index) {
// //     final item = displayedList[index];
// //     return NotificationCard(
// //       type: item.type,
// //       title: item.title,
// //       message: item.message,
// //       time: item.time,
// //       isRead: item.isRead,
// //       onTap: () {
// //         provider.markAsRead(item.id); // 👈 Pass item.id directly as int
// //       },
// //     );
// //   },
// // )
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildEmptyState() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(18),
// //             decoration: BoxDecoration(
// //               color: primaryColor.withOpacity(0.08),
// //               shape: BoxShape.circle,
// //             ),
// //             child: Icon(
// //               Icons.notifications_none_rounded,
// //               size: 40,
// //               color: primaryColor.withOpacity(0.6),
// //             ),
// //           ),
// //           const SizedBox(height: 14),
// //           Text(
// //             'No notifications here',
// //             style: TextStyle(
// //               fontSize: 15,
// //               fontWeight: FontWeight.bold,
// //               color: Colors.grey.shade700,
// //             ),
// //           ),
// //           const SizedBox(height: 4),
// //           Text(
// //             'Your updates will show up here.',
// //             style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class NotificationTabBar extends StatelessWidget {
// //   final int selectedIndex;
// //   final Function(int) onChanged;

// //   const NotificationTabBar({
// //     super.key,
// //     required this.selectedIndex,
// //     required this.onChanged,
// //   });

// //   static const Color primaryColor = Color(0xff117992);

// //   @override
// //   Widget build(BuildContext context) {
// //     final tabs = ['All', 'Orders', 'Transactions'];

// //     return SizedBox(
// //       height: 38,
// //       child: ListView.separated(
// //         padding: const EdgeInsets.symmetric(horizontal: 20),
// //         scrollDirection: Axis.horizontal,
// //         itemCount: tabs.length,
// //         separatorBuilder: (_, __) => const SizedBox(width: 8),
// //         itemBuilder: (context, index) {
// //           final isSelected = selectedIndex == index;

// //           return GestureDetector(
// //             onTap: () => onChanged(index),
// //             child: AnimatedContainer(
// //               duration: const Duration(milliseconds: 200),
// //               padding: const EdgeInsets.symmetric(horizontal: 20),
// //               decoration: BoxDecoration(
// //                 color: isSelected ? primaryColor : Colors.white,
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               child: Center(
// //                 child: Text(
// //                   tabs[index],
// //                   style: TextStyle(
// //                     fontSize: 13,
// //                     fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
// //                     color: isSelected ? Colors.white : Colors.grey.shade600,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // class NotificationCard extends StatelessWidget {
// //   final String title;
// //   final String message;
// //   final String time;
// //   final bool isRead;
// //   final NotificationType type;
// //   final VoidCallback? onTap;

// //   const NotificationCard({
// //     super.key,
// //     required this.title,
// //     required this.message,
// //     required this.time,
// //     required this.type,
// //     this.isRead = true,
// //     this.onTap,
// //   });

// //   static const Color primaryColor = Color(0xff117992);

// //   @override
// //   Widget build(BuildContext context) {
// //     final isOrder = type == NotificationType.order;

// //     final Color themeColor =
// //         isOrder ? const Color(0xffD97706) : const Color(0xff059669);

// //     final Color chipBg =
// //         isOrder ? const Color(0xffFFF7ED) : const Color(0xffECFDF5);

// //     final IconData iconData = isOrder
// //         ? Icons.local_mall_outlined
// //         : Icons.account_balance_wallet_outlined;

// //     final String labelText = isOrder ? 'Order' : 'Points';

// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 12),
// //       decoration: BoxDecoration(
// //         color: isRead ? Colors.white : const Color(0xffF4F9FA),
// //         borderRadius: BorderRadius.circular(20),
// //         border: Border.all(
// //           color: isRead
// //               ? Colors.black.withOpacity(0.04)
// //               : primaryColor.withOpacity(0.25),
// //           width: 1.2,
// //         ),
// //       ),
// //       child: Material(
// //         color: Colors.transparent,
// //         child: InkWell(
// //           onTap: onTap,
// //           borderRadius: BorderRadius.circular(20),
// //           child: Padding(
// //             padding: const EdgeInsets.all(16),
// //             child: Row(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Container(
// //                   width: 48,
// //                   height: 48,
// //                   decoration: BoxDecoration(
// //                     color: chipBg,
// //                     shape: BoxShape.circle,
// //                   ),
// //                   child: Icon(iconData, color: themeColor, size: 22),
// //                 ),
// //                 const SizedBox(width: 14),
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           Container(
// //                             padding: const EdgeInsets.symmetric(
// //                               horizontal: 8,
// //                               vertical: 3,
// //                             ),
// //                             decoration: BoxDecoration(
// //                               color: chipBg,
// //                               borderRadius: BorderRadius.circular(8),
// //                             ),
// //                             child: Text(
// //                               labelText.toUpperCase(),
// //                               style: TextStyle(
// //                                 color: themeColor,
// //                                 fontSize: 10,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                           ),
// //                           Text(
// //                             time,
// //                             style: TextStyle(
// //                               color: Colors.grey.shade400,
// //                               fontSize: 11,
// //                               fontWeight: FontWeight.w500,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       const SizedBox(height: 8),
// //                       Text(
// //                         title,
// //                         style: TextStyle(
// //                           fontSize: 15,
// //                           fontWeight: FontWeight.w700,
// //                           color: isRead ? const Color(0xff1E293B) : primaryColor,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 4),
// //                       Text(
// //                         message,
// //                         style: TextStyle(
// //                           color: Colors.grey.shade600,
// //                           fontSize: 13,
// //                           height: 1.4,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 if (!isRead) ...[
// //                   const SizedBox(width: 8),
// //                   Container(
// //                     margin: const EdgeInsets.only(top: 4),
// //                     width: 8,
// //                     height: 8,
// //                     decoration: const BoxDecoration(
// //                       color: primaryColor,
// //                       shape: BoxShape.circle,
// //                     ),
// //                   ),
// //                 ],
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:smartcanteen/model/notification_model.dart';
// import 'package:smartcanteen/provider/notification_provider.dart';

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   int selectedTab = 0;
//   static const Color primaryColor = Color(0xff117992);
// // notification_screen.dart

// @override
// void initState() {
//   super.initState();
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     // Replace with your actual user token and backend API base URL
//     final provider = Provider.of<NotificationProvider>(context, listen: false);
//     // provider.fetchNotifications(userToken: 'YOUR_TOKEN', baseUrl: 'YOUR_BASE_URL');
//   });
// }
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<NotificationProvider>();

//     // Filter notifications based on selected tab
//     List<NotificationModel> displayedList;
//     switch (selectedTab) {
//       case 1:
//         displayedList = provider.notifications
//             .where((n) => n.type == NotificationType.order)
//             .toList();
//         break;
//       case 2:
//         displayedList = provider.notifications
//             .where((n) => n.type == NotificationType.transaction)
//             .toList();
//         break;
//       default:
//         displayedList = provider.notifications;
//     }

//     return Scaffold(
//       backgroundColor: const Color(0xffF6F8FC),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Top Header Bar
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//               margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xff0D6B80), Color(0xff117992)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(22),
//                 boxShadow: [
//                   BoxShadow(
//                     color: primaryColor.withOpacity(0.3),
//                     blurRadius: 12,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   InkWell(
//                     onTap: () => Navigator.pop(context),
//                     borderRadius: BorderRadius.circular(12),
//                     child: Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.18),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Icon(
//                         Icons.arrow_back_ios_new_rounded,
//                         color: Colors.white,
//                         size: 18,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 14),
//                   const Expanded(
//                     child: Text(
//                       'Notifications',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   if (provider.unreadCount > 0)
//                     GestureDetector(
//                       onTap: () => provider.markAllAsRead(),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.25),
//                           ),
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 6,
//                               height: 6,
//                               decoration: const BoxDecoration(
//                                 color: Color(0xff34D399),
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                             const SizedBox(width: 6),
//                             Text(
//                               '${provider.unreadCount} New',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 11,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),

//             // Tab Bar Switcher
//             NotificationTabBar(
//               selectedIndex: selectedTab,
//               onChanged: (index) {
//                 setState(() {
//                   selectedTab = index;
//                 });
//               },
//             ),
//             const SizedBox(height: 12),

//             // Main Notification List View
//             Expanded(
//               child: provider.isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : displayedList.isEmpty
//                       ? _buildEmptyState()
//                       : // notification_screen.dart

// ListView.builder(
//   padding: const EdgeInsets.symmetric(horizontal: 20),
//   itemCount: displayedList.length,
//   itemBuilder: (context, index) {
//     final item = displayedList[index];
//     return NotificationCard(
//       type: item.type,
//       title: item.title,
//       message: item.message,
//       time: item.time,
//       isRead: item.isRead,
//       onTap: () {
//         provider.markAsRead(item.id); // 👈 Pass item.id directly as int
//       },
//     );
//   },
// )
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(18),
//             decoration: BoxDecoration(
//               color: primaryColor.withOpacity(0.08),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.notifications_none_rounded,
//               size: 40,
//               color: primaryColor.withOpacity(0.6),
//             ),
//           ),
//           const SizedBox(height: 14),
//           Text(
//             'No notifications here',
//             style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey.shade700,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             'Your updates will show up here.',
//             style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class NotificationTabBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onChanged;

//   const NotificationTabBar({
//     super.key,
//     required this.selectedIndex,
//     required this.onChanged,
//   });

//   static const Color primaryColor = Color(0xff117992);

//   @override
//   Widget build(BuildContext context) {
//     final tabs = ['All', 'Orders', 'Transactions'];

//     return SizedBox(
//       height: 38,
//       child: ListView.separated(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         scrollDirection: Axis.horizontal,
//         itemCount: tabs.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 8),
//         itemBuilder: (context, index) {
//           final isSelected = selectedIndex == index;

//           return GestureDetector(
//             onTap: () => onChanged(index),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                 color: isSelected ? primaryColor : Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(
//                 child: Text(
//                   tabs[index],
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//                     color: isSelected ? Colors.white : Colors.grey.shade600,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class NotificationCard extends StatelessWidget {
//   final String title;
//   final String message;
//   final String time;
//   final bool isRead;
//   final NotificationType type;
//   final VoidCallback? onTap;
//   final VoidCallback? onLongPress; // 👈 1. Added onLongPress parameter

//   const NotificationCard({
//     super.key,
//     required this.title,
//     required this.message,
//     required this.time,
//     required this.type,
//     this.isRead = true,
//     this.onTap,
//     this.onLongPress, // 👈 2. Add to constructor
//   });

//   static const Color primaryColor = Color(0xff117992);

//   @override
//   Widget build(BuildContext context) {
//     final isOrder = type == NotificationType.order;

//     final Color themeColor =
//         isOrder ? const Color(0xffD97706) : const Color(0xff059669);

//     final Color chipBg =
//         isOrder ? const Color(0xffFFF7ED) : const Color(0xffECFDF5);

//     final IconData iconData = isOrder
//         ? Icons.local_mall_outlined
//         : Icons.account_balance_wallet_outlined;

//     final String labelText = isOrder ? 'Order' : 'Points';

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: isRead ? Colors.white : const Color(0xffF4F9FA),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: isRead
//               ? Colors.black.withOpacity(0.04)
//               : primaryColor.withOpacity(0.25),
//           width: 1.2,
//         ),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           onLongPress: onLongPress, // 👈 3. Connect InkWell onLongPress
//           borderRadius: BorderRadius.circular(20),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 48,
//                   height: 48,
//                   decoration: BoxDecoration(
//                     color: chipBg,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(iconData, color: themeColor, size: 22),
//                 ),
//                 const SizedBox(width: 14),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 3,
//                             ),
//                             decoration: BoxDecoration(
//                               color: chipBg,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               labelText.toUpperCase(),
//                               style: TextStyle(
//                                 color: themeColor,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           Text(
//                             time,
//                             style: TextStyle(
//                               color: Colors.grey.shade400,
//                               fontSize: 11,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         title,
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700,
//                           color: isRead ? const Color(0xff1E293B) : primaryColor,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         message,
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                           fontSize: 13,
//                           height: 1.4,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (!isRead) ...[
//                   const SizedBox(width: 8),
//                   Container(
//                     margin: const EdgeInsets.only(top: 4),
//                     width: 8,
//                     height: 8,
//                     decoration: const BoxDecoration(
//                       color: primaryColor,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcanteen/model/notification_model.dart';
import 'package:smartcanteen/provider/notification_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int selectedTab = 0;
  static const Color primaryColor = Color(0xff117992);
  bool isNotificationEnabled = true;

  @override
  void initState() {
    super.initState();
    _checkNotificationStatus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<NotificationProvider>(context, listen: false);
      // Uncomment to fetch fresh data from API when screen opens:
      // provider.fetchNotifications(userToken: 'YOUR_TOKEN', baseUrl: 'YOUR_BASE_URL');
    });
  }
Future<void> _checkNotificationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isNotificationEnabled = prefs.getBool('is_notification_on') ?? true;
    });
  }
  void _showDeleteDialog(BuildContext context, int notificationId, NotificationProvider provider) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Notification', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to delete this notification?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel', style: TextStyle(color: Colors.grey.shade600)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffEF4444),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              provider.deleteNotification(notificationId);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationProvider>();

    List<NotificationModel> displayedList;
    switch (selectedTab) {
      case 1:
        displayedList = provider.notifications
            .where((n) => n.type == NotificationType.order)
            .toList();
        break;
      case 2:
        displayedList = provider.notifications
            .where((n) => n.type == NotificationType.transaction)
            .toList();
        break;
      default:
        displayedList = provider.notifications;
    }

    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),
      body: SafeArea(
        child: Column(
          children: [
            // Header Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff0D6B80), Color(0xff117992)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'Notifications',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (provider.unreadCount > 0)
                    GestureDetector(
                      onTap: () => provider.markAllAsRead(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.25),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xff34D399),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${provider.unreadCount} New',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Tabs
            NotificationTabBar(
              selectedIndex: selectedTab,
              onChanged: (index) {
                setState(() {
                  selectedTab = index;
                });
              },
            ),
            const SizedBox(height: 12),

            // List
            Expanded(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : displayedList.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: displayedList.length,
                          itemBuilder: (context, index) {
                            final item = displayedList[index];
                            return NotificationCard(
                              type: item.type,
                              title: item.title,
                              message: item.message,
                              time: item.time,
                              isRead: item.isRead,
                              onTap: () => provider.markAsRead(item.id),
                              onLongPress: () => _showDeleteDialog(context, item.id, provider),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none_rounded,
              size: 40,
              color: primaryColor.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'No notifications here',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Your updates will show up here.',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}

class NotificationTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChanged;

  const NotificationTabBar({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  static const Color primaryColor = Color(0xff117992);

  @override
  Widget build(BuildContext context) {
    final tabs = ['All', 'Orders', 'Transactions'];

    return SizedBox(
      height: 38,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onChanged(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final bool isRead;
  final NotificationType type;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const NotificationCard({
    super.key,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = true,
    this.onTap,
    this.onLongPress,
  });

  static const Color primaryColor = Color(0xff117992);

  @override
  Widget build(BuildContext context) {
    final isOrder = type == NotificationType.order;

    final Color themeColor =
        isOrder ? const Color(0xffD97706) : const Color(0xff059669);

    final Color chipBg =
        isOrder ? const Color(0xffFFF7ED) : const Color(0xffECFDF5);

    final IconData iconData = isOrder
        ? Icons.local_mall_outlined
        : Icons.account_balance_wallet_outlined;

    final String labelText = isOrder ? 'Order' : 'Points';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : const Color(0xffF4F9FA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isRead
              ? Colors.black.withOpacity(0.04)
              : primaryColor.withOpacity(0.25),
          width: 1.2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: chipBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: themeColor, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: chipBg,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              labelText.toUpperCase(),
                              style: TextStyle(
                                color: themeColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            time,
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isRead ? const Color(0xff1E293B) : primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isRead) ...[
                  const SizedBox(width: 8),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}