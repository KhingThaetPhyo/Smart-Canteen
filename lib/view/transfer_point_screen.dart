import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smartcanteen/service/api_service.dart'; // Make sure ApiService is imported

// Recipient Model
class RecipientModel {
  final int? userId;
  final String name;
  final String phone;
  final String? role;

  RecipientModel({this.userId, required this.name, required this.phone, this.role});
}

class TransferPointScreen extends StatefulWidget {
  final int currentBalance;
  final Function(int amount, String recipient) onTransferCompleted;

  const TransferPointScreen({
    super.key,
    required this.currentBalance,
    required this.onTransferCompleted,
  });

  @override
  State<TransferPointScreen> createState() => _TransferPointScreenState();
}

class _TransferPointScreenState extends State<TransferPointScreen> {
  static const Color primaryColor = Color(0xff117992);

  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final ApiService _apiService = ApiService();

  final List<int> _presetAmounts = [500, 1000, 5000, 10000];

  List<RecipientModel> _filteredRecipients = [];
  RecipientModel? _selectedRecipient;
  Timer? _debounce;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _recipientController.addListener(_onRecipientSearch);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _recipientController.removeListener(_onRecipientSearch);
    _recipientController.dispose();
    _amountController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _onRecipientSearch() {
    final query = _recipientController.text.trim();

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.isEmpty || _selectedRecipient != null) {
      setState(() {
        _filteredRecipients = [];
        _isLoading = false;
      });
      return;
    }

    // Debounce to prevent spamming requests while typing
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      setState(() {
        _isLoading = true;
      });

