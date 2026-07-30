import 'package:smartcanteen/service/api_service.dart';

class ForgotPinService {
  final ApiService _apiService = ApiService();

  // 1. Send OTP Request (Error Message ပါ ပြန်ပေးနိုင်ရန် ပြင်ဆင်ထားသည်)
  Future<Map<String, dynamic>> sendOtp(String email) async {
    try {
      bool isSuccess = await _apiService.forgotPin(email);
      return {
        'success': isSuccess,
        'message': isSuccess ? 'OTP ပို့ပြီးပါပြီ။' : 'Failed to send OTP.',
      };
    } catch (e) {
      print("Send OTP Error: $e");
      return {
        'success': false,
        'message': e
            .toString(), // Backend မှ ပြန်လာသော Exception message အစစ်အမှန်
      };
    }
  }

  // 2. Reset PIN Request
  Future<Map<String, dynamic>> resetPin({
    required String email,
    required String otp,
    required String newPin,
  }) async {
    try {
      return await _apiService.resetPin(email: email, otp: otp, newPin: newPin);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
