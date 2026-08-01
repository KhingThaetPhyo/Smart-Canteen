
// import 'package:flutter/material.dart';
// import 'package:smartcanteen/model/shop_model.dart';
// import 'package:smartcanteen/service/api_service.dart';
// import 'package:smartcanteen/view/home/home_header.dart';
// import 'package:smartcanteen/view/home/menu_section.dart';
// import 'package:smartcanteen/view/home/recent_order.dart';
// import 'package:smartcanteen/view/home/shop.dart'; // Ensure this exports ShopCard
// import 'package:smartcanteen/view/shop_detail_screen.dart';

// class Homescreen extends StatefulWidget {
//   const Homescreen({super.key});

//   @override
//   State<Homescreen> createState() => _HomescreenState();
// }

// class _HomescreenState extends State<Homescreen> {
//   final ApiService _apiService = ApiService();
//   late Future<List<ShopModel>> _futureShops;

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
//   void initState() {
//     super.initState();
//     _futureShops = _apiService.getShops();
//   }

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
//               pinned: true,
//               delegate: _StickyHeaderDelegate(
//                 height: 330,
//                 child: const HomeHeader(),
//               ),
//             ),

//             /// 2. SPACING UNDER FLOATING CARD
//             const SliverToBoxAdapter(child: SizedBox(height: 35)),

//             /// POPULAR MENU
//             SliverToBoxAdapter(child: MenuSection()),

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

