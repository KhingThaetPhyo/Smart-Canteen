import 'package:flutter/material.dart';

enum NotificationType { order, transaction }

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final bool isRead;
  final NotificationType type;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = true,
    this.onTap,
  });

  static const Color primaryColor = Color(0xff117992);

  @override
  Widget build(BuildContext context) {
    final isOrder = type == NotificationType.order;

    // Distinct Theme Palettes
    final Color themeColor = isOrder
        ? const Color(0xffD97706)
        : const Color(0xff059669);
    final Color chipBg = isOrder
        ? const Color(0xffFFF7ED)
        : const Color(0xffECFDF5);
    final IconData iconData = isOrder
        ? Icons.local_mall_outlined
        : Icons.account_balance_wallet_outlined;
    final String labelText = isOrder ? "Order" : "Points";

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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ICON BADGE WITH SOFT BG & SHADOW
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: chipBg,
                    shape: BoxShape.circle,
                    border: Border.all(color: themeColor.withOpacity(0.2)),
                  ),
                  child: Icon(iconData, color: themeColor, size: 22),
                ),

                const SizedBox(width: 14),

                /// DETAILS
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// HEADER ROW (CHIP + TIME)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// CATEGORY PILL CHIP
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: chipBg,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(iconData, size: 11, color: themeColor),
                                const SizedBox(width: 4),
                                Text(
                                  labelText.toUpperCase(),
                                  style: TextStyle(
                                    color: themeColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// TIME
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

                      /// TITLE
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isRead
                              ? const Color(0xff1E293B)
                              : primaryColor,
                        ),
                      ),

                      const SizedBox(height: 4),

                      /// MESSAGE BODY
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

                /// UNREAD DOT
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
