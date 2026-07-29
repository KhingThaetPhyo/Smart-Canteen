// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class TransferScreen extends StatefulWidget {
//   final int currentBalance;
//   final Function(int amount, String recipient) onTransferCompleted;

//   const TransferScreen({
//     super.key,
//     required this.currentBalance,
//     required this.onTransferCompleted,
//   });

//   @override
//   State<TransferScreen> createState() => _TransferScreenState();
// }

// class _TransferScreenState extends State<TransferScreen> {
//   static const Color primaryColor = Color(0xff117992);

//   final TextEditingController _recipientController = TextEditingController();
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _pinController = TextEditingController();

//   final List<int> _presetAmounts = [100, 500, 1000, 5000];
//   bool _isPinModalOpen = false;

//   void _handleTransfer() {
//     final int? amount = int.tryParse(
//       _amountController.text.replaceAll(',', ''),
//     );
//     final String recipient = _recipientController.text.trim();

//     if (amount == null || amount <= 0 || recipient.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("အချက်အလက်များကို မှန်ကန်စွာ ဖြည့်သွင်းပါ"),
//         ),
//       );
//       return;
//     }

//     if (amount > widget.currentBalance) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("လက်ကျန် ပွိုင့် မလုံလောက်ပါ!")),
//       );
//       return;
//     }

//     _showPinBottomSheet(amount, recipient);
//   }

//   void _showPinBottomSheet(int amount, String recipient) {
//     _pinController.clear();
//     setState(() {
//       _isPinModalOpen = true;
//     });

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setModalState) {
//             return Container(
//               padding: EdgeInsets.fromLTRB(
//                 24,
//                 24,
//                 24,
//                 MediaQuery.of(context).viewInsets.bottom + 24,
//               ),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Handle Bar
//                   Container(
//                     width: 36,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade300,
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                   const SizedBox(height: 22),

//                   // Header Layout with Amount Indicator
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "PIN နံပါတ် ရိုက်ထည့်ပါ",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xff0F172A),
//                             ),
//                           ),
//                           SizedBox(height: 2),
//                           Text(
//                             "ဂဏန်း ၈ လုံးပါ လျှို့ဝှက်နံပါတ်ဖြင့် အတည်ပြုပါ",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Color(0xff64748B),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color: const Color(0xffF1F5F9),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Text(
//                           "${NumberFormat('#,###').format(amount)} ပွိုင့်",
//                           style: const TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                             color: primaryColor,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),

//                   // Hidden TextField for keyboard capture (does not auto-submit on length 8)
//                   TextField(
//                     controller: _pinController,
//                     keyboardType: TextInputType.number,
//                     maxLength: 8,
//                     autofocus: true,
//                     style: const TextStyle(color: Colors.transparent),
//                     cursorColor: Colors.transparent,
//                     decoration: const InputDecoration(
//                       counterText: "",
//                       border: InputBorder.none,
//                       enabledBorder: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                     ),
//                     onChanged: (value) {
//                       setModalState(() {});
//                     },
//                   ),

//                   // Segmented Floating Cards Layout (Split into 2 groups of 4 with a hyphen)
//                   GestureDetector(
//                     onTap: () {},
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Row(
//                           children: List.generate(4, (index) {
//                             return _buildPinBoxCell(index, setModalState);
//                           }),
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 6),
//                           child: Text(
//                             "-",
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                         Row(
//                           children: List.generate(4, (index) {
//                             return _buildPinBoxCell(index + 4, setModalState);
//                           }),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 28),

//                   // Action Button (Requires manual press when 8 digits are entered)
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: _pinController.text.length == 8
//                           ? () {
//                               Navigator.pop(context);
//                               _executeFinalTransfer(amount, recipient);
//                             }
//                           : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: primaryColor,
//                         disabledBackgroundColor: const Color(0xffF1F5F9),
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                       ),
//                       child: Text(
//                         "ပွိုင့်လွှဲမှု အတည်ပြုမည်",
//                         style: TextStyle(
//                           color: _pinController.text.length == 8
//                               ? Colors.white
//                               : Colors.grey.shade400,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     ).then((_) {
//       setState(() {
//         _isPinModalOpen = false;
//       });
//     });
//   }

//   // Helper widget for individual split cell boxes
//   Widget _buildPinBoxCell(int index, StateSetter setModalState) {
//     final text = _pinController.text;
//     final isFilled = index < text.length;

//     return Container(
//       width: 32,
//       height: 44,
//       margin: const EdgeInsets.symmetric(horizontal: 2),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: isFilled
//             ? primaryColor.withOpacity(0.04)
//             : const Color(0xffF8FAFC),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: isFilled ? primaryColor : Colors.grey.shade300,
//           width: isFilled ? 1.5 : 1,
//         ),
//       ),
//       child: Text(
//         isFilled ? "•" : "",
//         style: TextStyle(
//           fontSize: isFilled ? 22 : 15,
//           fontWeight: FontWeight.bold,
//           color: isFilled ? primaryColor : Colors.grey.shade400,
//         ),
//       ),
//     );
//   }

