import 'package:flutter/material.dart';

// ရာဇဝင်အချက်အလက်အတွက် Model Class

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500], // Background color for the page
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Section
              const Text(
                'History',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Your past orders',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // 2. Filter Tabs
              Row(
                children: [
                  _buildTab('All', isSelected: true),
                  _buildTab('Completed'),
                  _buildTab('Cancelled'),
                ],
              ),
              const SizedBox(height: 20),

              // 3. Orders List
              Expanded(
                child: ListView(
                  children: const [
                    OrderCard(
                      title: 'Myanmar Milk Tea',
                      subtitle: 'Tea Lounge • Takeaway • Qty 2',
                      date: '2026-06-16',
                      price: '3,000 Ks',
                      icon: Icons.local_cafe,
                      iconColor: Colors.blue,
                      iconBg: Color(0xFFE0F2FE),
                    ),
                    SizedBox(height: 12),
                    OrderCard(
                      title: 'Mohinga',
                      subtitle: "Moe's Burmese Kitchen • Seat A3 • Qty 1",
                      date: '2026-06-16',
                      price: '2,500 Ks',
                      icon: Icons.dinner_dining,
                      iconColor: Colors.orange,
                      iconBg: Color(0xFFFEF3C7),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTab(String label, {bool isSelected = false}) {
  return Container(
    margin: const EdgeInsets.only(right: 8),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    decoration: BoxDecoration(
      color: isSelected ? Colors.white : Colors.grey[200],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected ? Colors.black : Colors.grey[600],
      ),
    ),
  );
}

// 4. Reusable Order Card Widget
class OrderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String price;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const OrderCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.price,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          // Top Row: Icon, Text details, and Completed Tag
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // Completed Tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'COMPLETED',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Bottom Row: Date and Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
