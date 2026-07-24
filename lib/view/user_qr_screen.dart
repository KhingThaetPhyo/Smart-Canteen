import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UserQrScreen extends StatelessWidget {
  final String qrData;

  const UserQrScreen({
    super.key,
    required this.qrData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('My QR Code'),
      //   centerTitle: true,
      // ),
      appBar: AppBar(
        backgroundColor: Colors
            .transparent, // background နဲ့ တစ်သားတည်းဖြစ်အောင် transparent လုပ်ထားပါတယ်
        elevation: 0,
          title: const Text('My QR Code'),
        centerTitle: true, // အောက်ခြေလိုင်း ပျောက်အောင်ပါ
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            context.go('/navigation'); // Home Screen ကို ပြန်သွားမယ့် လမ်းကြောင်း
          },
        ),
      ),
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'SmartCanteen QR',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // QR Code
                QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 220.0,
                  backgroundColor: Colors.white,
                ),

                // const SizedBox(height: 20),

                // Text(
                //   qrData,
                //   textAlign: TextAlign.center,
                //   style: const TextStyle(fontSize: 14),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}