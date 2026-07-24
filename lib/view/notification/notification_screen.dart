import 'package:flutter/material.dart';

import 'widgets/notification_card.dart';
import 'widgets/notification_tab_bar.dart';
import '../orders/widgets/pickup_qr_dialog.dart';

class NotificationModel {
  final String id;
  final NotificationType type;
  final String? pickupCode;
  final String title;
  final String message;
  final String time;
  bool isRead;

  NotificationModel({
    required this.id,
    this.pickupCode,
    required this.type,
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int selectedTab = 0;
  static const Color primaryColor = Color(0xff117992);

  // Mock Notifications (Only Orders & Transactions)
  final List<NotificationModel> notifications = [
    NotificationModel(
      id: "1",
      pickupCode: "MBK-1003",
      type: NotificationType.order,
      title: "Order Ready",
      message: "Your Milk Tea is ready for pickup at Coffee Corner.",
      time: "2 min ago",
      isRead: false,
    ),
    NotificationModel(
      id: "2",
      type: NotificationType.order,
      title: "Order Completed",
      message: "Your Shan Noodle order has been completed successfully.",
      time: "1 hour ago",
      isRead: true,
    ),
    NotificationModel(
      id: "3",
      type: NotificationType.transaction,
      title: "Points Received",
      message: "You received 500 pts from Mg Mg.",
      time: "Today • 10:30 AM",
      isRead: false,
    ),
    NotificationModel(
      id: "4",
      type: NotificationType.transaction,
      title: "Payment Successful",
      message: "1,500 pts paid to Coffee Corner.",
      time: "Yesterday",
      isRead: true,
    ),
  ];

  /// Filter notifications based on selected tab
  List<NotificationModel> get filteredNotifications {
    switch (selectedTab) {
      case 1:
        return notifications
            .where((n) => n.type == NotificationType.order)
            .toList();
      case 2:
        return notifications
            .where((n) => n.type == NotificationType.transaction)
            .toList();
      default:
        return notifications;
    }
  }

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  void _markAllAsRead() {
    setState(() {
      for (var item in notifications) {
        item.isRead = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayedList = filteredNotifications;

    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),
      body: SafeArea(
        child: Column(
          children: [
            /// COLORED HEADER WITH GRADIENT & SHADOW
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
                  /// BACK BUTTON
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

                  /// TITLE
                  const Expanded(
                    child: Text(
                      "Notifications",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  /// UNREAD BADGE / MARK READ BUTTON
                  if (unreadCount > 0)
                    GestureDetector(
                      onTap: _markAllAsRead,
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
                                color: Color(
                                  0xff34D399,
                                ), // Soft green indicator
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "$unreadCount New",
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

            const SizedBox(height: 4),

            /// TAB BAR
            NotificationTabBar(
              selectedIndex: selectedTab,
              onChanged: (index) {
                setState(() {
                  selectedTab = index;
                });
              },
            ),

            const SizedBox(height: 12),

            /// NOTIFICATIONS LIST VIEW
            Expanded(
              child: displayedList.isEmpty
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
                          onTap: () {
                            setState(() {
                              item.isRead = true;
                            });

                            if (item.pickupCode != null) {
                              showPickUpCodeDialog(context, item.pickupCode!);
                            }
                          },
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
            "No notifications here",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Your updates will show up here.",
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
