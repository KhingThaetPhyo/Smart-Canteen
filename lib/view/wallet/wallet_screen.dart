import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartcanteen/view/wallet/history_screen_detail.dart';
import 'transfer_screen.dart';
import '../../model/transaction_model.dart';
import 'history_screen.dart';

class WalletScreen extends StatefulWidget {
  final String userName;
  final String studentId;

  // Callback used to switch MainNavigation to Scanner tab
  final VoidCallback? onOpenScanner;

  const WalletScreen({
    super.key,
    this.userName = "Wa Thon",
    this.studentId = "UCSTT(22-23)-000",
    this.onOpenScanner,
  });

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  static const Color primaryColor = Color(0xff117992);

  int currentBalance = 12450;

  // Kpay style date formatter (e.g., 4/12/2026 15:36:12)
  final DateFormat _kpayDateFormat = DateFormat('M/d/yyyy HH:mm:ss');

  late List<TransactionModel> transactions;

  @override
  void initState() {
    super.initState();
    // Kpay Style ရက်စွဲ စာသားများဖြင့် Initial Transactions တည်ဆောက်ထားခြင်း[cite: 1]
    transactions = [
      TransactionModel(
        id: "0",
        title: "ငွေလွှဲမည် သို့",
        subtitle: "Myint Myat",
        amount: "-1,000 ပွိုင့်",
        time: _kpayDateFormat.format(DateTime(2026, 7, 28, 12, 15, 0)),
        type: TransactionType.spent,
      ),
      TransactionModel(
        id: "1",
        title: "ပေးပို့သူ",
        subtitle: "Mg Mg",
        amount: "+500 ပွိုင့်",
        time: _kpayDateFormat.format(DateTime(2026, 7, 28, 12, 15, 0)),
        type: TransactionType.received,
      ),
      TransactionModel(
        id: "2",
        title: "Coffee Corner",
        subtitle: "(ကျသင့်ပွိုင့်ပေးချေမှု)",
        amount: "-1,500 ပွိုင့်",
        time: _kpayDateFormat.format(DateTime(2026, 7, 28, 12, 15, 0)),
        type: TransactionType.spent,
      ),
      TransactionModel(
        id: "3",
        title: "ရှမ်းခေါက်ဆွဲဆိုင်",
        subtitle: "(ကျသင့်ပွိုင့်ပေးချေမှု)",
        amount: "-2,800 ပွိုင့်",
        time: _kpayDateFormat.format(DateTime(2026, 7, 27, 18, 30, 0)),
        type: TransactionType.spent,
      ),
      TransactionModel(
        id: "4",
        title: "ပေးပို့သူ",
        subtitle: "ကျောင်းသားရေးရာ",
        amount: "+200 ပွိုင့်",
        time: _kpayDateFormat.format(DateTime(2026, 7, 18, 9, 15, 20)),
        type: TransactionType.received,
      ),
      TransactionModel(
        id: "5",
        title: "Snack Station",
        subtitle: "(ကျသင့်ပွိုင့်ပေးချေမှု)",
        amount: "-600 ပွိုင့်",
        time: _kpayDateFormat.format(DateTime(2026, 7, 17, 14, 45, 10)),
        type: TransactionType.spent,
      ),
      TransactionModel(
        id: "6",
        title: "ပေးပို့သူ",
        subtitle: "ကျောင်းသားရေးရာ",
        amount: "+1,000 ပွိုင့်",
        time: _kpayDateFormat.format(DateTime(2026, 7, 15, 10, 0, 0)),
        type: TransactionType.received,
      ),
    ];
  }

