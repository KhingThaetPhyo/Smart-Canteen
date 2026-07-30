// import 'package:flutter/material.dart';

// class UserProvider extends ChangeNotifier {
//   int _balancePoints = 10000; // Your initial or fetched balance

//   int get balancePoints => _balancePoints;

//   // Set user points initially (e.g. from API)
//   void setBalance(int newBalance) {
//     _balancePoints = newBalance;
//     notifyListeners();
//   }

//   // Deduct points after a purchase
//   void deductPoints(int pointsToDeduct) {
//     if (_balancePoints >= pointsToDeduct) {
//       _balancePoints -= pointsToDeduct;
//       notifyListeners(); // Updates all screens listening to this Provider
//     }
//   }
// }

// import 'package:flutter/material.dart';

// class UserProvider extends ChangeNotifier {
//   int _balancePoints = 0; // Default until loaded from DB

//   int get balancePoints => _balancePoints;

//   /// Sets the user balance retrieved from the database on Login/Register
//   void setBalance(int newBalance) {
//     _balancePoints = newBalance;
    
//     // Print the user balance retrieved from the database
//     debugPrint("------------------------------------------");
//     debugPrint("DATABASE SYNC: User Balance = $_balancePoints");
//     debugPrint("------------------------------------------");

//     notifyListeners();
//   }

//   /// Deducts points after a purchase
//   void deductPoints(int pointsToDeduct) {
//     if (_balancePoints >= pointsToDeduct) {
//       _balancePoints -= pointsToDeduct;
//       notifyListeners();
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:smartcanteen/service/shared_preferences_service.dart';

class UserProvider extends ChangeNotifier {
  int _balancePoints = 0;

  int get balancePoints => _balancePoints;

  void setBalance(int newBalance) {
    _balancePoints = newBalance;
    notifyListeners();
  }

  /// Deducts points locally and notifies listeners without rebuilding WalletModel
  void deductPoints(int pointsToDeduct) {
    if (_balancePoints >= pointsToDeduct) {
      _balancePoints -= pointsToDeduct;
      notifyListeners();
    }
  }

  /// Optional: Refetch latest user/wallet data from API or Storage
  Future<void> refreshFromStorage() async {
    final wallet = await SharedPreferencesService.getUserWallet();
    if (wallet != null) {
      _balancePoints = wallet.balance;
      notifyListeners();
    }
  }
}