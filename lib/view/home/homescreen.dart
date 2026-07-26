
// import 'package:flutter/material.dart';
// import 'package:smartcanteen/view/home/home_header.dart';
// import 'package:smartcanteen/view/home/menu_section.dart';
// import 'package:smartcanteen/view/home/recent_order.dart';
// import 'package:smartcanteen/view/home/shop.dart';
// import 'package:smartcanteen/view/shop_detail_screen.dart';
// class Homescreen extends StatefulWidget {
//   const Homescreen({super.key});

//   @override
//   State<Homescreen> createState() => _HomescreenState();
// }

// class _HomescreenState extends State<Homescreen> {
//   final List<Map<String, dynamic>> recentOrdersData = [
//     {
//       "shopName": "Tun",
//       "orderDate": "Today, 10:15 AM",
//       "totalPrice": "4,500 pts",
//       "items": [
//         const OrderItem(name: "ထမင်း", quantity: 2),
//         const OrderItem(name: "ကြက်ဟင်းခါးသီးကြော်", quantity: 2),
//       ],
//     },
//     {
//       "shopName": "Tun",
//       "orderDate": "Today, 10:15 AM",
//       "totalPrice": "4,500 pts",
//       "items": [
//         const OrderItem(name: "ထမင်း", quantity: 2),
//         const OrderItem(name: "ကြက်ဟင်းခါးသီးကြော်", quantity: 2),
//       ],
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final limitedOrders = recentOrdersData.take(5).toList();

//     return Scaffold(
//       backgroundColor: const Color(0xffF6F8FC),
//       body: SafeArea(
//         child: CustomScrollView(
//           physics: const BouncingScrollPhysics(),
//           slivers: [
//             /// 1. STICKY HEADER (PINNED AT TOP)
//             SliverPersistentHeader(
//               pinned: true, // 👈 Keeps the header fixed at the top when scrolling
//               delegate: _StickyHeaderDelegate(
//                 height: 330, // 👈 Match HomeHeader's preferredSize height
//                 child: const HomeHeader(),
//               ),
//             ),

//             /// 2. SPACING UNDER FLOATING CARD
//             const SliverToBoxAdapter(child: SizedBox(height: 35)),

//             /// POPULAR MENU
//             const SliverToBoxAdapter(child: MenuSection()),

//             /// POPULAR SHOPS TITLE
//             const SliverToBoxAdapter(
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
//                 child: Text(
//                   "ဆိုင်များ",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),

//             /// SHOPS LIST
//             SliverList(
//               delegate: SliverChildListDelegate([
//                 ShopCard(
//                   shopName: "Aunty Mon",
//                   category: "Daw Mon",
//                   estimatedTime: "5 - 10 min",
//                   isOpen: true,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) =>
//                             const ShopDetailScreen(shopName: "Aunty Mon"),
//                       ),
//                     );
//                   },
//                 ),
//                 ShopCard(
//                   shopName: "Tun",
//                   category: "U Tun",
//                   estimatedTime: "10 - 15 min",
//                   isOpen: true,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const ShopDetailScreen(
//                           shopName: "Tun",
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 ShopCard(
//                   shopName: "A Lin Yaung",
//                   category: "Daw Sandar",
//                   estimatedTime: "5 - 8 min",
//                   isOpen: false,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) =>
//                             const ShopDetailScreen(shopName: "A Lin Yaung"),
//                       ),
//                     );
//                   },
//                 ),
//               ]),
//             ),

//             /// RECENT ORDERS TITLE + SEE ALL
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "အမှာစာများ",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xff1E293B),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {},
//                       style: TextButton.styleFrom(
//                         padding: EdgeInsets.zero,
//                         minimumSize: const Size(50, 30),
//                         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                       ),
//                       child: const Text(
//                         "အားလုံးကြည့်ရန်",
//                         style: TextStyle(
//                           color: Color(0xff117992),
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             /// RECENT ORDERS LIST
//             SliverList(
//               delegate: SliverChildBuilderDelegate((context, index) {
//                 final order = limitedOrders[index];
//                 return RecentOrderCard(
//                   shopName: order["shopName"],
//                   orderDate: order["orderDate"],
//                   totalPrice: order["totalPrice"],
//                   items: order["items"],
//                 );
//               }, childCount: limitedOrders.length),
//             ),

//             /// BOTTOM SPACE
//             const SliverToBoxAdapter(child: SizedBox(height: 120)),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
//   final double height;

//   _StickyHeaderDelegate({
//     required this.child,
//     required this.height,
//   });

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return SizedBox.expand(child: child);
//   }

//   @override
//   double get maxExtent => height;

//   @override
//   double get minExtent => height;

//   @override
//   bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
//     return oldDelegate.height != height || oldDelegate.child != child;
//   }
// }

import 'package:flutter/material.dart';
import 'package:smartcanteen/model/shop_model.dart';
import 'package:smartcanteen/service/api_service.dart';
import 'package:smartcanteen/view/home/home_header.dart';
import 'package:smartcanteen/view/home/menu_section.dart';
import 'package:smartcanteen/view/home/recent_order.dart';
import 'package:smartcanteen/view/home/shop.dart'; // Ensure this exports ShopCard
import 'package:smartcanteen/view/shop_detail_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final ApiService _apiService = ApiService();
  late Future<List<ShopModel>> _futureShops;

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
  void initState() {
    super.initState();
    _futureShops = _apiService.getShops();
  }

  @override
  Widget build(BuildContext context) {
    final limitedOrders = recentOrdersData.take(5).toList();

    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            /// 1. STICKY HEADER (PINNED AT TOP)
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(
                height: 330,
                child: const HomeHeader(),
              ),
            ),

            /// 2. SPACING UNDER FLOATING CARD
            const SliverToBoxAdapter(child: SizedBox(height: 35)),

            /// POPULAR MENU
            const SliverToBoxAdapter(child: MenuSection()),

            /// POPULAR SHOPS TITLE
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Text(
                  "ဆိုင်များ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            /// DYNAMIC SHOPS LIST FROM API
            FutureBuilder<List<ShopModel>>(
              future: _futureShops,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff117992),
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Text(
                        "ဆိုင်များ ရယူ၍ မရပါ: ${snapshot.error}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Text("ဖွင့်ထားသော ဆိုင်များ မရှိသေးပါ။"),
                    ),
                  );
                }

                final shops = snapshot.data!;

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final shop = shops[index];
                      return ShopCard(
                        shopName: shop.shopName,
                        category: shop.shopPhone,
                        isOpen: shop.isOpen == 1,
                        estimatedTime: "10-15 min",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ShopDetailScreen(
                                shopName: shop.shopName,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    childCount: shops.length,
                  ),
                );
              },
            ),

            /// RECENT ORDERS TITLE + SEE ALL
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "မကြာသေးခင်က",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1E293B),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        "အားလုံးကြည့်ရန်",
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

            /// RECENT ORDERS LIST
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final order = limitedOrders[index];
                  return RecentOrderCard(
                    shopName: order["shopName"],
                    orderDate: order["orderDate"],
                    totalPrice: order["totalPrice"],
                    items: order["items"],
                  );
                },
                childCount: limitedOrders.length,
              ),
            ),

            /// BOTTOM SPACE
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _StickyHeaderDelegate({
    required this.child,
    required this.height,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
  }
}