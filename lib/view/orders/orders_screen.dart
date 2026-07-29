import 'package:flutter/material.dart';
import 'order_detail.dart';

enum OrderStatus { pending, preparing, ready, completed }

enum DateFilter { allTime, today, thisWeek, thisMonth }

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _selectedTabIndex = 0;
  DateFilter _selectedDateFilter = DateFilter.today;
  static const Color primaryColor = Color(0xff117992);

  // Status Filter များကို မြန်မာလို ပြောင်းလဲထားပါသည်
  final List<String> _filters = [
    'အားလုံး',
    'စောင့်ဆိုင်းဆဲ',
    'ပြင်ဆင်နေဆဲ',
    'အသင့်ဖြစ်ပြီ',
    'ပြီးစီးပြီ',
  ];

  final List<Map<String, dynamic>> _canteenOrders = [
    {
      'shopName': 'အန်တီမွန်',
      'orderDate': 'ယနေ့ ညနေ ၁၂:၁၅',
      'dateTime': DateTime.now(),
      'pickupCode': 'MBK-1003',
      'status': OrderStatus.ready,
      'items': [
        {
          'item': {'name': 'ကြက်ကြော်ထမင်းကြော်', 'quantity': 1},
          'unitPoints': 500,
        },
        {
          'item': {'name': 'သံပုရာ အေးခဲလက်ဖက်ရည်', 'quantity': 1},
          'unitPoints': 150,
        },
      ],
    },
    {
      'shopName': 'ဘာဂါနှင့် ဂရီးလ် ထမင်းဆိုင်',
      'orderDate': 'ယနေ့ ညနေ ၁၂:၄၀ ',
      'dateTime': DateTime.now(),
      'pickupCode': 'MBK-1004',
      'status': OrderStatus.preparing,
      'items': [
        {
          'item': {'name': 'ဒိန်ခဲနှစ်ထပ် ဘာဂါ', 'quantity': 1},
          'unitPoints': 620,
        },
        {
          'item': {'name': 'အာလူးကြော် (M)', 'quantity': 2},
          'unitPoints': 100,
        },
      ],
    },
    {
      'shopName': 'လတ်ဆတ် သစ်သီးဖျော်ရည်နှင့် အအေးဆိုင်',
      'orderDate': 'မနေ့ ညနေ ၁၂:၁၅',
      'dateTime': DateTime.now().subtract(const Duration(days: 1)),
      'pickupCode': 'MBK-1001',
      'status': OrderStatus.pending,
      'items': [
        {
          'item': {'name': 'သရက်သီး ဖျော်ရည်', 'quantity': 1},
          'unitPoints': 300,
        },
      ],
    },
    {
      'shopName': 'ပါစတာနှင့် အီတလီ အစားအစာဆိုင်',
      'orderDate': '၃ ရက်မတိုင်မီ၊ညနေ ၁:၁၀ ',
      'dateTime': DateTime.now().subtract(const Duration(days: 3)),
      'pickupCode': 'MBK-0998',
      'status': OrderStatus.completed,
      'items': [
        {
          'item': {'name': 'ခရမ်မီ ပါစတာ', 'quantity': 1},
          'unitPoints': 750,
        },
      ],
    },
  ];

  String _getDateFilterLabel(DateFilter filter) {
    switch (filter) {
      case DateFilter.today:
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

    final filteredOrders = _canteenOrders.where((order) {
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
      backgroundColor: const Color(0xFFE3F2FD),
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
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
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

    int totalPoints = 0;
    for (var itemData in order['items']) {
      final int qty = itemData['item']['quantity'] ?? 1;
      final int unitPoints = itemData['unitPoints'] ?? 0;
      totalPoints += unitPoints * qty;
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

                /// ORDER DETAILS BUTTON
                SizedBox(
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailScreen(order: order),
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
      case OrderStatus.pending:
        bg = const Color(0xffFEF3C7);
        fg = const Color(0xffD97706);
        text = "စောင့်ဆိုင်းဆဲ";
        icon = Icons.hourglass_top_rounded;
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
          const SizedBox(height: 6),
          Text(
            "အခြေအနေ သို့မဟုတ် ရက်စွဲအလိုက် အခြားစစ်ဆေးမှုများ ပြုလုပ်ကြည့်ပါ။",
            style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}
