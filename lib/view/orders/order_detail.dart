import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // intl package အား import လုပ်ပါ
import '../orders/widgets/pickup_qr_dialog.dart';
import 'orders_screen.dart'; // OrderStatus enum ကို သုံးနိုင်ရန် Import လုပ်ပေးပါ

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailScreen({super.key, required this.order});

  // Teal Theme Color
  static const Color primaryTeal = Color(0xff117992);
  static final Color lightTeal = Colors.teal.shade50;
  static final Color darkTeal = const Color(0xff117992);

  // ရက်စွဲကို 5/12/2026 15:55:00 Format ဖြင့် ပြောင်းလဲပေးသည့် Helper Function
  String _formatEnglishDateTime(dynamic dateInput) {
    if (dateInput == null) return '';

    if (dateInput is DateTime) {
      return DateFormat('d/M/yyyy HH:mm:ss').format(dateInput);
    } else if (dateInput is String) {
      final parsedDate = DateTime.tryParse(dateInput);
      if (parsedDate != null) {
        return DateFormat('d/M/yyyy HH:mm:ss').format(parsedDate);
      }
      return dateInput; // Parse လုပ်မရပါက မူရင်းအတိုင်း ပြသမည်
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final String shopName = order['shopName'] ?? 'အန်တီမွန် စားသောက်ဆိုင်';
    final String customerName = order['customerName'] ?? 'Aung Aung';

    // dateTime (သို့မဟုတ်) orderDate ကို English Date Format ပြောင်းလဲခြင်း
    final String orderDate = _formatEnglishDateTime(
      order['dateTime'] ?? order['orderDate'],
    );

    final String phone = order['phone'] ?? '09 790182418';
    final String code = order['pickupCode'] ?? 'MBK-1000';
    final List items = order['items'] ?? [];

    // Status စစ်ဆေးရန် (Ready ဖြစ်မဖြစ်)
    final OrderStatus? status = order['status'];
    final bool isReady = status == OrderStatus.ready;

    // Total ကျသင့်ငွေ တွက်ချက်ခြင်း
    int totalAmount = 0;
    for (var itemData in items) {
      final int qty = itemData['item']['quantity'] ?? 1;
      final int price = itemData['unitPoints'] ?? 0;
      totalAmount += price * qty;
    }

    return Scaffold(
      backgroundColor: lightTeal,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryTeal, primaryTeal.withOpacity(0.85)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: primaryTeal.withOpacity(0.35),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(-2, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "$shopName စားသောက်ဆိုင်",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.3,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            /// 1. RECEIPT SLIP CARD
            ClipPath(
              clipper: ReceiptClipper(),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    /// 2. HEADER - SHOP NAME & INFO
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "အော်ဒါပြေစာ",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: darkTeal,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _buildInfoRow("ဝယ်ယူသူ", customerName),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildInfoRow("ရက်စွဲ", orderDate),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow("ဖုန်းနံပါတ်", phone),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// 3. ITEMS LIST
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: lightTeal,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 6,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                  child: Text(
                                    "စဉ်",
                                    textAlign: TextAlign.center,
                                    style: _headerStyle(darkTeal),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "အမျိုးအမည်",
                                    style: _headerStyle(darkTeal),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "အရေတွက်",
                                    textAlign: TextAlign.center,
                                    style: _headerStyle(darkTeal),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "ဈေးနှုန်း",
                                    textAlign: TextAlign.right,
                                    style: _headerStyle(darkTeal),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "သင့်ပွိုင့်",
                                    textAlign: TextAlign.right,
                                    style: _headerStyle(darkTeal),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 6),

                          ...List.generate(items.length, (index) {
                            final itemData = items[index];
                            final item = itemData['item'];
                            final int qty = item['quantity'] ?? 1;
                            final int price = itemData['unitPoints'] ?? 0;
                            final int subtotal = price * qty;

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 6,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                    child: Text(
                                      "${index + 1}",
                                      textAlign: TextAlign.center,
                                      style: _cellStyle,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      item['name'] ?? '',
                                      style: _cellStyle,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "$qty",
                                      textAlign: TextAlign.center,
                                      style: _cellStyle,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "$price",
                                      textAlign: TextAlign.right,
                                      style: _cellStyle,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "$subtotal",
                                      textAlign: TextAlign.right,
                                      style: _cellStyleBold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),

                          const SizedBox(height: 8),

                          Container(
                            decoration: BoxDecoration(
                              color: lightTeal,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 12,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "စုစုပေါင်းကျသင့်ပွိုင့်",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: darkTeal,
                                  ),
                                ),
                                Text(
                                  "$totalAmount ပွိုင့်",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: primaryTeal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    /// 4. SCAN PICK UP CODE BUTTON
                    if (isReady)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 36),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryTeal.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () =>
                                    showPickUpCodeDialog(context, code),
                                borderRadius: BorderRadius.circular(16),
                                child: Ink(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.teal.shade500,
                                        Colors.teal.shade700,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(
                                        Icons.qr_code_scanner_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "ပစ္စည်းယူရန် QR ကုဒ်",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Info Text Row Helper
  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label : ",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade700,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: darkTeal,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  // Text Styles
  static TextStyle _headerStyle(Color color) =>
      TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color);

  static const TextStyle _cellStyle = TextStyle(
    fontSize: 12,
    color: Color(0xFF334155),
  );

  static const TextStyle _cellStyleBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.teal,
  );
}

/// RECEIPT ZIG-ZAG CUT CLIPPER
class ReceiptClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 10);

    double x = 0;
    double y = size.height - 10;
    double increment = 8;

    while (x < size.width) {
      x += increment;
      y = (y == size.height - 10) ? size.height : size.height - 10;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