//   void _executeFinalTransfer(int amount, String recipient) {
//     widget.onTransferCompleted(amount, recipient);
//     Navigator.pop(context);

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           "$recipient ထံသို့ ${NumberFormat('#,###').format(amount)} ပွိုင့် လွှဲပြောင်းပေးပြီးပါပြီ!",
//         ),
//         backgroundColor: primaryColor,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff0D6B80),
//       body: SafeArea(
//         child: Column(
//           children: [
//             /// FLOATING HEADER TRANSLUCENT STYLE
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
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ),
//                   const Expanded(
//                     child: Text(
//                       "ပွိုင့်လွှဲမည်",
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

//             /// BALANCE HERO BANNER DISPLAY
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "သုံးစွဲနိုင်သော လက်ကျန်ပွိုင့်",
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.7),
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 0.8,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "${NumberFormat('#,###').format(widget.currentBalance)} ပွိုင့်",
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: -0.5,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.15),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.account_balance_wallet_rounded,
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),

//             /// BODY CONTAINER WITH SPLIT FOCUS CARDS
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
//                 decoration: const BoxDecoration(
//                   color: Color(0xffF4F6F9),
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       /// RECIPIENT INPUT FIELD
//                       const Text(
//                         "လက်ခံမည့်သူ",
//                         style: TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff64748B),
//                           letterSpacing: 0.5,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       TextField(
//                         controller: _recipientController,
//                         decoration: InputDecoration(
//                           hintText: "အကောင့်အမည် သို့မဟုတ် အိုင်ဒီ",
//                           hintStyle: TextStyle(
//                             color: Colors.grey.shade400,
//                             fontSize: 14,
//                           ),
//                           prefixIcon: const Icon(
//                             Icons.person_outline_rounded,
//                             color: primaryColor,
//                             size: 20,
//                           ),
//                           filled: true,
//                           fillColor: Colors.white,
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 14,
//                             horizontal: 16,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: BorderSide(color: Colors.grey.shade200),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: BorderSide(color: Colors.grey.shade200),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(
//                               color: primaryColor,
//                               width: 1.5,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 24),

//                       /// ALTERNATIVE AMOUNT SECTION: INTERACTIVE ACTION CARD WITH SLIM CHIPS ROW
//                       const Text(
//                         "ပမာဏ",
//                         style: TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff64748B),
//                           letterSpacing: 0.5,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Container(
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(22),
//                           border: Border.all(
//                             color: primaryColor.withOpacity(0.12),
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: primaryColor.withOpacity(0.04),
//                               blurRadius: 12,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   "ပမာဏ ရိုက်ထည့်ပါ",
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color(0xff64748B),
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 8,
//                                     vertical: 4,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: primaryColor.withOpacity(0.1),
//                                     borderRadius: BorderRadius.circular(6),
//                                   ),
//                                   child: const Text(
//                                     "ပွိုင့်",
//                                     style: TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.bold,
//                                       color: primaryColor,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             TextField(
//                               controller: _amountController,
//                               keyboardType: TextInputType.number,
//                               style: const TextStyle(
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xff0F172A),
//                               ),
//                               decoration: InputDecoration(
//                                 hintText: "0",
//                                 hintStyle: TextStyle(
//                                   color: Colors.grey.shade300,
//                                   fontSize: 28,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 prefixIcon: const Padding(
//                                   padding: EdgeInsets.only(right: 8),
//                                   child: Icon(
//                                     Icons.toll_rounded,
//                                     color: primaryColor,
//                                     size: 24,
//                                   ),
//                                 ),
//                                 prefixIconConstraints: const BoxConstraints(
//                                   minWidth: 0,
//                                   minHeight: 0,
//                                 ),
//                                 border: InputBorder.none,
//                                 isDense: true,
//                                 contentPadding: EdgeInsets.zero,
//                               ),
//                             ),
//                             const Padding(
//                               padding: EdgeInsets.symmetric(vertical: 16),
//                               child: Divider(
//                                 height: 1,
//                                 color: Color(0xffF1F5F9),
//                               ),
//                             ),