      try {
        final results = await _apiService.searchUsers(query);
        
        if (!mounted) return;

        setState(() {
          _filteredRecipients = results.map((json) {
            return RecipientModel(
              userId: json['user_id'],
              name: json['name'] ?? '',
              phone: json['phone'] ?? '',
              role: json['role'],
            );
          }).toList();
          _isLoading = false;
        });
      } catch (e) {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _filteredRecipients = [];
        });
      }
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

    if (amount == null || recipient.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("အချက်အလက်များကို မှန်ကန်စွာ ဖြည့်သွင်းပါ"),
        ),
      );
      return;
    }

    // Add validation for minimum amount of 500
    if (amount < 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("အနည်းဆုံး ၅၀၀ ပွိုင့်မှစ၍ လွှဲပြောင်းနိုင်ပါသည်။"),
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

  // void _showPinBottomSheet(int amount, String recipient) {
  //   _pinController.clear();

  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setModalState) {
  //           return Container(
  //             padding: EdgeInsets.fromLTRB(
  //               24,
  //               24,
  //               24,
  //               MediaQuery.of(context).viewInsets.bottom + 24,
  //             ),
  //             decoration: const BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
  //             ),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Container(
  //                   width: 36,
  //                   height: 4,
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey.shade300,
  //                     borderRadius: BorderRadius.circular(2),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 22),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     const Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "PIN နံပါတ် ရိုက်ထည့်ပါ",
  //                           style: TextStyle(
  //                             fontSize: 18,
  //                             fontWeight: FontWeight.bold,
  //                             color: Color(0xff0F172A),
  //                           ),
  //                         ),
  //                         SizedBox(height: 2),
  //                         Text(
  //                           "ဂဏန်း ၆ လုံးပါ လျှို့ဝှက်နံပါတ်ဖြင့် အတည်ပြုပါ",
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             color: Color(0xff64748B),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Container(
  //                       padding: const EdgeInsets.symmetric(
  //                         horizontal: 10,
  //                         vertical: 6,
  //                       ),
  //                       decoration: BoxDecoration(
  //                         color: const Color(0xffF1F5F9),
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                       child: Text(
  //                         "${NumberFormat('#,###').format(amount)} ပွိုင့်",
  //                         style: const TextStyle(
  //                           fontSize: 12,
  //                           fontWeight: FontWeight.bold,
  //                           color: primaryColor,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 24),
  //                 TextField(
  //                   controller: _pinController,
  //                   keyboardType: TextInputType.number,
  //                   maxLength: 6,
  //                   autofocus: true,
  //                   style: const TextStyle(color: Colors.transparent),
  //                   cursorColor: Colors.transparent,
  //                   decoration: const InputDecoration(
  //                     counterText: "",
  //                     border: InputBorder.none,
  //                   ),
  //                   onChanged: (value) => setModalState(() {}),
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Row(
  //                       children: List.generate(3, (index) {
  //                         return _buildPinBoxCell(index);
  //                       }),
  //                     ),
  //                     Row(
  //                       children: List.generate(3, (index) {
  //                         return _buildPinBoxCell(index + 3);
  //                       }),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 28),
  //                 SizedBox(
  //                   width: double.infinity,
  //                   height: 50,
  //                   child: ElevatedButton(
  //                     onPressed: _pinController.text.length == 6
  //                         ? () {
  //                             Navigator.of(context).pop();
  //                             _executeFinalTransfer(amount, recipient);
  //                           }
  //                         : null,
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: primaryColor,
  //                       disabledBackgroundColor: const Color(0xffF1F5F9),
  //                       elevation: 0,
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(14),
  //                       ),
  //                     ),
  //                     child: Text(
  //                       "ပွိုင့်လွှဲမှု အတည်ပြုမည်",
  //                       style: TextStyle(
  //                         color: _pinController.text.length == 6
  //                             ? Colors.white
  //                             : Colors.grey.shade400,
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 15,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
void _showPinBottomSheet(int amount, String recipient) {
    _pinController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) { // sheetContext ကို သီးသန့်သုံးပါ
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
                    maxLength: 6,
                    autofocus: true,
                    style: const TextStyle(color: Colors.transparent),
                    cursorColor: Colors.transparent,
                    decoration: const InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => setModalState(() {}),
                  ),
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
                              // Bottom Sheet ကို ပိတ်ရန် sheetContext ကို သုံးပါ
                              Navigator.of(sheetContext).pop(); 
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
      width: 36,
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
// Loading ပြရန် State တစ်ခု ထပ်ထည့်နိုင်ပါသည် (သို့မဟုတ် SnackBar ဖြင့် ပြီးပြတ်မှုကို ပြပါ)
  bool _isTransferring = false;
void _executeFinalTransfer(int amount, String recipient) async {
    String phone = "";
    if (_selectedRecipient != null) {
      phone = _selectedRecipient!.phone;
    } else {
      phone = recipient;
    }

    final pin = _pinController.text.trim();

    setState(() {
      _isTransferring = true;
    });

    try {
      // API call
      final result = await _apiService.transferPoints(
        recipientPhone: phone,
        amount: amount,
        walletPin: pin,
      );

      // Check if widget is still in the tree after the async gap
      if (!mounted) return;

      setState(() {
        _isTransferring = false;
      });

      if (result != null && result['success'] == true) {
        final message = result['message'] ?? "Point များ လွှဲပြောင်းမှု အောင်မြင်ပါသည်။";

        widget.onTransferCompleted(amount, recipient);

        // Check mounted again before showing dialog with context
        if (!mounted) return;
        _showSuccessDialog(message);
      } else {
        final errorMessage = result?['message'] ?? "ပွိုင့်လွှဲပြောင်းမှု မအောင်မြင်ပါ။";
        
        if (!mounted) return;
        _showErrorDialog(errorMessage);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isTransferring = false;
      });

      if (!mounted) return;
      _showErrorDialog(e.toString());
    }
  }
// Success Dialog (matches image_613521.png style)
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.green,
                  size: 64,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Congratulations!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff64748B),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      if (context.canPop()) {
                        context.pop(); // Return from transfer screen
                      }
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Error Dialog (matches image_6131b9.png style)
  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cancel_outlined,
                  color: Colors.deepOrange,
                  size: 64,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Error occured!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff64748B),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                    },
                    child: const Text(
                      "Ok",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/wallet');
                        }
                      },
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
                              NumberFormat('#,###').format(widget.currentBalance),
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
                              const CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(0xff64B5F6),
                                child: Icon(
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
                            hintText: "ပေးပို့လိုသော ဖုန်းနံပါတ် ရိုက်ထည့်ပါ",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14,
                            ),
                            prefixIcon: const Icon(
                              Icons.phone_android_rounded,
                              color: primaryColor,
                              size: 20,
                            ),
                            suffixIcon: _isLoading
                                ? const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: primaryColor,
                                      ),
                                    ),
                                  )
                                : (_recipientController.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear, size: 18),
                                        onPressed: () {
                                          _recipientController.clear();
                                        },
                                      )
                                    : null),
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
                                    "${item.phone}  (${item.role ?? 'user'})",
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
                                          _amountController.text =
                                              preset.toString();
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