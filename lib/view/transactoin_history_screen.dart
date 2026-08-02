// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';
// import 'package:smartcanteen/model/transaction_model.dart';

// class TransactionHistoryScreen extends StatefulWidget {
//   final List<TransactionModel> transactions;

//   const TransactionHistoryScreen({super.key, required this.transactions});

//   @override
//   State<TransactionHistoryScreen> createState() =>
//       _TransactionHistoryScreenState();
// }

// class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
//   static const Color primaryColor = Color(0xff117992);
//   int _selectedTab = 0; // 0: အားလုံး, 1: လက်ခံရရှိငွေ, 2: လွှဲပြောင်းငွေ
//   String _searchQuery = "";
//   DateTimeRange? _selectedDateRange;

//   // ရက်စွဲအမျိုးမျိုးကို Parse လုပ်ပြီး Kpay ပုံစံ "d/M/yyyy HH:mm:ss" ပြောင်းပေးသည့် Helper
//   String _formatToEnglishDate(String time) {
//     final now = DateTime.now();
//     final normalizedTime = time.trim();

//     DateTime parsedDate = now;

//     if (normalizedTime.startsWith("Today") ||
//         normalizedTime.startsWith("ယနေ့")) {
//       parsedDate = DateTime(now.year, now.month, now.day, 12, 15);
//     } else if (normalizedTime.startsWith("Yesterday") ||
//         normalizedTime.startsWith("မနေ့က")) {
//       parsedDate = now.subtract(const Duration(days: 1));
//     } else if (normalizedTime.startsWith("Just now") ||
//         normalizedTime.startsWith("ခုနက")) {
//       parsedDate = now;
//     } else {
//       try {
//         parsedDate = DateFormat("dd MMM yyyy").parse(normalizedTime);
//       } catch (_) {
//         parsedDate = now;
//       }
//     }

//     return DateFormat("d/M/yyyy HH:mm:ss").format(parsedDate);
//   }

//   DateTime? _parseTransactionDate(String time) {
//     final now = DateTime.now();
//     final normalizedTime = time.trim();

//     if (normalizedTime.startsWith("Today") ||
//         normalizedTime.startsWith("ယနေ့") ||
//         normalizedTime.startsWith("Just now") ||
//         normalizedTime.startsWith("ခုနက")) {
//       return DateTime(now.year, now.month, now.day);
//     }

//     if (normalizedTime.startsWith("Yesterday") ||
//         normalizedTime.startsWith("မနေ့က")) {
//       final yesterday = now.subtract(const Duration(days: 1));
//       return DateTime(yesterday.year, yesterday.month, yesterday.day);
//     }

//     try {
//       return DateFormat("dd MMM yyyy").parseStrict(normalizedTime);
//     } catch (_) {
//       return null;
//     }
//   }

//   bool _isTransactionInsideDateRange(String transactionTime) {
//     if (_selectedDateRange == null) {
//       return true;
//     }

//     final transactionDate = _parseTransactionDate(transactionTime);
//     if (transactionDate == null) {
//       return false;
//     }

//     final normalizedTransactionDate = DateTime(
//       transactionDate.year,
//       transactionDate.month,
//       transactionDate.day,
//     );

//     final startDate = DateTime(
//       _selectedDateRange!.start.year,
//       _selectedDateRange!.start.month,
//       _selectedDateRange!.start.day,
//     );

//     final endDate = DateTime(
//       _selectedDateRange!.end.year,
//       _selectedDateRange!.end.month,
//       _selectedDateRange!.end.day,
//       23,
//       59,
//       59,
//     );

//     return !normalizedTransactionDate.isBefore(startDate) &&
//         !normalizedTransactionDate.isAfter(endDate);
//   }

//   List<TransactionModel> get _filteredTransactions {
//     return widget.transactions.where((transaction) {
//       final matchesTab =
//           _selectedTab == 0 ||
//           (_selectedTab == 1 && transaction.type == TransactionType.received) ||
//           (_selectedTab == 2 && transaction.type == TransactionType.spent);