//                             /// QUICK SELECT CHIPS (GRID PILLS)
//                             Row(
//                               children: _presetAmounts.map((preset) {
//                                 return Expanded(
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: preset == _presetAmounts.first
//                                           ? 0
//                                           : 4,
//                                     ),
//                                     child: InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           _amountController.text = preset
//                                               .toString();
//                                         });
//                                       },
//                                       borderRadius: BorderRadius.circular(10),
//                                       child: Container(
//                                         padding: const EdgeInsets.symmetric(
//                                           vertical: 8,
//                                         ),
//                                         alignment: Alignment.center,
//                                         decoration: BoxDecoration(
//                                           color: const Color(0xffF8FAFC),
//                                           borderRadius: BorderRadius.circular(
//                                             10,
//                                           ),
//                                           border: Border.all(
//                                             color: Colors.grey.shade200,
//                                           ),
//                                         ),
//                                         child: Text(
//                                           "+${preset >= 1000 ? '${preset ~/ 1000}k' : preset}",
//                                           style: const TextStyle(
//                                             fontSize: 11,
//                                             fontWeight: FontWeight.bold,
//                                             color: Color(0xff475569),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 32),

//                       /// ACTION BUTTON
//                       SizedBox(
//                         height: 54,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: primaryColor,
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                           ),
//                           onPressed: _handleTransfer,
//                           child: const Text(
//                             "ပွိုင့်လွှဲမှု အတည်ပြုမည်",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
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
import 'package:intl/intl.dart';

// Recipient Model
class RecipientModel {
  final String name;
  final String phone;

  RecipientModel({required this.name, required this.phone});
}

class TransferScreen extends StatefulWidget {
  final int currentBalance;
  final Function(int amount, String recipient) onTransferCompleted;

  const TransferScreen({
    super.key,
    required this.currentBalance,
    required this.onTransferCompleted,
  });

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  static const Color primaryColor = Color(0xff117992);

  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  final List<int> _presetAmounts = [100, 500, 1000, 5000];

  // Dummy Recent Recipients
  final List<RecipientModel> _recentRecipients = [
    RecipientModel(name: "U SWAN HTET KYAW", phone: "09777123456"),
    RecipientModel(name: "DAW AUNG MYINT", phone: "09791234567"),
    RecipientModel(name: "KO KO THANT", phone: "09789012345"),
    RecipientModel(name: "MA SU SU", phone: "09961122334"),
  ];

  List<RecipientModel> _filteredRecipients = [];
  RecipientModel? _selectedRecipient;

  @override
  void initState() {
    super.initState();
    _recipientController.addListener(_onRecipientSearch);
  }

  @override
  void dispose() {
    _recipientController.removeListener(_onRecipientSearch);
    _recipientController.dispose();
    _amountController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _onRecipientSearch() {
    final query = _recipientController.text.trim();

    if (query.isEmpty || _selectedRecipient != null) {
      setState(() {
        _filteredRecipients = [];
      });
      return;
    }

    final matches = _recentRecipients.where((item) {
      return item.phone.contains(query);
    }).toList();

    setState(() {
      _filteredRecipients = matches;
    });
  }

  String _maskPhoneNumber(String phone) {
    if (phone.length < 8) return phone;
    return "${phone.substring(0, 5)}****${phone.substring(phone.length - 2)}";
  }

  void _handleTransfer() {
    final int? amount = int.tryParse(
      _amountController.text.replaceAll(',', ''),
    );

    final String recipient = _selectedRecipient != null
        ? "${_selectedRecipient!.name} (${_selectedRecipient!.phone})"
        : _recipientController.text.trim();

    if (amount == null || amount <= 0 || recipient.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("အချက်အလက်များကို မှန်ကန်စွာ ဖြည့်သွင်းပါ"),
        ),
      );
      return;
    }

