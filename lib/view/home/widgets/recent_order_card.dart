import 'package:flutter/material.dart';

// OrderItem with optional unitPoints
class OrderItem {
  final String name;
  final int quantity;
  final int unitPoints;

  const OrderItem({
    required this.name,
    required this.quantity,
    this.unitPoints = 0,
  });
}

enum OrderStatus { pending, preparing, ready, completed }

class RecentOrderCard extends StatelessWidget {
  final String shopName;
  final String orderDate;
  final String totalPrice;
  final List<OrderItem> items;
  final OrderStatus status;
  final VoidCallback? onReorder;

  const RecentOrderCard({
    super.key,
    required this.shopName,
    required this.orderDate,
    required this.totalPrice,
    required this.items,
    this.status = OrderStatus.completed,
    this.onReorder,
  });

  static const Color primaryColor = Color(0xff117992);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// SHOP NAME & DATE HEADER WITH STATUS BADGE
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
                            shopName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1E293B),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            orderDate,
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

          /// LIST OF ITEMS (Matching Order Screen styling)
          Column(
            children: items.map((item) {
              final int itemTotalPoints = item.unitPoints * item.quantity;

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quantity Badge
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

                    // Name & "pts each" Subtitle
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
                          if (item.unitPoints > 0) ...[
                            const SizedBox(height: 2),
                            Text(
                              "${item.unitPoints} pts each",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Right-aligned Total Item Points
                    if (item.unitPoints > 0)
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

          /// TOTAL PRICE & ACTION BUTTON
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
                    totalPrice,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              _buildActionButton(status),
            ],
          ),
        ],
      ),
    );
  }

  /// HELPER: STATUS BADGES
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

  /// HELPER: CONTEXTUAL ACTION BUTTON
  Widget _buildActionButton(OrderStatus status) {
    if (status == OrderStatus.ready) {
      return SizedBox(
        height: 38,
        child: ElevatedButton.icon(
          onPressed: onReorder,
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
          onPressed: onReorder ?? () {},
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
          onPressed: onReorder,
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
}
