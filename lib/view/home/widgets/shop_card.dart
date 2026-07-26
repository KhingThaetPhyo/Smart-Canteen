import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  final String shopName;
  final String category;
  final bool isOpen;
  final String estimatedTime;
  final VoidCallback? onTap;

  const ShopCard({
    super.key,
    required this.shopName,
    required this.category,
    required this.isOpen,
    required this.estimatedTime,
    this.onTap,
  });

  static const Color primaryColor = Color(0xff117992);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      // Dim card opacity when closed to clearly signal it's non-interactive
      opacity: isOpen ? 1.0 : 0.6,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff117992).withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            // Prevent navigation when the shop is closed
            onTap: isOpen ? onTap : null,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  /// SHOP LOGO
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: isOpen
                          ? primaryColor.withOpacity(0.08)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.storefront_rounded,
                      size: 38,
                      color: isOpen ? primaryColor : Colors.grey.shade400,
                    ),
                  ),

                  const SizedBox(width: 14),

                  /// CONTENT
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                shopName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isOpen
                                      ? const Color(0xff1E293B)
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ),

                            /// OPEN / CLOSED BADGE
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: isOpen
                                    ? const Color(0xff10B981).withOpacity(0.1)
                                    : const Color(0xffEF4444).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                isOpen ? "Open" : "Closed",
                                style: TextStyle(
                                  color: isOpen
                                      ? const Color(0xff059669)
                                      : const Color(0xffDC2626),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        Text(
                          category,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
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
      ),
    );
  }
}
