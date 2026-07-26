import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/transaction_model.dart';

class TransactionHistoryScreen extends StatefulWidget {
  final List<TransactionModel> transactions;

  const TransactionHistoryScreen({super.key, required this.transactions});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  static const Color primaryColor = Color(0xff117992);
  int _selectedTab = 0; // 0: All, 1: Received, 2: Spent
  String _searchQuery = "";
  DateTimeRange? _selectedDateRange;

  DateTime? _parseTransactionDate(String time) {
    final now = DateTime.now();
    final normalizedTime = time.trim();

    // Handles: "Today • 11:15 AM"
    if (normalizedTime.startsWith("Today")) {
      return DateTime(now.year, now.month, now.day);
    }

    // Handles: "Yesterday"
    if (normalizedTime.startsWith("Yesterday")) {
      final yesterday = now.subtract(const Duration(days: 1));

      return DateTime(yesterday.year, yesterday.month, yesterday.day);
    }

    // Handles newly created transaction: "Just now"
    if (normalizedTime.startsWith("Just now")) {
      return DateTime(now.year, now.month, now.day);
    }

    // Handles: "18 Jul 2026"
    try {
      return DateFormat("dd MMM yyyy").parseStrict(normalizedTime);
    } catch (_) {
      return null;
    }
  }

  bool _isTransactionInsideDateRange(String transactionTime) {
    if (_selectedDateRange == null) {
      return true;
    }

    final transactionDate = _parseTransactionDate(transactionTime);

    // Hide unrecognized dates while a date filter is active
    if (transactionDate == null) {
      return false;
    }

    final normalizedTransactionDate = DateTime(
      transactionDate.year,
      transactionDate.month,
      transactionDate.day,
    );

    final startDate = DateTime(
      _selectedDateRange!.start.year,
      _selectedDateRange!.start.month,
      _selectedDateRange!.start.day,
    );

    final endDate = DateTime(
      _selectedDateRange!.end.year,
      _selectedDateRange!.end.month,
      _selectedDateRange!.end.day,
      23,
      59,
      59,
    );

    return !normalizedTransactionDate.isBefore(startDate) &&
        !normalizedTransactionDate.isAfter(endDate);
  }

  List<TransactionModel> get _filteredTransactions {
    return widget.transactions.where((transaction) {
      // 1. Filter by All / Received / Spent
      final matchesTab =
          _selectedTab == 0 ||
          (_selectedTab == 1 && transaction.type == TransactionType.received) ||
          (_selectedTab == 2 && transaction.type == TransactionType.spent);

      // 2. Filter by search text
      final query = _searchQuery.trim().toLowerCase();

      final matchesSearch =
          query.isEmpty ||
          transaction.title.toLowerCase().contains(query) ||
          transaction.subtitle.toLowerCase().contains(query) ||
          transaction.amount.toLowerCase().contains(query);

      // 3. Filter by selected date range
      final matchesDate = _isTransactionInsideDateRange(transaction.time);

      // Transaction must match all active filters
      return matchesTab && matchesSearch && matchesDate;
    }).toList();
  }

  Future<void> _selectDateRange() async {
    final now = DateTime.now();

    final selectedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 5),
      initialDateRange: _selectedDateRange,
      helpText: "Select transaction dates",
      saveText: "Apply",
      cancelText: "Cancel",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xff1E293B),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedRange != null) {
      setState(() {
        _selectedDateRange = selectedRange;
      });
    }
  }

  void _clearDateFilter() {
    setState(() {
      _selectedDateRange = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final list = _filteredTransactions;

    return Scaffold(
      backgroundColor: const Color(0xff0D6B80),
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER BAR
            Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Material(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      "Transaction History",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balances out back button layout
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// CONTENT CONTAINER
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                decoration: const BoxDecoration(
                  color: Color(0xffF4F6F9),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// SEARCH BAR WITH DATE FILTER
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search transactions...",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),

                        // Search icon on the left
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: primaryColor,
                          size: 20,
                        ),

                        // Calendar filter button on the right
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Material(
                            color: _selectedDateRange != null
                                ? primaryColor
                                : const Color(0xffEAF7F9),
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              onTap: () {
                                if (_selectedDateRange != null) {
                                  // Clear the selected date filter
                                  _clearDateFilter();
                                } else {
                                  // Open the date picker
                                  _selectDateRange();
                                }
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Icon(
                                _selectedDateRange != null
                                    ? Icons.close_rounded
                                    : Icons.calendar_month_rounded,
                                color: _selectedDateRange != null
                                    ? Colors.white
                                    : primaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ),

                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: _selectedDateRange != null
                                ? primaryColor
                                : Colors.grey.shade200,
                            width: _selectedDateRange != null ? 1.5 : 1,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: primaryColor,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// FILTER TABS (All, Received, Spent)
                    Row(
                      children: ["All", "Received", "Spent"]
                          .asMap()
                          .entries
                          .map((entry) {
                            final index = entry.key;
                            final label = entry.value;
                            final isSelected = _selectedTab == index;

                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: index < 2 ? 8 : 0,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedTab = index;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? primaryColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected
                                            ? primaryColor
                                            : Colors.grey.shade200,
                                      ),
                                    ),
                                    child: Text(
                                      label,
                                      style: TextStyle(
                                        fontSize: 13,
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
                          })
                          .toList(),
                    ),
                    const SizedBox(height: 16),

                    /// TRANSACTION LIST / EMPTY STATE
                    Expanded(
                      child: list.isEmpty
                          ? Center(
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
                            )
                          : ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                final item = list[index];
                                final isReceived =
                                    item.type == TransactionType.received;
                                final accentColor = isReceived
                                    ? const Color(0xff10B981)
                                    : const Color(0xffF59E0B);

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                    ),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
