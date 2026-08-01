import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smartcanteen/model/transaction_model.dart';
import 'package:smartcanteen/provider/user_provider.dart';
import 'package:smartcanteen/service/api_service.dart';
import 'package:smartcanteen/service/shared_preferences_service.dart';

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
  final ApiService _apiService = ApiService(); // Add ApiService

  // 1. Initialize with an empty list to prevent LateInitializationError
  List<TransactionModel> transactions = [];
  bool isLoadingTransactions = true;

  @override
  void initState() {
    super.initState();
    _loadLocalWalletBalance();
    _fetchUserTransactions(); // Fetch actual data
  }

  /// Loads cached wallet points and updates UserProvider
  Future<void> _loadLocalWalletBalance() async {
    try {
      final wallet = await SharedPreferencesService.getUserWallet();
      if (wallet != null && mounted) {
        context.read<UserProvider>().setBalance(wallet.balance);
      }
    } catch (e) {
      debugPrint("Error loading local wallet balance: $e");
    }
  }

  /// Fetch transactions from backend API
  Future<void> _fetchUserTransactions() async {
    try {
      final responseData = await _apiService.getTransactions();
      if (responseData != null && mounted) {
        setState(() {
          transactions = responseData
              .map((json) => TransactionModel.fromJson(json))
              .toList();
          isLoadingTransactions = false;
        });
      } else {
        setState(() => isLoadingTransactions = false);
      }
    } catch (e) {
      debugPrint("Error fetching wallet transactions: $e");
      if (mounted) setState(() => isLoadingTransactions = false);
    }
  }

  // Limit to only the 5 most recent transactions safely
  List<TransactionModel> get recentTransactions {
    if (transactions.isEmpty) return [];
    return transactions.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Watch dynamic balance from UserProvider
    final int currentBalance = context.watch<UserProvider>().balancePoints;
    final list = recentTransactions;

    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE3F2FD),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff1E293B)),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/navigation');
            }
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// 1. WALLET INFORMATION CARD
            _buildWalletInfoCard(currentBalance),

            const SizedBox(height: 16),

            /// 2. QUICK ACTIONS (Transfer, Receive, Scanner, History)
            _buildActionButtons(currentBalance),

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
  Widget _buildWalletInfoCard(int balance) {
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
                      Text(
                        NumberFormat('#,###').format(balance),
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
  Widget _buildActionButtons(int currentBalance) {
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
              context.go(
                '/transfer_point',
                extra: {
                  'currentBalance': currentBalance,
                  'onTransferCompleted': (int amount, String recipient) {
                    final newBalance = currentBalance - amount;

                    // Dynamically update user balance in Provider
                    context.read<UserProvider>().setBalance(newBalance);

                    setState(() {
  transactions.insert(
    0,
    TransactionModel(
      transactionId: DateTime.now().millisecondsSinceEpoch,
      amount: amount..toString(),
      transactionType: 'TRANSFER',
      status: 'success',
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
      remark: recipient,
    ),
  );
});
                  },
                },
              );
            },
          ),
          _buildActionButton(
            icon: Icons.qr_code_2_rounded,
            label: "ပွိုင့်လက်ခံမည်",
            onTap: () => context.go('user_qr'),
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
              context.push('/transaction_history', extra: transactions);
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

  /// TRANSACTION CARD
  Widget _buildTransactionCard(TransactionModel item) {
    final isReceived = item.type == TransactionType.received;
    final accentColor = isReceived
        ? const Color(0xff10B981)
        : const Color(0xffF59E0B);

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
            context.push('/transaction_history', extra: transactions);
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
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
                        item.time,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  item.amount.toString(),
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
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => context.pop(),
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