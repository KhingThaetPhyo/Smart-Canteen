
import 'package:flutter/material.dart';
import 'package:smartcanteen/view/home/home_header.dart';
import 'package:smartcanteen/view/home/menu_section.dart';
import 'package:smartcanteen/view/home/recent_order.dart';
import 'package:smartcanteen/view/home/shop.dart';
import 'package:smartcanteen/view/shop_detail_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // Mock grouped order history data
  final List<Map<String, dynamic>> recentOrdersData = [
    {
      "shopName": "Tun",
      "orderDate": "Today, 10:15 AM",
      "totalPrice": "4,500 pts",
      "items": [
        const OrderItem(name: "ထမင်း", quantity: 2),
        const OrderItem(name: "ကြက်ဟင်းခါးသီးကြော်", quantity: 2),
      ],
    },
    {
      "shopName": "Tun",
      "orderDate": "Today, 10:15 AM",
      "totalPrice": "4,500 pts",
      "items": [
        const OrderItem(name: "ထမင်း", quantity: 2),
        const OrderItem(name: "ကြက်ဟင်းခါးသီးကြော်", quantity: 2),
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
                userName: "Min Khit",
                major: "Fifth Year",
                studentId: "UCSTT(22-23)-025",
                points: 5700,
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 50)),

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
                  shopName: "Aunty Mon",
                  category: "Daw Mon",
                  estimatedTime: "5 - 10 min",
                  isOpen: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const ShopDetailScreen(shopName: "Aunty Mon"),
                      ),
                    );
                  },
                ),

                ShopCard(
                  shopName: "Tun",
                  category: "U Tun",
                  estimatedTime: "10 - 15 min",
                  isOpen: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ShopDetailScreen(
                          shopName: "Tun",
                        ),
                      ),
                    );
                  },
                ),

                ShopCard(
                  shopName: "A Lin Yaung",
                  category: "Daw Sandar",
                  estimatedTime: "5 - 8 min",
                  isOpen: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const ShopDetailScreen(shopName: "A Lin Yaung"),
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