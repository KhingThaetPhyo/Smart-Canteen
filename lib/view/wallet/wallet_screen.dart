import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transfer_screen.dart';
import '../../model/transaction_model.dart';
import 'history_screen.dart';
import '../scanner/scanner_screen.dart';

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

  int selectedTab = 0; // 0: All, 1: Received, 2: Spent
  int currentBalance = 12450;

  final List<TransactionModel> transactions = [
    TransactionModel(
      id: "0",
      title: "Points Transferred",
      subtitle: "To Myint Myat",
      amount: "-1,000 pts",
      time: "Today • 11:15 AM",
      type: TransactionType.spent,
    ),
    TransactionModel(
      id: "1",
      title: "Points Received",
      subtitle: "From Mg Mg",
      amount: "+500 pts",
      time: "Today • 10:30 AM",
      type: TransactionType.received,
    ),
    TransactionModel(
      id: "2",
      title: "Coffee Corner",
      subtitle: "Payment",
      amount: "-1,500 pts",
      time: "Today • 08:15 AM",
      type: TransactionType.spent,
    ),
    TransactionModel(
      id: "3",
      title: "Shan Noodle Shop",
      subtitle: "Payment",
      amount: "-2,800 pts",
      time: "Yesterday",
      type: TransactionType.spent,
    ),
    TransactionModel(
      id: "4",
      title: "Points Received",
      subtitle: "From student affairs",
      amount: "+200 pts",
      time: "18 Jul 2026",
      type: TransactionType.received,
    ),
    TransactionModel(
      id: "5",
      title: "Snack Station",
      subtitle: "Payment",
      amount: "-600 pts",
      time: "17 Jul 2026",
      type: TransactionType.spent,
    ),
    TransactionModel(
      id: "6",
      title: "Points Received",
      subtitle: "From student affairs",
      amount: "+1,000 pts",
      time: "15 Jul 2026",
      type: TransactionType.received,
    ),
  ];

  List<TransactionModel> get filteredTransactions {
    List<TransactionModel> list;
    if (selectedTab == 1) {
      list = transactions
          .where((t) => t.type == TransactionType.received)
          .toList();
    } else if (selectedTab == 2) {
      list = transactions
          .where((t) => t.type == TransactionType.spent)
          .toList();
    } else {
      list = transactions;
    }

    // Limit to only the 5 most recent transactions
    return list.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = filteredTransactions;

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

            /// 3. RECENT HISTORY SECTION HEADER & FILTERS
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
                    widget.userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "ID: ${widget.studentId}",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
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
                      "Wallet",
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
          const SizedBox(height: 20),
          Text(
            "Available Balance",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${NumberFormat('#,###').format(currentBalance)} pts",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
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
            label: "Transfer",
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
                            title: "Points Transferred",
                            subtitle: "To $recipient",
                            amount: "-$amount pts",
                            time: "Just now",
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
            label: "Receive",
            onTap: () => _showReceiveQRModal(context),
          ),
          _buildActionButton(
            icon: Icons.qr_code_scanner_rounded,
            label: "Scanner",
            onTap: () {
              widget.onOpenScanner?.call();
            },
          ),
          _buildActionButton(
            icon: Icons.history_rounded,
            label: "History",
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

  /// 3. HISTORY HEADER & FILTER TABS
  Widget _buildHistoryHeader() {
    final tabs = ["All", "Received", "Spent"];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent History",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1E293B),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TransactionHistoryScreen(transactions: transactions),
                    ),
                  );
                },
                child: const Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: List.generate(tabs.length, (index) {
              final isSelected = selectedTab == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: index == 2 ? 0 : 8),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.grey.shade200,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xff64748B),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  /// TRANSACTION CARD
  Widget _buildTransactionCard(TransactionModel item) {
    final isReceived = item.type == TransactionType.received;
    final accentColor = isReceived
        ? const Color(0xff10B981)
        : const Color(0xffF59E0B);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isReceived ? Icons.add_card_rounded : Icons.shopping_bag_outlined,
              color: accentColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1E293B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.amount,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isReceived
                      ? const Color(0xff059669)
                      : const Color(0xffE11D48),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item.time,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
              ),
            ],
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
          Icon(
            Icons.receipt_long_rounded,
            size: 48,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 10),
          Text(
            "No transactions found",
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
              "Receive Points",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Show this QR code to the sender to receive points",
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
                    "ID: ${widget.studentId}",
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
                  "Done",
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
