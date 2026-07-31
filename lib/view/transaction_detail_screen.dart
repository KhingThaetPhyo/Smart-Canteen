import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/model/transaction_model.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction;
  final String
  phoneNumber; // ဖုန်းနံပါတ် ထည့်သွင်းရန် parameter (Optional)[cite: 2]

  const TransactionDetailScreen({
    super.key,
    required this.transaction,
    this.phoneNumber = "09971238377", // Default Test Phone Number[cite: 2]
  });

  // Main Teal Theme Color[cite: 2]
  static const Color primaryTeal = Color(0xff117992);
  static const Color lightTeal = Color(0xFFE0F2F1);

  // Kpay Style Phone Masking Helper Function[cite: 2]
  // ဥပမာ - 09971238377 -> (******8377)[cite: 2]
  String _maskPhoneNumber(String phone) {
    if (phone.length >= 4) {
      final lastFour = phone.substring(phone.length - 4);
      return "(******$lastFour)";
    }
    return phone;
  }

  @override
  Widget build(BuildContext context) {
    final isReceived = transaction.type == TransactionType.received;
    final String labelTitle = isReceived ? "ပေးပို့သူ" : "ပွိုင့်လွှဲမည် သို့";
    final String recipientName = transaction.subtitle.isNotEmpty
        ? transaction.subtitle
        : "Myint Myat";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // 1. App Bar
      appBar: AppBar(
        title: const Text(
          "လုပ်ဆောင်ချက် အသေးစိတ်",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryTeal,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 2. Detail Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Status Icon Container
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: lightTeal,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      size: 48,
                      color: primaryTeal,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Transaction Status Text
                  const Text(
                    "လုပ်ဆောင်ချက် အောင်မြင်ပါသည်",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryTeal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Amount Text
                  Text(
                    transaction.amount,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isReceived ? const Color(0xff059669) : primaryTeal,
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Divider(thickness: 1, height: 24, color: lightTeal),

                  // 1. လုပ်ဆောင်သောအချိန် (Kpay Date Format ဖြင့် ပေါ်မည်)[cite: 2]
                  _buildDetailRow("လုပ်ဆောင်သောအချိန်", transaction.time),

                  // 2. လုပ်ဆောင်မှုအမျိုးအစား[cite: 2]
                  _buildDetailRow(
                    "လုပ်ဆောင်မှုအမျိုးအစား",
                    isReceived ? "ပွိုင့်လက်ခံ" : "ပွိုင့်လွှဲ",
                  ),

                  // 3. ပွိုင့်လွှဲမည် သို့ / ပေးပို့သူ (Kpay Style နာမည် + ဖုန်းနံပါတ်)[cite: 2]
                  _buildUserDetailRow(
                    labelTitle,
                    recipientName,
                    _maskPhoneNumber(phoneNumber),
                  ),

                  // 4. လုပ်ဆောင်ချက် အမှတ် (ID)[cite: 2]
                  _buildDetailRow("လုပ်ဆောင်ချက် အမှတ် (ID)", transaction.id),

                  // 5. ပွိုင့်ပမာဏ[cite: 2]
                  _buildDetailRow("ပွိုင့်ပမာဏ", transaction.amount),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ရိုးရိုး Detail Row[cite: 2]
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: primaryTeal,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: primaryTeal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Kpay ပုံစံ အမည်နှင့် ဖုန်းနံပါတ် အောက်ချင်းကပ်ပြသည့် Row[cite: 2]
  Widget _buildUserDetailRow(String label, String name, String maskedPhone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: primaryTeal,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: primaryTeal,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  maskedPhone,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryTeal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}