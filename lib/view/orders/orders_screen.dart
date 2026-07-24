import 'package:flutter/material.dart';
import '../home/widgets/recent_order_card.dart';
import '../orders/widgets/pickup_qr_dialog.dart';

// Order Status Enum for Canteen Lifecycle
enum OrderStatus { pending, preparing, ready, completed }

// Date Filter Options
enum DateFilter { allTime, today, thisWeek, thisMonth }

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _selectedTabIndex = 0;
  DateFilter _selectedDateFilter = DateFilter.allTime;
  static const Color primaryColor = Color(0xff117992);

  // Status Filter Categories
  final List<String> _filters = [
    'All',
    'Pending',
    'Preparing',
    'Ready',
    'Completed',
  ];

  // Smart Canteen Orders Data with raw DateTime for precise date filtering
  final List<Map<String, dynamic>> _canteenOrders = [
    {
      'shopName': 'Noodle & Rice Express',
      'orderDate': 'Today, 12:15 PM',
      'dateTime': DateTime.now(),
      'pickupCode': 'MBK-1003',
      'status': OrderStatus.ready,
      'items': [
        {
          'item': const OrderItem(
            name: 'Fried Rice w/ Chicken Cutlet',
            quantity: 1,
          ),
          'unitPoints': 500,
        },
        {
          'item': const OrderItem(name: 'Iced Lemon Tea', quantity: 1),
          'unitPoints': 150,
        },
      ],
    },
    {
      'shopName': 'Burger & Grill Corner',
      'orderDate': 'Today, 12:40 PM',
      'dateTime': DateTime.now(),
      'pickupCode': 'MBK-1004',
      'status': OrderStatus.preparing,
      'items': [
        {
          'item': const OrderItem(name: 'Double Cheese Burger', quantity: 1),
          'unitPoints': 620,
        },
        {
          'item': const OrderItem(name: 'French Fries (M)', quantity: 2),
          'unitPoints': 100,
        },
      ],
    },
    {
      'shopName': 'Fresh Juice & Drinks',
      'orderDate': 'Yesterday, 12:45 PM',
      'dateTime': DateTime.now().subtract(const Duration(days: 1)),
      'pickupCode': 'MBK-1001',
      'status': OrderStatus.pending,
      'items': [
        {
          'item': const OrderItem(name: 'Mango Smoothie', quantity: 1),
          'unitPoints': 300,
        },
      ],
    },
    {
      'shopName': 'Pasta & Italian Counter',
      'orderDate': '3 days ago, 1:10 PM',
      'dateTime': DateTime.now().subtract(const Duration(days: 3)),
      'pickupCode': 'MBK-0998',
      'status': OrderStatus.completed,
      'items': [
        {
          'item': const OrderItem(name: 'Creamy Carbonara Pasta', quantity: 1),
          'unitPoints': 750,
        },
      ],
    },
  ];

  String _getDateFilterLabel(DateFilter filter) {
    switch (filter) {
      case DateFilter.today:
        return 'Today';
      case DateFilter.thisWeek:
        return 'This Week';
      case DateFilter.thisMonth:
        return 'This Month';
      case DateFilter.allTime:
      default:
        return 'All Time';
    }
  }

  // Place this at the VERY BOTTOM of orders_screen.dart (outside _OrdersScreenState)

  // Opens the Date Filter Selection Sheet
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
                  "Filter by Date",
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
                    setState(() => _selectedDateFilter = filter);
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
    final now = DateTime.now();

    // Filter orders according to selected tab and selected date option
    final filteredOrders = _canteenOrders.where((order) {
      // Status Filter Logic
      bool matchesStatus = true;
      if (_selectedTabIndex == 1)
        matchesStatus = order['status'] == OrderStatus.pending;
      if (_selectedTabIndex == 2)
        matchesStatus = order['status'] == OrderStatus.preparing;
      if (_selectedTabIndex == 3)
        matchesStatus = order['status'] == OrderStatus.ready;
      if (_selectedTabIndex == 4)
        matchesStatus = order['status'] == OrderStatus.completed;

      if (!matchesStatus) return false;

      // Date Filter Logic
      final DateTime date = order['dateTime'];
      switch (_selectedDateFilter) {
        case DateFilter.today:
          return date.year == now.year &&
              date.month == now.month &&
              date.day == now.day;
        case DateFilter.thisWeek:
          return now.difference(date).inDays <= 7;
        case DateFilter.thisMonth:
          return date.year == now.year && date.month == now.month;
        case DateFilter.allTime:
        default:
          return true;
      }
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: Column(
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order History",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Track your previous meals",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                // High-Contrast Date Filter Pill
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _showDateFilterPicker,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
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
                          Text(
                            _getDateFilterLabel(_selectedDateFilter),
                            style: const TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
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

          /// ORDERS LIST
          Expanded(
            child: filteredOrders.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.only(
                      top: 8,
                      bottom: MediaQuery.of(context).padding.bottom + 90,
                    ),
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      return _buildCanteenOrderCard(order);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  /// CANTEEN ORDER CARD
  Widget _buildCanteenOrderCard(Map<String, dynamic> order) {
    final OrderStatus status = order['status'];
    final String code = order['pickupCode'] ?? 'MBK-1000';
    final List<Map<String, dynamic>> rawItems = List<Map<String, dynamic>>.from(
      order['items'],
    );

    int totalPoints = 0;
    for (var itemData in rawItems) {
      final OrderItem item = itemData['item'];
      final int unitPoints = itemData['unitPoints'] ?? 0;
      totalPoints += unitPoints * item.quantity;
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          // Tap handler: Opens pickup dialog if order status is ready
          onTap: () {
            if (status == OrderStatus.ready) {
              showPickUpCodeDialog(context, code);
            }
          },
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
                                  order['shopName'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff1E293B),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  order['orderDate'],
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

                Column(
                  children: rawItems.map((itemData) {
                    final OrderItem item = itemData['item'];
                    final int unitPoints = itemData['unitPoints'] ?? 0;
                    final int itemTotalPoints = unitPoints * item.quantity;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "${item.quantity}x",
                              style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "$unitPoints pts each",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "$itemTotalPoints pts",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color(0xff1E293B),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
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
                          "TOTAL POINTS",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            color: Color(0xff64748B),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "$totalPoints pts",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    _buildActionButton(status, code),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// HELPER: COLOR-CODED STATUS BADGES
  Widget _buildStatusBadge(OrderStatus status) {
    Color bg;
    Color fg;
    String text;
    IconData icon;

    switch (status) {
      case OrderStatus.pending:
        bg = const Color(0xffFEF3C7);
        fg = const Color(0xffD97706);
        text = "Pending";
        icon = Icons.hourglass_top_rounded;
        break;
      case OrderStatus.preparing:
        bg = const Color(0xffE0F2FE);
        fg = const Color(0xff0284C7);
        text = "Preparing";
        icon = Icons.soup_kitchen_rounded;
        break;
      case OrderStatus.ready:
        bg = const Color(0xffDCFCE7);
        fg = const Color(0xff16A34A);
        text = "Ready";
        icon = Icons.check_circle_rounded;
        break;
      case OrderStatus.completed:
        bg = const Color(0xffF1F5F9);
        fg = const Color(0xff64748B);
        text = "Completed";
        icon = Icons.task_alt_rounded;
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

  /// HELPER: CONTEXTUAL ACTION BUTTON BASED ON STATUS
  Widget _buildActionButton(OrderStatus status, String pickupCode) {
    if (status == OrderStatus.ready) {
      return SizedBox(
        height: 38,
        child: ElevatedButton.icon(
          onPressed: () => showPickUpCodeDialog(context, pickupCode),
          icon: const Icon(Icons.qr_code_rounded, size: 16),
          label: const Text(
            "Pick Up Code",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff16A34A),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
    } else if (status == OrderStatus.completed) {
      return SizedBox(
        height: 38,
        child: OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.refresh_rounded, size: 16),
          label: const Text(
            "Reorder",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 38,
        child: TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.timer_outlined, size: 16),
          label: const Text(
            "In Progress",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          style: TextButton.styleFrom(foregroundColor: const Color(0xff0284C7)),
        ),
      );
    }
  }

  /// EMPTY STATE
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.no_meals_rounded, size: 60, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            "No food orders found",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Try changing your status or date filter.",
            style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}