//             /// DYNAMIC SHOPS LIST FROM API
//             FutureBuilder<List<ShopModel>>(
//               future: _futureShops,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const SliverToBoxAdapter(
//                     child: Padding(
//                       padding: EdgeInsets.all(32.0),
//                       child: Center(
//                         child: CircularProgressIndicator(
//                           color: Color(0xff117992),
//                         ),
//                       ),
//                     ),
//                   );
//                 } else if (snapshot.hasError) {
//                   return SliverToBoxAdapter(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                       child: Text(
//                         "ဆိုင်များ ရယူ၍ မရပါ: ${snapshot.error}",
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                     ),
//                   );
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return const SliverToBoxAdapter(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                       child: Text("ဖွင့်ထားသော ဆိုင်များ မရှိသေးပါ။"),
//                     ),
//                   );
//                 }

//                 final shops = snapshot.data!;

//                 return SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                       final shop = shops[index];
//                       return ShopCard(
//                         shopName: shop.shopName,
//                         category: shop.shopPhone,
//                         isOpen: shop.isOpen == 1,
//                         estimatedTime: "10-15 min",
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => ShopDetailScreen(
//                                 shopName: shop.shopName,
//                                 shopId: shop.shopId,
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     childCount: shops.length,
//                   ),
//                 );
//               },
//             ),

//             /// RECENT ORDERS TITLE + SEE ALL
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "မကြာသေးခင်က",
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
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final order = limitedOrders[index];
//                   return RecentOrderCard(
//                     shopName: order["shopName"],
//                     orderDate: order["orderDate"],
//                     totalPrice: order["totalPrice"],
//                     items: order["items"],
//                   );
//                 },
//                 childCount: limitedOrders.length,
//               ),
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
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/model/order_model.dart';
import 'package:smartcanteen/model/shop_model.dart';
import 'package:smartcanteen/service/api_service.dart';
import 'package:smartcanteen/service/secure_storage_service.dart';
import 'package:smartcanteen/view/home/home_header.dart';
import 'package:smartcanteen/view/home/menu_section.dart';
import 'package:smartcanteen/view/home/recent_order.dart';
import 'package:smartcanteen/view/home/shop.dart';
import 'package:smartcanteen/view/order_screen.dart';
import 'package:smartcanteen/view/shop_detail_screen.dart';
class Homescreen extends StatefulWidget {
  final VoidCallback? onSeeAllOrdersPressed; // 1. Add callback variable

  const Homescreen({
    super.key,
    this.onSeeAllOrdersPressed, // 2. Require it in constructor
  });

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final ApiService _apiService = ApiService();
  late Future<List<ShopModel>> _futureShops;
  Future<List<OrderModel>>? _futureTodayOrders;

  bool _isLoggedIn = false;
  bool _isLoadingAuth = true;

  @override
  void initState() {
    super.initState();
    _futureShops = _apiService.getShops();
    _checkLoginStatusAndFetchOrders();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoggedIn) {
      _refreshOrders();
    }
  }

  Future<void> _checkLoginStatusAndFetchOrders() async {
    final token = await SecureStorageService.getToken();

    if (mounted) {
      setState(() {
        _isLoggedIn = token != null && token.isNotEmpty;
        _isLoadingAuth = false;
        if (_isLoggedIn) {
          _futureTodayOrders = _fetchTodayOrders();
        }
      });
    }
  }

  // Public method to allow refreshing orders externally or via pull-to-refresh
  Future<void> _refreshOrders() async {
    setState(() {
      _futureTodayOrders = _fetchTodayOrders();
    });
  }

  Future<List<OrderModel>> _fetchTodayOrders() async {
    try {
      List<OrderModel> allOrders = await _apiService.getUserOrders();
      final now = DateTime.now();

      final todayOrders = allOrders.where((order) {
        try {
          String timeStr = order.orderTime.toLowerCase().trim();

          if (timeStr.startsWith("today")) {
            return true;
          }

          DateTime? orderDate = DateTime.tryParse(order.orderTime);
          if (orderDate != null) {
            return orderDate.year == now.year &&
                orderDate.month == now.month &&
                orderDate.day == now.day;
          }

          return false;
        } catch (e) {
          return false;
        }
      }).toList();

      return todayOrders;
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await _checkLoginStatusAndFetchOrders();
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
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
              SliverToBoxAdapter(child: MenuSection()),

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
                          onTap: () async {
                            // Await navigation back so we can trigger a refresh if an order was placed
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ShopDetailScreen(
                                  shopName: shop.shopName,
                                  shopId: shop.shopId,
                                ),
                              ),
                            );
                            _refreshOrders();
                          },
                        );
                      },
                      childCount: shops.length,
                    ),
                  );
                },
              ),

              /// 3. CONDITIONAL RECENT ORDERS SECTION (Only shown if user is logged in)[cite: 13]
              if (!_isLoadingAuth && _isLoggedIn && _futureTodayOrders != null) ...[
                FutureBuilder<List<OrderModel>>(
                  future: _futureTodayOrders,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    }

                    // Handle empty state for today's orders by showing text instead of hiding completely[cite: 12]
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "ယနေ့အော်ဒါ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1E293B),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  "ယနေ့အတွက် မကြာသေးခင်က ပြုလုပ်ထားသော အော်ဒါများ မရှိသေးပါ။",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final todayOrders = snapshot.data!.take(5).toList();

                    return SliverMainAxisGroup(
                      slivers: [
                        /// RECENT ORDERS TITLE + SEE ALL
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "ယနေ့အော်ဒါ",
                                  style: TextStyle(
                                  fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff1E293B),
                                  ),
                                ),
                               TextButton(
                                  onPressed: () {
                                    // 3. Trigger the callback if provided, otherwise fallback to standard navigation
                                    if (widget.onSeeAllOrdersPressed != null) {
                                      widget.onSeeAllOrdersPressed!();
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const OrdersScreen(),
                                        ),
                                      );
                                    }
                                  },
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

                        /// RECENT ORDERS LIST Mapped from OrderModel
                        SliverList(
  delegate: SliverChildBuilderDelegate(
    (context, index) {
      final order = todayOrders[index];

     // Prepare the map structure to match OrderDetailScreen expectations
      final Map<String, dynamic> rawOrderMap = {
        "order_id": order.orderId,
        "shop_name": order.shopName,
        "customer_name": order.customerName,
        "customer_phone": order.customerPhone,
        "order_time": order.orderTime, // <--- This fixes the missing order date/time
        "qr_code_token": order.qrCodeToken,
        "can_pickup": order.canPickup,
        "items": order.items.map((item) => {
          "name": item.name,
          "quantity": item.quantity,
          "unit_price": item.unitPrice,
          "total_price": item.totalPrice,
        }).toList(),
      };

      return RecentOrderCard(
        shopName: order.shopName,
        orderDate: order.orderTime,
        totalPrice: "${order.totalPoints} pts",
        items: order.items.map((item) {
          return OrderItem(
            name: item.name,
            quantity: item.quantity,
          );
        }).toList(),
        orderData: rawOrderMap, // Pass the map here safely
      );
    },
    childCount: todayOrders.length,
  ),
),
                      ],
                    );
                  },
                ),
              ],

              /// BOTTOM SPACE
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),
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