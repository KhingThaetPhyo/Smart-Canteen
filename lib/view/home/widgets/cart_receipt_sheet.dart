import 'package:flutter/material.dart';

class CartReceiptSheet extends StatefulWidget {
  final String shopName;
  final String? selectedSeatId;
  final List<Map<String, dynamic>> menuItems;
  final Function(Map<String, dynamic>) onAddToCart;
  final Function(Map<String, dynamic>) onRemoveFromCart;
  final VoidCallback onConfirmOrder;

  const CartReceiptSheet({
    super.key,
    required this.shopName,
    required this.selectedSeatId,
    required this.menuItems,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    required this.onConfirmOrder,
  });

  @override
  State<CartReceiptSheet> createState() => _CartReceiptSheetState();
}

class _CartReceiptSheetState extends State<CartReceiptSheet> {
  static const Color primaryColor = Color(0xff117992);

  // Helper to extract numeric points from strings like "250 pts"
  int _parsePrice(String priceStr) {
    final numStr = priceStr.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(numStr) ?? 0;
  }

  int get totalPoints {
    int total = 0;
    for (var item in widget.menuItems) {
      final int qty = item["cartQuantity"] ?? 0;
      if (qty > 0) {
        total += _parsePrice(item["price"]) * qty;
      }
    }
    return total;
  }

  void _showSuccessDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, anim1, anim2) {
        Future.delayed(const Duration(milliseconds: 1600), () {
          if (context.mounted) Navigator.of(context).pop();
        });

        return Align(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xff1E293B), // Dark slate theme
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xff10B981),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Confirmed",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Your food is being prepared",
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.2),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic)),
          child: FadeTransition(opacity: anim1, child: child),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = widget.menuItems
        .where((item) => (item["cartQuantity"] as int? ?? 0) > 0)
        .toList();

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
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
                    "ORDER SUMMARY",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0,
                      color: Colors.grey.shade500,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// SEAT INFO BADGE
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // <-- FIX IS HERE
                      children: [
                        const Icon(
                          Icons.chair_alt_rounded,
                          size: 16,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          widget.selectedSeatId != null
                              ? "Reserved Seat: ${widget.selectedSeatId}"
                              : "No Seat Selected (Takeaway)",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: widget.selectedSeatId != null
                                ? primaryColor
                                : Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

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
                            "Your cart is empty",
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
                        final int unitPrice = _parsePrice(item["price"]);
                        final int itemTotalPts = unitPrice * qty;

                        return Row(
                          children: [
                            /// ITEM DETAILS
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["name"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color(0xff1E293B),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "$unitPrice pts each",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// QUANTITY MODIFIER BUTTONS
                            Container(
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(
                                      minWidth: 28,
                                    ),
                                    icon: const Icon(
                                      Icons.remove,
                                      size: 14,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        widget.onRemoveFromCart(item);
                                      });
                                    },
                                  ),
                                  Text(
                                    '$qty',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(
                                      minWidth: 28,
                                    ),
                                    icon: const Icon(
                                      Icons.add,
                                      size: 14,
                                      color: primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        widget.onAddToCart(item);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 14),

                            /// TOTAL POINTS FOR ITEM
                            SizedBox(
                              width: 60,
                              child: Text(
                                "$itemTotalPts pts",
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

                  const SizedBox(height: 20),
                  _buildDottedDivider(),
                  const SizedBox(height: 16),

                  /// TOTAL POINTS DISPLAY
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "TOTAL POINTS",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          letterSpacing: 1.0,
                          color: Color(0xff1E293B),
                        ),
                      ),
                      Text(
                        "$totalPoints pts",
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

          /// CONFIRM ORDER / PLACE ORDER BUTTON
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: cartItems.isEmpty
                  ? null
                  : () {
                      Navigator.pop(context);

                      // Trigger the reset callback passed from parent
                      widget.onConfirmOrder();

                      // Show popup
                      _showSuccessDialog(context);
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
                    ? "Cart is Empty"
                    : "Confirm Order ($totalPoints pts)",
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
    );
  }

  /// HELPER FOR DASHED DIVISION LINES
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

/// CUSTOM CLIPPER FOR RECEIPT ZIGZAG EDGE AT THE BOTTOM
class ReceiptClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 12);

    // Number of teeth/zigzags along the bottom edge
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