//       final query = _searchQuery.trim().toLowerCase();
//       final matchesSearch =
//           query.isEmpty ||
//           transaction.title.toLowerCase().contains(query) ||
//           transaction.subtitle.toLowerCase().contains(query) ||
//           transaction.amount.toLowerCase().contains(query);

//       final matchesDate = _isTransactionInsideDateRange(transaction.time);

//       return matchesTab && matchesSearch && matchesDate;
//     }).toList();
//   }

//   Future<void> _selectDateRange() async {
//     final now = DateTime.now();

//     final selectedRange = await showDateRangePicker(
//       context: context,
//       firstDate: DateTime(2020),
//       lastDate: DateTime(now.year + 5),
//       initialDateRange: _selectedDateRange,
//       helpText: "ရက်စွဲ ရွေးချယ်ပါ",
//       saveText: "အတည်ပြုမည်",
//       cancelText: "မလုပ်တော့ပါ",
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: primaryColor,
//               onPrimary: Colors.white,
//               surface: Colors.white,
//               onSurface: Color(0xff1E293B),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (selectedRange != null) {
//       setState(() {
//         _selectedDateRange = selectedRange;
//       });
//     }
//   }

//   void _clearDateFilter() {
//     setState(() {
//       _selectedDateRange = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final list = _filteredTransactions;

//     return Scaffold(
//       backgroundColor: const Color(0xff0D6B80),
//       body: SafeArea(
//         child: Column(
//           children: [
//             /// HEADER BAR
//             Container(
//               margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.15),
//                 borderRadius: BorderRadius.circular(22),
//                 border: Border.all(color: Colors.white.withOpacity(0.2)),
//               ),
//               child: Row(
//                 children: [
//                   Material(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(14),
//                     child: IconButton(
//                       icon: const Icon(
//                         Icons.arrow_back_ios_rounded,
//                         color: Colors.white,
//                         size: 18,
//                       ),
//                       onPressed: () => context.pop(),
//                     ),
//                   ),
//                   const Expanded(
//                     child: Text(
//                       "ပွိုင့်လွှဲမှတ်တမ်း",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 48),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 12),

