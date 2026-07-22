import 'package:flutter/material.dart';

import 'widgets/home_header.dart';
import 'widgets/menu_section.dart';
import 'widgets/shop_card.dart';
import 'widgets/recent_order_card.dart';

import 'shop_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock grouped order history data
  final List<Map<String, dynamic>> recentOrdersData = [
    {
      "shopName": "Coffee Corner",
      "orderDate": "Today, 10:15 AM",
      "totalPrice": "4,500 pts",
      "items": [
        const OrderItem(name: "Milk Tea", quantity: 2),
        const OrderItem(name: "Iced Americano", quantity: 1),
      ],
    },
    {
      "shopName": "Aunt May Noodles",
      "orderDate": "Yesterday",
      "totalPrice": "5,000 pts",
      "items": [
        const OrderItem(name: "Shan Noodle", quantity: 1),
        const OrderItem(name: "Fried Tofu", quantity: 1),
        const OrderItem(name: "Green Tea", quantity: 1),
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Restrict list to only the 5 most recent items
    final limitedOrders = recentOrdersData.take(5).toList();

    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),

      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),

          slivers: [
            /// HEADER
            SliverToBoxAdapter(
              child: HomeHeader(
                userName: "Wa Thon",
                major: "Fifth Year",
                studentId: "UCSTT(22-23)-000",
                points: 5700,
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 60)),

            /// POPULAR MENU
            const SliverToBoxAdapter(child: MenuSection()),

            /// POPULAR SHOPS TITLE
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Text(
                  "Shops",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            /// SHOPS
            SliverList(
              delegate: SliverChildListDelegate([
                ShopCard(
                  shopName: "Coffee Corner",
                  category: "Coffee & Drinks",
                  rating: 4.8,
                  estimatedTime: "5 - 10 min",
                  isOpen: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const ShopDetailScreen(shopName: "Coffee Corner"),
                      ),
                    );
                  },
                ),

                ShopCard(
                  shopName: "Aunt May Noodles",
                  category: "Noodles",
                  rating: 4.9,
                  estimatedTime: "10 - 15 min",
                  isOpen: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ShopDetailScreen(
                          shopName: "Aunt May Noodles",
                        ),
                      ),
                    );
                  },
                ),

                ShopCard(
                  shopName: "Snack House",
                  category: "Snacks",
                  rating: 4.7,
                  estimatedTime: "5 - 8 min",
                  isOpen: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const ShopDetailScreen(shopName: "Snack House"),
                      ),
                    );
                  },
                ),
              ]),
            ),

            /// RECENT ORDERS TITLE + SEE ALL
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent Orders",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1E293B),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Navigate to full OrdersScreen / Orders tab
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        "See All",
                        style: TextStyle(
                          color: Color(0xff117992),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// RECENT ORDERS (MAX 5 ORDER BLOCKS)
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final order = limitedOrders[index];
                return RecentOrderCard(
                  shopName: order["shopName"],
                  orderDate: order["orderDate"],
                  totalPrice: order["totalPrice"],
                  items: order["items"],
                  onReorder: () {
                    // Reorder all items logic
                  },
                );
              }, childCount: limitedOrders.length),
            ),

            /// BOTTOM SPACE
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
      ),
    );
  }
}
