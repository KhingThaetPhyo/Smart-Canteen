
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/model/user_model.dart';
import 'package:smartcanteen/service/api_service.dart';
import 'package:smartcanteen/service/shared_preferences_service.dart';

class ChangePhoneScreen extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  const ChangePhoneScreen({super.key, this.initialData});

  @override
  State<ChangePhoneScreen> createState() => _ChangePhoneScreenState();
}

class _ChangePhoneScreenState extends State<ChangePhoneScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  // Theme Colors
  static const primaryTeal = Color(0xFF00838F);
  static const backgroundColor = Color(0xFFF8FAFC);

  @override
  void initState() {
    super.initState();
    final data = widget.initialData;

    _nameController = TextEditingController(
      text: data?['name'] ?? 'Khing Thaet Thaet Phyo',
    );

    // Phone parsing
    String rawPhone = data?['phone'] ?? '+95 9 778123456';
    String digitsOnly = rawPhone.replaceAll(RegExp(r'\D'), '');
    String phoneBody = '';

    if (digitsOnly.startsWith('959')) {
      phoneBody = digitsOnly.substring(3);
    } else if (digitsOnly.startsWith('09')) {
      phoneBody = digitsOnly.substring(2);
    } else if (digitsOnly.startsWith('9')) {
      phoneBody = digitsOnly.substring(1);
    } else {
      phoneBody = digitsOnly;
    }

    _phoneController = TextEditingController(text: phoneBody);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final updatedPhone = '09${_phoneController.text.trim()}';

      try {
        final apiService = ApiService();
        bool isSuccess = await apiService.updatePhone(phone: updatedPhone);

        if (!mounted) return;

        if (isSuccess) {
          UserModel? currentUser = await SharedPreferencesService.getUser();
          if (currentUser != null) {
            UserModel updatedUser = UserModel(
              userId: currentUser.userId,
              userName: currentUser.userName,
              userEmail: currentUser.userEmail,
              userPhone: updatedPhone,
              userPassword: currentUser.userPassword,
              roleName: currentUser.roleName,
              fcmToken: currentUser.fcmToken,
              updatedAt: DateTime.now().toIso8601String(),
              createdAt: currentUser.createdAt,
              student: currentUser.student,
            );
            await SharedPreferencesService.saveUser(updatedUser);
          }

          if (!mounted) return;

          if (context.canPop()) {
            context.pop(true);
          } else {
            Navigator.pop(context, true);
          }
        }
      } catch (e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.redAccent,
          ),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  String _getInitials(String name) {
    List<String> names = name.trim().split(" ");
    if (names.isEmpty || names[0].isEmpty) return "KT";
    if (names.length == 1) return names[0][0].toUpperCase();
    return "${names[0][0]}${names[1][0]}".toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryTeal,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Column(
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Text(
                    _getInitials(_nameController.text),
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: primaryTeal,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _nameController.text.isEmpty
                      ? 'Khing Thaet Thaet Phyo'
                      : _nameController.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // Form Container
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'အချက်အလက်များ ပြင်ဆင်ရန်',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Phone Field
                      _buildInputLabel('ဖုန်းနံပါတ်'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _phoneController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          MyanmarPhoneInputFormatter(),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ဖုန်းနံပါတ် ရိုက်ထည့်ပါ';
                          }
                          String firstChar = value[0];
                          if (['9', '7', '6'].contains(firstChar) &&
                              value.length != 9) {
                            return '09 နောက်တွင် ဂဏန်း ၉ လုံး ရှိရပါမည်';
                          }
                          if (firstChar == '4' && value.length != 8) {
                            return '09 နောက်တွင် ဂဏန်း ၈ လုံး ရှိရပါမည်';
                          }
                          return null;
                        },
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: _buildInputDecoration(
                          hintText: '778123456',
                          prefixIcon: Icons.phone_outlined,
                          prefixText: '09 ',
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryTeal,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: _isLoading ? null : _saveProfile,
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  'သိမ်းဆည်းမည်',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Colors.grey.shade600,
        letterSpacing: 0.8,
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    String? prefixText,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 14.0, right: 10.0),
        child: Icon(prefixIcon, color: primaryTeal, size: 20),
      ),
      prefixText: prefixText,
      prefixStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryTeal, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );
  }
}

class MyanmarPhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    if (text.isEmpty) return newValue;

    if (!['9', '7', '6', '4'].contains(text[0])) {
      return oldValue;
    }

    if (['9', '7', '6'].contains(text[0])) {
      if (text.length > 9) return oldValue;
    }

    if (text[0] == '4') {
      if (text.length > 8) return oldValue;
    }

    return newValue;
  }
}