    if (amount > widget.currentBalance) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("လက်ကျန် ပွိုင့် မလုံလောက်ပါ!")),
      );
      return;
    }

    _showPinBottomSheet(amount, recipient);
  }

  void _showPinBottomSheet(int amount, String recipient) {
    _pinController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.fromLTRB(
                24,
                24,
                24,
                MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PIN နံပါတ် ရိုက်ထည့်ပါ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0F172A),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "ဂဏန်း ၆ လုံးပါ လျှို့ဝှက်နံပါတ်ဖြင့် အတည်ပြုပါ",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff64748B),
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
                          color: const Color(0xffF1F5F9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "${NumberFormat('#,###').format(amount)} ပွိုင့်",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _pinController,
                    keyboardType: TextInputType.number,
                    maxLength: 6, // ဂဏန်း ၆ လုံးအထိပဲ လက်ခံမည်
                    autofocus: true,
                    style: const TextStyle(color: Colors.transparent),
                    cursorColor: Colors.transparent,
                    decoration: const InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => setModalState(() {}),
                  ),

                  /// PIN Box ၆ ကွက် ပြင်ဆင်ထားသည့်နေရာ (၃ ကွက် + "-" + ၃ ကွက်)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: List.generate(3, (index) {
                          return _buildPinBoxCell(index);
                        }),
                      ),

                      Row(
                        children: List.generate(3, (index) {
                          return _buildPinBoxCell(index + 3);
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _pinController.text.length == 6
                          ? () {
                              Navigator.pop(context);
                              _executeFinalTransfer(amount, recipient);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        disabledBackgroundColor: const Color(0xffF1F5F9),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        "ပွိုင့်လွှဲမှု အတည်ပြုမည်",
                        style: TextStyle(
                          color: _pinController.text.length == 6
                              ? Colors.white
                              : Colors.grey.shade400,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPinBoxCell(int index) {
    final text = _pinController.text;
    final isFilled = index < text.length;

    return Container(
      width: 36, // ၆ ကွက်ဖြစ်သွားသည့်အတွက် အနည်းငယ် ပိုကျယ်ပေးထားပါသည်
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isFilled
            ? primaryColor.withOpacity(0.04)
            : const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isFilled ? primaryColor : Colors.grey.shade300,
          width: isFilled ? 1.5 : 1,
        ),
      ),
      child: Text(
        isFilled ? "•" : "",
        style: TextStyle(
          fontSize: isFilled ? 22 : 15,
          fontWeight: FontWeight.bold,
          color: isFilled ? primaryColor : Colors.grey.shade400,
        ),
      ),
    );
  }

  void _executeFinalTransfer(int amount, String recipient) {
    widget.onTransferCompleted(amount, recipient);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$recipient ထံသို့ ${NumberFormat('#,###').format(amount)} ပွိုင့် လွှဲပြောင်းပေးပြီးပါပြီ!",
        ),
        backgroundColor: primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D6B80),
      body: SafeArea(
        child: Column(
          children: [
            /// FLOATING HEADER
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
                      "ပွိုင့်လွှဲမည်",
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

            /// BALANCE BANNER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "သုံးစွဲနိုင်သော လက်ကျန်ပွိုင့်",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              NumberFormat(
                                '#,###',
                              ).format(widget.currentBalance),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              "ပွိုင့်",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            /// BODY CONTAINER
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                decoration: const BoxDecoration(
                  color: Color(0xffF4F6F9),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "လက်ခံမည့်သူ",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff64748B),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),

                      if (_selectedRecipient != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: const Color(0xff64B5F6),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "${_selectedRecipient!.name} (${_maskPhoneNumber(_selectedRecipient!.phone)})",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff0F172A),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectedRecipient = null;
                                    _recipientController.clear();
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      else ...[
                        TextField(
                          controller: _recipientController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText:
                                "ပေးပို့လိုသော ဖုန်းနံပါတ်အား ရိုက်ထည့်ပါ",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14,
                            ),
                            prefixIcon: const Icon(
                              Icons.phone_android_rounded,
                              color: primaryColor,
                              size: 20,
                            ),
                            suffixIcon: _recipientController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear, size: 18),
                                    onPressed: () {
                                      _recipientController.clear();
                                    },
                                  )
                                : null,
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.grey.shade200,
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

                        if (_filteredRecipients.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _filteredRecipients.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(height: 1),
                              itemBuilder: (context, index) {
                                final item = _filteredRecipients[index];
                                return ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 4,
                                  ),
                                  leading: const CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Color(0xffE2E8F0),
                                    child: Icon(
                                      Icons.person,
                                      size: 20,
                                      color: primaryColor,
                                    ),
                                  ),
                                  title: Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  subtitle: Text(
                                    item.phone,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _selectedRecipient = item;
                                      _filteredRecipients = [];
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ],

                      const SizedBox(height: 24),

                      /// AMOUNT INPUT SECTION
                      const Text(
                        "ပမာဏ",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff64748B),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: primaryColor.withOpacity(0.12),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.04),
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
                                const Text(
                                  "ပမာဏ ရိုက်ထည့်ပါ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff64748B),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    "ပွိုင့်",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0F172A),
                              ),
                              decoration: InputDecoration(
                                hintText: "0",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade300,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Icon(
                                    Icons.toll_rounded,
                                    color: primaryColor,
                                    size: 24,
                                  ),
                                ),
                                prefixIconConstraints: const BoxConstraints(
                                  minWidth: 0,
                                  minHeight: 0,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Divider(
                                height: 1,
                                color: Color(0xffF1F5F9),
                              ),
                            ),

                            /// QUICK SELECT CHIPS
                            Row(
                              children: _presetAmounts.map((preset) {
                                return Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: preset == _presetAmounts.first
                                          ? 0
                                          : 4,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _amountController.text = preset
                                              .toString();
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffF8FAFC),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey.shade200,
                                          ),
                                        ),
                                        child: Text(
                                          "+${preset >= 1000 ? '${preset ~/ 1000}k' : preset}",
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff475569),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      /// ACTION BUTTON
                      SizedBox(
                        height: 54,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: _handleTransfer,
                          child: const Text(
                            "ပွိုင့်လွှဲမှု အတည်ပြုမည်",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
