import 'package:flutter/material.dart';

class WalletInfoScreen extends StatefulWidget {
  const WalletInfoScreen({super.key});

  @override
  State<WalletInfoScreen> createState() => _WalletInfoScreenState();
}

class _WalletInfoScreenState extends State<WalletInfoScreen> {
  TextEditingController text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(controller: text),
          SizedBox(height: 10),
          ElevatedButton(onPressed: () {}, child: Text('Click me')),
        ],
      ),
    );
  }
}
