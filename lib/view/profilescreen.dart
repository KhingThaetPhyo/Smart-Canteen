import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  static const primaryColor = Color(0xff0E7490); // Refreshed modern teal
  static const accentColor = Color(0xffF8FAFC);

  bool _notificationsOn = true;
  final String _name = 'Wa Thon';
  String _email = 'wathon.dev@email.mm';
  String _phone = '+95 9 778 123 456';

  InputDecoration _decoration(String label, IconData icon, {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xff64748B), fontSize: 14),
      prefixIcon: Icon(icon, color: primaryColor, size: 22),
      suffixIcon: suffix,
      filled: true,
      fillColor: accentColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xffE2E8F0), width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryColor, width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.8),
      ),
    );
  }

  void _showEditProfile() {
    final key = GlobalKey<FormState>();
    final email = TextEditingController(text: _email);
    final phone = TextEditingController(text: _phone);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Form(
                  key: key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'ပရိုဖိုင် ဆက်တင်',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff94A3B8),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            icon: const Icon(Icons.close_rounded, size: 20),
                            style: IconButton.styleFrom(
                              backgroundColor: const Color(0xffF1F5F9),
                              foregroundColor: const Color(0xff64748B),
                              padding: const EdgeInsets.all(8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const _SheetTitle(
                        icon: Icons.badge_rounded,
                        title: 'ပရိုဖိုင်အချက်အလက် ပြင်ဆင်ရန်',
                        subtitle: 'ဆက်သွယ်ရန်အချက်အလက်များကို ပြင်ဆင်ပါ။',
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: _decoration(
                          'အီးမေးလ်လိပ်စာ',
                          Icons.alternate_email_rounded,
                        ),
                        validator: (value) {
                          final text = value?.trim() ?? '';
                          if (text.isEmpty) return 'အီးမေးလ်လိပ်စာ ထည့်ပါ';
                          if (!RegExp(
                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                          ).hasMatch(text)) {
                            return 'မှန်ကန်သော အီးမေးလ်လိပ်စာ ထည့်ပါ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        decoration: _decoration(
                          'ဖုန်းနံပါတ်',
                          Icons.phone_iphone_rounded,
                        ),
                        validator: (value) {
                          final text = value?.trim() ?? '';
                          if (text.isEmpty) return 'ဖုန်းနံပါတ် ထည့်ပါ';
                          if (!RegExp(r'^[0-9+()\-\s]{7,20}$').hasMatch(text)) {
                            return 'မှန်ကန်သော ဖုန်းနံပါတ် ထည့်ပါ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 28),
                      _primaryButton('သိမ်းမည်', () {
                        if (!key.currentState!.validate()) return;
                        setState(() {
                          _email = email.text.trim();
                          _phone = phone.text.trim();
                        });
                        Navigator.pop(dialogContext);
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _success(
                            'ပရိုဖိုင်ကို အောင်မြင်စွာ ပြင်ဆင်ပြီးပါပြီ',
                          );
                        });
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showChangePassword() {
    final key = GlobalKey<FormState>();
    final current = TextEditingController();
    final next = TextEditingController();
    final confirm = TextEditingController();
    bool hideCurrent = true;
    bool hideNext = true;
    bool hideConfirm = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Form(
                  key: key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'လုံခြုံရေး ဆက်တင်',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff94A3B8),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            icon: const Icon(Icons.close_rounded, size: 20),
                            style: IconButton.styleFrom(
                              backgroundColor: const Color(0xffF1F5F9),
                              foregroundColor: const Color(0xff64748B),
                              padding: const EdgeInsets.all(8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xff0891B2), primaryColor],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.white24,
                              child: Icon(
                                Icons.lock_reset_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'စကားဝှက် ပြောင်းရန်',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'အနည်းဆုံး စကားဝှက် ၈ လုံး ရှိရပါမည်။',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      _passwordField(
                        controller: current,
                        label: 'လက်ရှိ စကားဝှက်',
                        hidden: hideCurrent,
                        toggle: () =>
                            setDialogState(() => hideCurrent = !hideCurrent),
                        validator: (value) => (value ?? '').isEmpty
                            ? 'လက်ရှိ စကားဝှက်ကို ထည့်ပါ'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      _passwordField(
                        controller: next,
                        label: 'စကားဝှက်အသစ်',
                        hidden: hideNext,
                        toggle: () =>
                            setDialogState(() => hideNext = !hideNext),
                        validator: (value) {
                          if ((value ?? '').length < 8) {
                            return 'အနည်းဆုံး စကားဝှက် ၈ လုံး အသုံးပြုပါ';
                          }
                          if (value == current.text) {
                            return 'စကားဝှက်အသစ်သည် လက်ရှိစကားဝှက်နှင့် မတူရပါ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _passwordField(
                        controller: confirm,
                        label: 'စကားဝှက်အသစ် အတည်ပြုရန်',
                        hidden: hideConfirm,
                        toggle: () =>
                            setDialogState(() => hideConfirm = !hideConfirm),
                        validator: (value) =>
                            value != next.text ? 'စကားဝှက်များ မတူညီပါ' : null,
                      ),
                      const SizedBox(height: 24),
                      _primaryButton('စကားဝှက် ပြောင်းမည်', () {
                        if (!key.currentState!.validate()) return;
                        Navigator.pop(dialogContext);
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _success('စကားဝှက်ကို အောင်မြင်စွာ ပြောင်းပြီးပါပြီ');
                        });
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String label,
    required bool hidden,
    required VoidCallback toggle,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: hidden,
      decoration: _decoration(
        label,
        Icons.lock_outline_rounded,
        suffix: IconButton(
          onPressed: toggle,
          icon: Icon(
            hidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: const Color(0xff64748B),
          ),
        ),
      ),
      validator: validator,
    );
  }

  void _showChangePin() {
    int currentStep = 0; // 0: Current PIN, 1: New PIN, 2: Confirm PIN

    final current = List.generate(6, (_) => TextEditingController());
    final next = List.generate(6, (_) => TextEditingController());
    final confirm = List.generate(6, (_) => TextEditingController());

    final currentFocus = List.generate(6, (_) => FocusNode());
    final nextFocus = List.generate(6, (_) => FocusNode());
    final confirmFocus = List.generate(6, (_) => FocusNode());

    String valueOf(List<TextEditingController> items) =>
        items.map((item) => item.text).join();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 440),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'လုံခြုံရေး ဆက်တင်',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff94A3B8),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          icon: const Icon(Icons.close_rounded, size: 20),
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xffF1F5F9),
                            foregroundColor: const Color(0xff64748B),
                            padding: const EdgeInsets.all(8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xff0891B2), primaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white24,
                            child: Icon(
                              Icons.security_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PIN ပြောင်းရန်',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'PIN အသစ်ဖြင့် သင့်အကောင့်ကို ကာကွယ်ပါ။',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xffF1F5F9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildSegmentTab(
                              title: 'လက်ရှိ',
                              isActive: currentStep == 0,
                              isCompleted: currentStep > 0,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: _buildSegmentTab(
                              title: 'PIN အသစ်',
                              isActive: currentStep == 1,
                              isCompleted: currentStep > 1,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: _buildSegmentTab(
                              title: 'အတည်ပြု',
                              isActive: currentStep == 2,
                              isCompleted: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    if (currentStep == 0) ...[
                      _pinRow(
                        title: 'လက်ရှိ PIN ကို ထည့်ပါ',
                        controllers: current,
                        focusNodes: currentFocus,
                      ),
                      const SizedBox(height: 28),
                      _primaryButton('ဆက်လုပ်မည်', () {
                        if (valueOf(current).length < 6) {
                          _success('PIN ဂဏန်း ၆ လုံး အပြည့်အစုံ ထည့်ပါ');
                          return;
                        }
                        setDialogState(() {
                          currentStep = 1;
                          Future.delayed(const Duration(milliseconds: 100), () {
                            if (nextFocus.isNotEmpty)
                              nextFocus[0].requestFocus();
                          });
                        });
                      }),
                    ] else if (currentStep == 1) ...[
                      _pinRow(
                        title: 'PIN အသစ်ကို ထည့်ပါ',
                        controllers: next,
                        focusNodes: nextFocus,
                      ),
                      const SizedBox(height: 28),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 52,
                              child: OutlinedButton(
                                onPressed: () =>
                                    setDialogState(() => currentStep = 0),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: primaryColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  'နောက်သို့',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _primaryButton('ဆက်လုပ်မည်', () {
                              if (valueOf(next).length < 6) {
                                _success('PIN ဂဏန်း ၆ လုံး အပြည့်အစုံ ထည့်ပါ');
                                return;
                              }
                              if (valueOf(next) == valueOf(current)) {
                                _success('PIN အသစ်သည် လက်ရှိ PIN နှင့် မတူရပါ');
                                return;
                              }
                              setDialogState(() {
                                currentStep = 2;
                                Future.delayed(
                                  const Duration(milliseconds: 100),
                                  () {
                                    if (confirmFocus.isNotEmpty)
                                      confirmFocus[0].requestFocus();
                                  },
                                );
                              });
                            }),
                          ),
                        ],
                      ),
                    ] else ...[
                      _pinRow(
                        title: 'PIN အသစ်ကို အတည်ပြုပါ',
                        controllers: confirm,
                        focusNodes: confirmFocus,
                      ),
                      const SizedBox(height: 28),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 52,
                              child: OutlinedButton(
                                onPressed: () =>
                                    setDialogState(() => currentStep = 1),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: primaryColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  'နောက်သို့',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _primaryButton('PIN သိမ်းမည်', () {
                              if (valueOf(confirm) != valueOf(next)) {
                                _success('PIN များ မတူညီပါ');
                                return;
                              }
                              Navigator.pop(dialogContext);
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _success(
                                  'PIN ကို အောင်မြင်စွာ ပြောင်းပြီးပါပြီ',
                                );
                              });
                            }),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentTab({
    required String title,
    required bool isActive,
    required bool isCompleted,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isCompleted) ...[
              const Icon(Icons.check_rounded, size: 14, color: primaryColor),
              const SizedBox(width: 4),
            ],
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive
                    ? Colors.white
                    : isCompleted
                    ? primaryColor
                    : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pinRow({
    required String title,
    required List<TextEditingController> controllers,
    required List<FocusNode> focusNodes,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xff334155),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (index) {
            return SizedBox(
              width: 44,
              height: 52,
              child: TextField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                obscureText: true,
                obscuringCharacter: '•',
                maxLength: 1,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: accentColor,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xffCBD5E1),
                      width: 1.2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: primaryColor,
                      width: 1.8,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty && index < 5) {
                    focusNodes[index + 1].requestFocus();
                  } else if (value.isEmpty && index > 0) {
                    focusNodes[index - 1].requestFocus();
                  }
                },
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _primaryButton(String text, VoidCallback onPressed) => SizedBox(
    width: double.infinity,
    height: 52,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 28),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 380),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xffFEE2E2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: Color(0xffEF4444),
                  size: 30,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'အကောင့်မှ ထွက်မည်',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff1E293B),
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'အကောင့်မှ ထွက်ရန် သေချာပါသလား။',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff64748B),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xffCBD5E1)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'မထွက်တော့ပါ',
                          style: TextStyle(
                            color: Color(0xff475569),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          // TODO: Clear the stored token, then navigate to login.
                          // Example:
                          // await storage.delete(key: 'token');
                          // if (!mounted) return;
                          // Navigator.pushNamedAndRemoveUntil(
                          //   context,
                          //   '/login',
                          //   (route) => false,
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffEF4444),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'ထွက်မည်',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _success(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(child: Text(message)),
            ],
          ),
          backgroundColor: primaryColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              const Text(
                'ပရိုဖိုင်',
                style: TextStyle(
                  color: Color(0xff1E293B),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _profileCard(),
              const SizedBox(height: 24),
              _sectionTitle('အကောင့် ဆက်တင်များ'),
              const SizedBox(height: 10),
              _sectionCard([
                _listTile(
                  Icons.person_outline_rounded,
                  'ပရိုဖိုင် ပြင်ဆင်ရန်',
                  subtitle: 'အီးမေးလ်နှင့် ဖုန်းနံပါတ် ပြင်ဆင်ရန်',
                  onTap: _showEditProfile,
                ),
                _divider(),
                _listTile(
                  Icons.lock_outline_rounded,
                  'စကားဝှက် ပြောင်းရန်',
                  subtitle: 'အကောင့် စကားဝှက် ပြောင်းရန်',
                  onTap: _showChangePassword,
                ),
                _divider(),
                _listTile(
                  Icons.dialpad_rounded,
                  'PIN ပြောင်းရန်',
                  subtitle: 'ဂဏန်း ၆ လုံး လုံခြုံရေး PIN ပြောင်းရန်',
                  onTap: _showChangePin,
                ),
              ]),
              const SizedBox(height: 24),
              _sectionTitle('အက်ပ် ဆက်တင်များ'),
              const SizedBox(height: 10),
              _sectionCard([
                _switchTile(
                  Icons.notifications_none_rounded,
                  'အသိပေးချက်များ',
                  _notificationsOn,
                  (value) => setState(() => _notificationsOn = value),
                ),
              ]),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _showLogoutConfirmation,
                  icon: const Icon(Icons.logout_rounded, color: Colors.white),
                  label: const Text(
                    'အကောင့်မှ ထွက်မည်',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffEF4444),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileCard() => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xff0891B2), primaryColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: primaryColor.withOpacity(0.25),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(.2),
            border: Border.all(color: Colors.white.withOpacity(.4), width: 2),
          ),
          child: const CircleAvatar(
            radius: 36,
            backgroundColor: Colors.white,
            child: Icon(Icons.person_rounded, size: 40, color: primaryColor),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _email,
                style: TextStyle(
                  color: Colors.white.withOpacity(.85),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _phone,
                style: TextStyle(
                  color: Colors.white.withOpacity(.85),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _sectionTitle(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: primaryColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: .8,
        ),
      ),
    ),
  );

  Widget _sectionCard(List<Widget> children) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.black.withOpacity(.04), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.02),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(children: children),
  );

  Widget _iconBox(IconData icon) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color(0xffE0F2FE),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Icon(icon, color: primaryColor, size: 20),
  );

  Widget _listTile(
    IconData icon,
    String title, {
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: _iconBox(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xff1E293B),
        ),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, color: Color(0xff94A3B8)),
            ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 14,
        color: Colors.grey.shade400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      onTap: onTap,
    );
  }

  Widget _switchTile(
    IconData icon,
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      leading: _iconBox(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xff1E293B),
        ),
      ),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
        activeTrackColor: primaryColor,
        inactiveTrackColor: Colors.grey.shade200,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }

  Widget _divider() => Divider(
    height: 1,
    thickness: 1,
    color: Colors.grey.shade100,
    indent: 16,
    endIndent: 16,
  );
}

class _SheetTitle extends StatelessWidget {
  const _SheetTitle({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: const Color(0xffE0F2FE),
          child: Icon(icon, color: ProfileScreenState.primaryColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1E293B),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Color(0xff64748B)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
