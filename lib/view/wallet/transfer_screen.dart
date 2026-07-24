import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  bool _isPinModalOpen = false;

  void _handleTransfer() {
    final int? amount = int.tryParse(
      _amountController.text.replaceAll(',', ''),
    );
    final String recipient = _recipientController.text.trim();

    if (amount == null || amount <= 0 || recipient.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid details")),
      );
      return;
    }

    if (amount > widget.currentBalance) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Insufficient points balance!")),
      );
      return;
    }

    _showPinBottomSheet(amount, recipient);
  }

  void _showPinBottomSheet(int amount, String recipient) {
    _pinController.clear();
    setState(() {
      _isPinModalOpen = true;
    });

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
                  // Handle Bar
                  Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Header Layout with Amount Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter PIN",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0F172A),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Confirm with your 8-digit secure code",
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
                          "${NumberFormat('#,###').format(amount)} pts",
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

                  // Hidden TextField for keyboard capture (does not auto-submit on length 8)
                  TextField(
                    controller: _pinController,
                    keyboardType: TextInputType.number,
                    maxLength: 8,
                    autofocus: true,
                    style: const TextStyle(color: Colors.transparent),
                    cursorColor: Colors.transparent,
                    decoration: const InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setModalState(() {});
                    },
                  ),

                  // Segmented Floating Cards Layout (Split into 2 groups of 4 with a hyphen)
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: List.generate(4, (index) {
                            return _buildPinBoxCell(index, setModalState);
                          }),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            "-",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Row(
                          children: List.generate(4, (index) {
                            return _buildPinBoxCell(index + 4, setModalState);
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Action Button (Requires manual press when 8 digits are entered)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _pinController.text.length == 8
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
                        "Confirm Transfer",
                        style: TextStyle(
                          color: _pinController.text.length == 8
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
    ).then((_) {
      setState(() {
        _isPinModalOpen = false;
      });
    });
  }

  // Helper widget for individual split cell boxes
  Widget _buildPinBoxCell(int index, StateSetter setModalState) {
    final text = _pinController.text;
    final isFilled = index < text.length;

    return Container(
      width: 32,
      height: 44,
      margin: const EdgeInsets.symmetric(horizontal: 2),
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
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Sent ${NumberFormat('#,###').format(amount)} pts to $recipient!",
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
            /// FLOATING HEADER TRANSLUCENT STYLE
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
                      "Transfer Points",
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

            /// BALANCE HERO BANNER DISPLAY
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
                        "Available Balance",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${NumberFormat('#,###').format(widget.currentBalance)} pts",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
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

            /// BODY CONTAINER WITH SPLIT FOCUS CARDS
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
                      /// RECIPIENT INPUT FIELD
                      const Text(
                        "RECIPIENT",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff64748B),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _recipientController,
                        decoration: InputDecoration(
                          hintText: "Username or ID",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.person_outline_rounded,
                            color: primaryColor,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade200),
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
                      const SizedBox(height: 24),

                      /// ALTERNATIVE AMOUNT SECTION: INTERACTIVE ACTION CARD WITH SLIM CHIPS ROW
                      const Text(
                        "AMOUNT",
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
                                  "Enter Value",
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
                                    "PTS",
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

                            /// QUICK SELECT CHIPS (GRID PILLS)
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
                            "Confirm Transfer",
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