//             /// CONTENT CONTAINER
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
//                 decoration: const BoxDecoration(
//                   color: Color(0xffF4F6F9),
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     /// SEARCH BAR WITH DATE FILTER
//                     TextField(
//                       onChanged: (value) {
//                         setState(() {
//                           _searchQuery = value;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         hintText: "မှတ်တမ်းများ ရှာဖွေပါ...",
//                         hintStyle: TextStyle(
//                           color: Colors.grey.shade400,
//                           fontSize: 14,
//                         ),
//                         prefixIcon: const Icon(
//                           Icons.search_rounded,
//                           color: primaryColor,
//                           size: 20,
//                         ),
//                         suffixIcon: Padding(
//                           padding: const EdgeInsets.all(6),
//                           child: Material(
//                             color: _selectedDateRange != null
//                                 ? primaryColor
//                                 : const Color(0xffEAF7F9),
//                             borderRadius: BorderRadius.circular(12),
//                             child: InkWell(
//                               onTap: () {
//                                 if (_selectedDateRange != null) {
//                                   _clearDateFilter();
//                                 } else {
//                                   _selectDateRange();
//                                 }
//                               },
//                               borderRadius: BorderRadius.circular(12),
//                               child: Icon(
//                                 _selectedDateRange != null
//                                     ? Icons.close_rounded
//                                     : Icons.calendar_month_rounded,
//                                 color: _selectedDateRange != null
//                                     ? Colors.white
//                                     : primaryColor,
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                         contentPadding: const EdgeInsets.symmetric(
//                           vertical: 12,
//                           horizontal: 16,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16),
//                           borderSide: BorderSide(color: Colors.grey.shade200),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16),
//                           borderSide: BorderSide(
//                             color: _selectedDateRange != null
//                                 ? primaryColor
//                                 : Colors.grey.shade200,
//                             width: _selectedDateRange != null ? 1.5 : 1,
//                           ),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16),
//                           borderSide: const BorderSide(
//                             color: primaryColor,
//                             width: 1.5,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),

//                     /// FILTER TABS
//                     Row(
//                       children:
//                           [
//                             "အားလုံး",
//                             "လက်ခံရရှိပွိုင့်",
//                             "လွှဲပြောင်းပွိုင့်",
//                           ].asMap().entries.map((entry) {
//                             final index = entry.key;
//                             final label = entry.value;
//                             final isSelected = _selectedTab == index;

//                             return Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                   right: index < 2 ? 8 : 0,
//                                 ),
//                                 child: InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       _selectedTab = index;
//                                     });
//                                   },
//                                   borderRadius: BorderRadius.circular(12),
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                       vertical: 10,
//                                     ),
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                       color: isSelected
//                                           ? primaryColor
//                                           : Colors.white,
//                                       borderRadius: BorderRadius.circular(12),
//                                       border: Border.all(
//                                         color: isSelected
//                                             ? primaryColor
//                                             : Colors.grey.shade200,
//                                       ),
//                                     ),
//                                     child: Text(
//                                       label,
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: isSelected
//                                             ? FontWeight.bold
//                                             : FontWeight.w500,
//                                         color: isSelected
//                                             ? Colors.white
//                                             : const Color(0xff64748B),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                     ),
//                     const SizedBox(height: 16),

//                     /// TRANSACTION LIST / EMPTY STATE
//                     Expanded(
//                       child: list.isEmpty
//                           ? Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.receipt_long_rounded,
//                                     size: 48,
//                                     color: Colors.grey.shade300,
//                                   ),
//                                   const SizedBox(height: 10),
//                                   Text(
//                                     "ပွိုင့်လွှဲမှတ်တမ်း ရှာမတွေ့ပါ",
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey.shade600,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           : ListView.builder(
//                               itemCount: list.length,
//                               itemBuilder: (context, index) {
//                                 final item = list[index];
//                                 final isReceived =
//                                     item.type == TransactionType.received;
//                                 final accentColor = isReceived
//                                     ? const Color(0xff10B981)
//                                     : const Color(0xffF59E0B);

//                                 final String displayTitle =
//                                     item.subtitle.isNotEmpty
//                                     ? "${item.title} ${item.subtitle}"
//                                     : item.title;

//                                 return Container(
//                                   margin: const EdgeInsets.only(bottom: 10),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(16),
//                                     border: Border.all(
//                                       color: Colors.grey.shade200,
//                                     ),
//                                   ),
//                                   // Click feedback ရအောင် InkWell သုံးထားပါသည်
//                                   child: Material(
//                                     color: Colors.transparent,
//                                     borderRadius: BorderRadius.circular(16),
//                                     child: InkWell(
//                                       borderRadius: BorderRadius.circular(16),
//                                       onTap: () {
//                                         // Detail Screen သို့ သွားရန် Navigation
//                                         context.go('/transaction_detail', extra: item);
//                                       },
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(12),
//                                         child: Row(
//                                           children: [
//                                             // Icon
//                                             Container(
//                                               padding: const EdgeInsets.all(10),
//                                               decoration: BoxDecoration(
//                                                 color: accentColor.withOpacity(
//                                                   0.12,
//                                                 ),
//                                                 shape: BoxShape.circle,
//                                               ),
//                                               child: Icon(
//                                                 isReceived
//                                                     ? Icons.add_card_rounded
//                                                     : Icons
//                                                           .shopping_bag_outlined,
//                                                 color: accentColor,
//                                                 size: 20,
//                                               ),
//                                             ),
//                                             const SizedBox(width: 12),

//                                             // Left: Title & Date (English Format)
//                                             Expanded(
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     displayTitle,
//                                                     maxLines: 1,
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     style: const TextStyle(
//                                                       fontSize: 14,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: Color(0xff1E293B),
//                                                     ),
//                                                   ),
//                                                   const SizedBox(height: 4),
//                                                   Text(
//                                                     _formatToEnglishDate(
//                                                       item.time,
//                                                     ),
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       color:
//                                                           Colors.grey.shade500,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),

//                                             const SizedBox(width: 8),

//                                             // Right: Amount
//                                             Text(
//                                               item.amount,
//                                               style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: isReceived
//                                                     ? const Color(0xff059669)
//                                                     : const Color(0xffE11D48),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smartcanteen/model/transaction_model.dart';
import 'package:smartcanteen/service/api_service.dart'; // ApiService import လုပ်ရန်

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  static const Color primaryColor = Color(0xff117992);
  final ApiService _apiService = ApiService();
  
  late Future<List<TransactionModel>> _transactionsFuture;

  int _selectedTab = 0; // 0: အားလုံး, 1: လက်ခံရရှိငွေ, 2: လွှဲပြောင်းငွေ
  String _searchQuery = "";
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = _fetchTransactions();
  }

  // API မှ ငွေလွှဲမှတ်တမ်းများ လှမ်းယူခြင်း
  Future<List<TransactionModel>> _fetchTransactions() async {
    try {
      final responseData = await _apiService.getTransactions();
      if (responseData != null) {
        return responseData.map((json) => TransactionModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print("Error loading transactions: $e");
      return [];
    }
  }

  // ရက်စွဲအမျိုးမျိုးကို Parse လုပ်ပြီး Kpay ပုံစံ "d/M/yyyy HH:mm:ss" ပြောင်းပေးသည့် Helper
  String _formatToEnglishDate(String time) {
    final now = DateTime.now();
    final normalizedTime = time.trim();

    DateTime parsedDate = now;
    try {
      // API မှလာသော ISO 8601 format (ဥပမာ - 2026-07-31T12:31:01.000000Z) ကို Parse လုပ်ခြင်း
      parsedDate = DateTime.parse(normalizedTime);
    } catch (_) {
      parsedDate = now;
    }

    return DateFormat("d/M/yyyy HH:mm:ss").format(parsedDate);
  }

  DateTime? _parseTransactionDate(String time) {
    try {
      return DateTime.parse(time.trim());
    } catch (_) {
      return null;
    }
  }

  bool _isTransactionInsideDateRange(String transactionTime) {
    if (_selectedDateRange == null) {
      return true;
    }

    final transactionDate = _parseTransactionDate(transactionTime);
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
  
// List<TransactionModel> _getFilteredTransactions(List<TransactionModel> transactions) {
//     const int currentWalletId = 10; // လက်ရှိ login ဝင်ထားသော user ၏ wallet id

//     return transactions.where((transaction) {
//       // Tab အလိုက် စစ်ထုတ်ခြင်း
//       bool matchesTab = true;
//       if (_selectedTab == 1) {
//         // ပွိုင့်လက်ခံရရှိခြင်း
//         matchesTab = transaction.transactionType == 'top-up' || transaction.toWalletId == currentWalletId;
//       } else if (_selectedTab == 2) {
//         // ပွိုင့်လွှဲပြောင်းခြင်း (from_wallet_id က current user ဖြစ်ရမည်)
//         matchesTab = transaction.fromWalletId == currentWalletId && transaction.transactionType == 'TRANSFER';
//       } else if (_selectedTab == 3) {
//        // အော်ဒါငွေပေးချေခြင်း
//         matchesTab = transaction.transactionType == 'order_payment';
//       } 

//       // ရှာဖွေရန် စာသား (Search Query) စစ်ဆေးခြင်း
//       final query = _searchQuery.trim().toLowerCase();
//       final amountStr = transaction.amount.toString();
//       final displayAmountStr = transaction.displayAmount?.toLowerCase() ?? "";
      
//       final matchesSearch =
//           query.isEmpty ||
//           transaction.title.toLowerCase().contains(query) ||
//           transaction.subtitle.toLowerCase().contains(query) ||
//           amountStr.contains(query) ||
//           displayAmountStr.contains(query);

//       // ရက်စွဲအလိုက် စစ်ဆေးခြင်း
//       final matchesDate = _isTransactionInsideDateRange(transaction.time);

//       return matchesTab && matchesSearch && matchesDate;
//     }).toList();
//   }
List<TransactionModel> _getFilteredTransactions(List<TransactionModel> transactions) {
  return transactions.where((transaction) {
    bool matchesTab = true;

    if (_selectedTab == 1) {
      // ပွိုင့်လက်ခံရရှိခြင်း (inflow)
      matchesTab = transaction.direction == 'inflow' || transaction.transactionType == 'top-up';
    } else if (_selectedTab == 2) {
      // ပွိုင့်လွှဲပြောင်းခြင်း (outflow transfers)
      matchesTab = transaction.direction == 'outflow' &&
          (transaction.transactionType == 'TRANSFER' || transaction.transactionType == 'transfer');
    } else if (_selectedTab == 3) {
      // အော်ဒါငွေပေးချေခြင်း
      matchesTab = transaction.transactionType == 'order_payment';
    }

    final query = _searchQuery.trim().toLowerCase();
    final amountStr = transaction.amount.toString();
    final displayAmountStr = transaction.displayAmount?.toLowerCase() ?? "";

    final matchesSearch = query.isEmpty ||
        transaction.title.toLowerCase().contains(query) ||
        transaction.subtitle.toLowerCase().contains(query) ||
        amountStr.contains(query) ||
        displayAmountStr.contains(query);

    final matchesDate = _isTransactionInsideDateRange(transaction.time);

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
      helpText: "ရက်စွဲ ရွေးချယ်ပါ",
      saveText: "အတည်ပြုမည်",
      cancelText: "မလုပ်တော့ပါ",
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
                      onPressed: () => context.go('/navigation'),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      "ပွိုင့်လွှဲမှတ်တမ်း",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
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
                        hintText: "မှတ်တမ်းများ ရှာဖွေပါ...",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: primaryColor,
                          size: 20,
                        ),
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
                                  _clearDateFilter();
                                } else {
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

                    /// FILTER TABS
                    SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  physics: const BouncingScrollPhysics(),
  child: Row(
    children: [
      "အားလုံး",
     // "ပွိုင့်ဖြည့်ခြင်း",
      "ပွိုင့်လက်ခံရရှိခြင်း",
      "ပွိုင့်လွှဲပြောင်းပွိုင့်ခြင်း",
      "‌အော်ဒါငွေပေးချေခြင်း",
    ].asMap().entries.map((entry) {
      final index = entry.key;
      final label = entry.value;
      final isSelected = _selectedTab == index;

      return Padding(
        padding: EdgeInsets.only(
          right: index < 4 ? 8.0 : 0.0, // Add spacing between items
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
              horizontal: 16,
              vertical: 10,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? primaryColor : Colors.grey.shade200,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xff64748B),
              ),
            ),
          ),
        ),
      );
    }).toList(),
  ),
),
                    const SizedBox(height: 16),

                    /// FUTURE BUILDER FOR TRANSACTION LIST
                    Expanded(
                      child: FutureBuilder<List<TransactionModel>>(
                        future: _transactionsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(color: primaryColor),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                "အချက်အလက် ရယူရန် အမှားအယွင်းရှိနေပါသည်",
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            );
                          }

                          final allTransactions = snapshot.data ?? [];
                          final list = _getFilteredTransactions(allTransactions);

                          if (list.isEmpty) {
                            // အချက်အလက်မရှိပါက စာသားသက်သက်သာ ပြသရန်
                            return Center(
                              child: Text(
                                "မှတ်တမ်း မရှိသေးပါ",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                             // ကျန်ရှိနေသည့် ListView ကုဒ်များ...
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final item = list[index];
                              final isReceived =
                                  item.type == TransactionType.received;
                              final accentColor = isReceived
                                  ? const Color(0xff10B981)
                                  : const Color(0xffF59E0B);

                              final String displayTitle =
                                  item.subtitle.isNotEmpty
                                  ? "${item.title} "
                                  : item.title;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: () {
                                      context.go('/transaction_detail', extra: item);
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                  _formatToEnglishDate(item.time),
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
                                            "${item.amount}",
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
                            },
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