  // Limit to only the 5 most recent transactions
  List<TransactionModel> get recentTransactions {
    return transactions.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = recentTransactions;

    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      body: SafeArea(
        child: Column(
          children: [
            /// 1. WALLET INFORMATION CARD
            _buildWalletInfoCard(),

            const SizedBox(height: 16),

            /// 2. QUICK ACTIONS (Transfer, Receive, Scanner, History)
            _buildActionButtons(),

            const SizedBox(height: 20),

            /// 3. RECENT HISTORY SECTION HEADER
            _buildHistoryHeader(),

            const SizedBox(height: 12),

            /// 4. RECENT TRANSACTIONS LIST (Limited to 5)
            Expanded(
              child: list.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 30,
                      ),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return _buildTransactionCard(list[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// 1. WALLET INFO HEADER CARD
  Widget _buildWalletInfoCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff0D6B80), Color(0xff117992)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "သုံးစွဲနိုင်သော လက်ကျန်ပွိုင့်",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const SizedBox(width: 50),
                      Text(
                        NumberFormat('#,###').format(currentBalance),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        "ပွိုင့်",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "ပိုက်ဆံအိတ်",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 2. ACTIONS: TRANSFER, RECEIVE, SCANNER, HISTORY
  Widget _buildActionButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(
            icon: Icons.send_rounded,
            label: "ပွိုင့်လွှဲမည်",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransferScreen(
                    currentBalance: currentBalance,
                    onTransferCompleted: (amount, recipient) {
                      setState(() {
                        currentBalance -= amount;
                        transactions.insert(
                          0,
                          TransactionModel(
                            id: DateTime.now().millisecondsSinceEpoch
                                .toString(),
                            title: "ငွေလွှဲမည် သို့",
                            subtitle: recipient,
                            amount: "-$amount ပွိုင့်",
                            time: _kpayDateFormat.format(
                              DateTime.now(),
                            ), // Kpay Format အသုံးပြုထားပါသည်[cite: 1]
                            type: TransactionType.spent,
                          ),
                        );
                      });
                    },
                  ),
                ),
              );
            },
          ),
          _buildActionButton(
            icon: Icons.qr_code_2_rounded,
            label: "ပွိုင့်လက်ခံမည်",
            onTap: () => _showReceiveQRModal(context),
          ),
          _buildActionButton(
            icon: Icons.qr_code_scanner_rounded,
            label: "QR စကင်ဖတ်မည်",
            onTap: () {
              widget.onOpenScanner?.call();
            },
          ),
          _buildActionButton(
            icon: Icons.history_rounded,
            label: "ပွိုင့်လွှဲမှတ်တမ်း",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TransactionHistoryScreen(transactions: transactions),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xffEAF7F9),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: primaryColor, size: 22),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xff334155),
            ),
          ),
        ],
      ),
    );
  }

  /// 3. HISTORY HEADER
  Widget _buildHistoryHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            "မကြာသေးမီက ပွိုင့်လွှဲထားသည်များ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff1E293B),
            ),
          ),
        ],
      ),
    );
  }

  /// TRANSACTION CARD (Updated KBZ Pay format)
  Widget _buildTransactionCard(TransactionModel item) {
    final isReceived = item.type == TransactionType.received;
    final accentColor = isReceived
        ? const Color(0xff10B981)
        : const Color(0xffF59E0B);

    // Kpay Style Title Format
    final String displayTitle = item.subtitle.isNotEmpty
        ? "${item.title} ${item.subtitle}"
        : item.title;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoryScreenDetail(transaction: item),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isReceived
                        ? Icons.add_card_rounded
                        : Icons.shopping_bag_outlined,
                    color: accentColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),

                // Title and Time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.time, // Kpay Style ရက်စွဲ စာသား ပြသပေးမည်[cite: 1]
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Amount
                Text(
                  item.amount,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isReceived
                        ? const Color(0xff059669)
                        : const Color(0xffE11D48),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_rounded,
            size: 48,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 10),
          Text(
            "ပွိုင့်လွှဲမှတ်တမ်း မရှိသေးပါ",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// MODAL BOTTOM SHEET TO SHOW RECEIVE QR CODE
  void _showReceiveQRModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle Bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "ပွိုင့်လက်ခံမည်",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Point လက်ခံရန် ဤ QR Code ကို ပေးပို့သူအား ပြပါ",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 24),

            // QR Code Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xffF8FAFC),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xffE2E8F0)),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.qr_code_2_rounded,
                    size: 200,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.userName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "အိုင်ဒီ - ${widget.studentId}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Close Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "ပြီးပြီ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
