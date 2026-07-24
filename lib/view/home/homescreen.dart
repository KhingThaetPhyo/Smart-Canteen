
// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:smartcanteen/view/profilescreen.dart';

// // // ---------------------------------------------------------------------
// // // ၂။ NAVIGATION CONTROLLER SCREEN (စာမျက်နှာများ ချိတ်ဆက်မှုကို ထိန်းချုပ်သည့် နေရာ)
// // // ---------------------------------------------------------------------
// // class Homescreen extends StatefulWidget {
// //   const Homescreen({super.key});

// //   @override
// //   State<Homescreen> createState() => _MainNavigationScreenState();
// // }

// // class _MainNavigationScreenState extends State<Homescreen> {
// //   int _currentNavIndex = 0; // ဘယ် Page ရောက်နေလဲ Track လုပ်ရန်

// //   // ပြသပေးမည့် စာမျက်နှာများ စာရင်း (Profile Screen ကို ဖယ်ထုတ်လိုက်ပါပြီ)
// //   final List<Widget> _screens = [
// //     const IceCreamShopScreen(), // Index 0 (Home)
// //     const Center(
// //       child: Text(
// //         'Orders Screen',
// //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //       ),
// //     ), // Index 1
// //     const Center(
// //       child: Text(
// //         'History Screen',
// //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //       ),
// //     ), // Index 2
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     const schoolBlueColor = Color(0xFF0C5470);

// //     return Scaffold(
// //       extendBody: true,
// //       resizeToAvoidBottomInset: false,

// //       // လက်ရှိ ရွေးချယ်ထားတဲ့ Index အလိုက် Page ကို လှည့်ပြပေးပါတယ်
// //       body: _screens[_currentNavIndex],

// //       // Floating Action Button (QR Scanner)
// //       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// //       floatingActionButton: Transform.translate(
// //         offset: const Offset(0, 12),
// //         child: Container(
// //           height: 58,
// //           width: 58,
// //           decoration: BoxDecoration(
// //             color: schoolBlueColor,
// //             shape: BoxShape.circle,
// //             border: Border.all(color: Colors.white, width: 3),
// //             boxShadow: [
// //               BoxShadow(
// //                 color: Colors.black.withOpacity(0.15),
// //                 blurRadius: 8,
// //                 offset: const Offset(0, 3),
// //               ),
// //             ],
// //           ),
// //           child: FloatingActionButton(
// //             elevation: 0,
// //             backgroundColor: Colors.transparent,
// //             onPressed: () {
// //               context.go('/scan_qr');
// //             },
// //             child: const Icon(
// //               Icons.qr_code_scanner,
// //               color: Colors.white,
// //               size: 24,
// //             ),
// //           ),
// //         ),
// //       ),

// //       // Custom Bottom Navigation Bar
// //       bottomNavigationBar: Container(
// //         height: 68,
// //         margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
// //         decoration: BoxDecoration(
// //           color: const Color(0xFF0C5470),
// //           borderRadius: BorderRadius.circular(32),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black.withOpacity(0.08),
// //               blurRadius: 15,
// //               offset: const Offset(0, 6),
// //             ),
// //           ],
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceAround,
// //           children: [
// //             _buildBottomNavItem(
// //               Icons.home_rounded,
// //               'Home',
// //               0,
// //               const Color(0xFFE3F2FD),
// //             ),
// //             _buildBottomNavItem(
// //               Icons.assignment_rounded,
// //               'Orders',
// //               1,
// //               const Color(0xFFE3F2FD),
// //             ),
// //             const SizedBox(width: 40),
// //             _buildBottomNavItem(
// //               Icons.account_balance_wallet_rounded,
// //               'Wallet',
// //               2,
// //               const Color(0xFFE3F2FD),
// //             ),

// //             // Profile အတွက် Index 3 လို့ပဲ ပေးထားပါတယ်
// //             _buildBottomNavItem(
// //               Icons.person_rounded,
// //               'Profile',
// //               3,
// //               const Color(0xFFE3F2FD),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // Navigation Item တစ်ခုချင်းစီကို နှိပ်ရင် Switch ဖြစ်စေမယ့် Function
// //   Widget _buildBottomNavItem(
// //     IconData icon,
// //     String label,
// //     int index,
// //     Color activeColor,
// //   ) {
// //     final isActive = _currentNavIndex == index;
// //     final color = isActive ? activeColor : const Color(0xFF9CA3AF);

// //     return GestureDetector(
// //       onTap: () {
// //         // 👇 အကယ်၍ Profile (Index 3) ကို နှိပ်ခဲ့ရင် Page အသစ်အနေနဲ့ Push လုပ်ပါမယ်
// //         if (index == 3) {
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (context) => const ProfileScreen()),
// //           );
// //         } else {
// //           // တခြား Home, Orders, History ဆိုရင်တော့ ပုံမှန်အတိုင်း Index ပဲ ချိန်းပေးပါမယ်
// //           setState(() {
// //             _currentNavIndex = index;
// //           });
// //         }
// //       },
// //       child: Container(
// //         color: Colors.transparent, // Touch Area ကို နေရာအပြည့် ရစေရန်
// //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(icon, color: color, size: 22),
// //             const SizedBox(height: 3),
// //             Text(
// //               label,
// //               style: TextStyle(
// //                 color: color,
// //                 fontSize: 10,
// //                 fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // ---------------------------------------------------------------------
// // // ၃။ ICE CREAM SHOP SCREEN (BODY CONTENT ONLY)
// // // ---------------------------------------------------------------------
// // class IceCreamShopScreen extends StatefulWidget {
// //   const IceCreamShopScreen({super.key});

// //   @override
// //   State<IceCreamShopScreen> createState() => _IceCreamShopScreenState();
// // }

// // class _IceCreamShopScreenState extends State<IceCreamShopScreen> {
// //   int _selectedCategoryIndex = 0;

// //   final List<String> categories = [
// //     'All',
// //     'Snack',
// //     'Drinks',
// //     'Dessert',
// //     'Bakery',
// //     'Candy',
// //     'Ice Cream',
// //     'Smoothies',
// //     'Fast Food',
// //     'Coffee',
// //   ];

// //   final List<bool> _horizontalFavorites = List.generate(10, (index) => false);

// //   final List<Map<String, String>> horizontalIceCreams = [
// //     {'name': 'Matcha Delight', 'price': '\$ 12.34'},
// //     {'name': 'Mango Smoothie', 'price': '\$ 10.50'},
// //     {'name': 'Strawberry Twist', 'price': '\$ 11.99'},
// //     {'name': 'Vanilla Bean', 'price': '\$ 9.00'},
// //     {'name': 'Chocolate Fudge', 'price': '\$ 13.00'},
// //     {'name': 'Taro Heaven', 'price': '\$ 11.50'},
// //     {'name': 'Berry Blast', 'price': '\$ 12.00'},
// //     {'name': 'Coconut Dream', 'price': '\$ 10.00'},
// //     {'name': 'Avocado Cream', 'price': '\$ 14.00'},
// //     {'name': 'Durian Special', 'price': '\$ 15.50'},
// //   ];

// //   final List<Map<String, String>> verticalIceCreams = [
// //     {'name': 'Mint Chocolate Chip', 'price': '\$3.99'},
// //     {'name': 'Caramel Crunch', 'price': '\$4.50'},
// //     {'name': 'Cookie Dough Special', 'price': '\$4.99'},
// //     {'name': 'Coffee Almond Fudge', 'price': '\$5.20'},
// //     {'name': 'Pistachio Perfection', 'price': '\$4.80'},
// //     {'name': 'Rocky Road Classic', 'price': '\$4.60'},
// //     {'name': 'Banana Split Cup', 'price': '\$6.00'},
// //     {'name': 'Blueberry Cheesecake', 'price': '\$5.50'},
// //     {'name': 'Mango Tango Gelato', 'price': '\$4.20'},
// //     {'name': 'Red Velvet Scoop', 'price': '\$5.00'},
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     const schoolBlueColor = Color(0xFF0C5470);

// //     return SafeArea(
// //       top: true,
// //       bottom: false,
// //       child: Column(
// //         children: [
// //           // Header Card
// //           Container(
// //             width: double.infinity,
// //             decoration: BoxDecoration(
// //               color: schoolBlueColor,
// //               borderRadius: const BorderRadius.only(
// //                 bottomLeft: Radius.circular(32),
// //                 bottomRight: Radius.circular(32),
// //               ),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: schoolBlueColor.withOpacity(0.3),
// //                   blurRadius: 15,
// //                   offset: const Offset(0, 5),
// //                 ),
// //               ],
// //             ),
// //             padding: const EdgeInsets.all(40.0),
// //             child: Row(
// //               children: [
// //                 const CircleAvatar(
// //                   radius: 24,
// //                   backgroundColor: Colors.white24,
// //                   child: Icon(
// //                     Icons.person_outline,
// //                     size: 45,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //                 const SizedBox(width: 14),
// //                 Expanded(
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Flexible(
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: const [
// //                             Text(
// //                               'Good morning',
// //                               style: TextStyle(
// //                                 color: Colors.white70,
// //                                 fontSize: 13,
// //                               ),
// //                             ),
// //                             SizedBox(height: 3),
// //                             Text(
// //                               'Wa Thon',
// //                               style: TextStyle(
// //                                 color: Colors.white,
// //                                 fontSize: 18,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       const SizedBox(width: 8),
// //                       Column(
// //                         crossAxisAlignment: CrossAxisAlignment.end,
// //                         children: [
// //                           const Text(
// //                             'MY POINTS',
// //                             style: TextStyle(
// //                               color: Colors.white54,
// //                               fontWeight: FontWeight.bold,
// //                               letterSpacing: 1.0,
// //                               fontSize: 11,
// //                             ),
// //                           ),
// //                           Row(
// //                             crossAxisAlignment: CrossAxisAlignment.baseline,
// //                             textBaseline: TextBaseline.alphabetic,
// //                             children: const [
// //                               Text(
// //                                 '1555',
// //                                 style: TextStyle(
// //                                   color: Colors.white,
// //                                   fontSize: 30,
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                               SizedBox(width: 3),
// //                               Text(
// //                                 'pts',
// //                                 style: TextStyle(
// //                                   color: Colors.white70,
// //                                   fontSize: 14,
// //                                   fontWeight: FontWeight.w500,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),

// //           // Search Bar & Categories
// //           Padding(
// //             padding: const EdgeInsets.symmetric(
// //               horizontal: 20.0,
// //               vertical: 20.0,
// //             ),
// //             child: Column(
// //               children: [
// //                 Container(
// //                   decoration: BoxDecoration(
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.black.withOpacity(0.05),
// //                         blurRadius: 10,
// //                         offset: const Offset(0, 4),
// //                       ),
// //                     ],
// //                   ),
// //                   child: SizedBox(
// //                     height: 46,
// //                     child: TextField(
// //                       decoration: InputDecoration(
// //                         hintText: 'Search_',
// //                         hintStyle: const TextStyle(
// //                           fontSize: 14,
// //                           color: Color(0xFF9CA3AF),
// //                         ),
// //                         prefixIcon: const Icon(
// //                           Icons.search,
// //                           color: Color(0xFF9CA3AF),
// //                           size: 20,
// //                         ),
// //                         suffixIcon: const Icon(
// //                           Icons.close,
// //                           color: Color(0xFF9CA3AF),
// //                           size: 20,
// //                         ),
// //                         filled: true,
// //                         fillColor: Colors.white,
// //                         contentPadding: const EdgeInsets.symmetric(vertical: 0),
// //                         border: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(14),
// //                           borderSide: BorderSide.none,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 16),
// //                 SingleChildScrollView(
// //                   scrollDirection: Axis.horizontal,
// //                   physics: const BouncingScrollPhysics(),
// //                   child: Row(
// //                     children: List.generate(categories.length, (index) {
// //                       return Padding(
// //                         padding: const EdgeInsets.symmetric(horizontal: 7.0),
// //                         child: GestureDetector(
// //                           onTap: () =>
// //                               setState(() => _selectedCategoryIndex = index),
// //                           child: CategoryTab(
// //                             title: categories[index],
// //                             isSelected: _selectedCategoryIndex == index,
// //                             activeColor: schoolBlueColor,
// //                           ),
// //                         ),
// //                       );
// //                     }),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),

// //           // Main Content List
// //           Expanded(
// //             child: ListView(
// //               physics: const BouncingScrollPhysics(),
// //               padding: const EdgeInsets.only(bottom: 140.0),
// //               children: [
// //                 WidgetSizedBoxHorizontal(
// //                   height: 275,
// //                   child: ListView.builder(
// //                     padding: const EdgeInsets.symmetric(horizontal: 15.0),
// //                     scrollDirection: Axis.horizontal,
// //                     physics: const BouncingScrollPhysics(),
// //                     itemCount: horizontalIceCreams.length,
// //                     itemBuilder: (context, index) {
// //                       return Padding(
// //                         padding: const EdgeInsets.only(
// //                           right: 15.0,
// //                           bottom: 12.0,
// //                           top: 4,
// //                         ),
// //                         child: _buildHorizontalCard(
// //                           index,
// //                           horizontalIceCreams[index]['name']!,
// //                           horizontalIceCreams[index]['price']!,
// //                           Icons.icecream_outlined,
// //                           schoolBlueColor,
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 ListView.builder(
// //                   shrinkWrap: true,
// //                   physics: const NeverScrollableScrollPhysics(),
// //                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
// //                   itemCount: verticalIceCreams.length,
// //                   itemBuilder: (context, index) {
// //                     final item = verticalIceCreams[index];
// //                     return Padding(
// //                       padding: const EdgeInsets.only(bottom: 25.0),
// //                       child: _buildVerticalCard(
// //                         index,
// //                         item['name']!,
// //                         item['price']!,
// //                         Icons.icecream_rounded,
// //                         schoolBlueColor,
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildHorizontalCard(
// //     int index,
// //     String name,
// //     String price,
// //     IconData icon,
// //     Color schoolColor,
// //   ) {
// //     return Container(
// //       width: 155,
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(20),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.05),
// //             blurRadius: 10,
// //             offset: const Offset(0, 4),
// //           ),
// //         ],
// //       ),
// //       padding: const EdgeInsets.all(12),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Container(
// //             height: 140,
// //             width: double.infinity,
// //             decoration: BoxDecoration(
// //               color: schoolColor.withOpacity(0.1),
// //               borderRadius: BorderRadius.circular(16),
// //             ),
// //             child: Icon(icon, size: 38, color: schoolColor),
// //           ),
// //           const SizedBox(height: 12),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Text(
// //                   name,
// //                   maxLines: 1,
// //                   overflow: TextOverflow.ellipsis,
// //                   style: const TextStyle(
// //                     fontWeight: FontWeight.bold,
// //                     fontSize: 14,
// //                     color: Colors.black87,
// //                   ),
// //                 ),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Text(
// //                       price,
// //                       style: TextStyle(
// //                         color: schoolColor,
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 13,
// //                       ),
// //                     ),
// //                     GestureDetector(
// //                       onTap: () => setState(
// //                         () => _horizontalFavorites[index] =
// //                             !_horizontalFavorites[index],
// //                       ),
// //                       child: Container(
// //                         padding: const EdgeInsets.all(4),
// //                         decoration: const BoxDecoration(
// //                           color: Colors.white,
// //                           shape: BoxShape.circle,
// //                         ),
// //                         child: Icon(
// //                           _horizontalFavorites[index]
// //                               ? Icons.favorite_rounded
// //                               : Icons.favorite_border_rounded,
// //                           size: 18,
// //                           color: schoolColor,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildVerticalCard(
// //     int index,
// //     String name,
// //     String price,
// //     IconData icon,
// //     Color schoolColor,
// //   ) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(22),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.06),
// //             blurRadius: 10,
// //             offset: const Offset(0, 5),
// //           ),
// //         ],
// //       ),
// //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
// //       child: Row(
// //         children: [
// //           Container(
// //             height: 90,
// //             width: 100,
// //             decoration: BoxDecoration(
// //               color: schoolColor.withOpacity(0.1),
// //               borderRadius: BorderRadius.circular(16),
// //             ),
// //             child: Icon(icon, size: 42, color: schoolColor),
// //           ),
// //           const SizedBox(width: 20),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Text(
// //                   name,
// //                   style: const TextStyle(
// //                     fontWeight: FontWeight.bold,
// //                     fontSize: 18,
// //                     color: Colors.black87,
// //                   ),
// //                   maxLines: 1,
// //                   overflow: TextOverflow.ellipsis,
// //                 ),
// //                 const SizedBox(height: 8),
// //                 Text(
// //                   price,
// //                   style: TextStyle(
// //                     color: schoolColor,
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // ---------------------------------------------------------------------
// // // ၄။ UTILITY WIDGETS
// // // ---------------------------------------------------------------------
// // class WidgetSizedBoxHorizontal extends StatelessWidget {
// //   final double height;
// //   final Widget child;
// //   const WidgetSizedBoxHorizontal({
// //     super.key,
// //     required this.height,
// //     required this.child,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(height: height, child: child);
// //   }
// // }

// // class CategoryTab extends StatelessWidget {
// //   final String title;
// //   final bool isSelected;
// //   final Color activeColor;
// //   const CategoryTab({
// //     super.key,
// //     required this.title,
// //     required this.isSelected,
// //     required this.activeColor,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return AnimatedContainer(
// //       duration: const Duration(milliseconds: 200),
// //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// //       decoration: BoxDecoration(
// //         color: isSelected ? activeColor : Colors.white,
// //         borderRadius: BorderRadius.circular(24),
// //         border: Border.all(
// //           color: isSelected ? Colors.transparent : Colors.grey.withOpacity(0.2),
// //           width: 1,
// //         ),
// //         boxShadow: [
// //           if (!isSelected)
// //             BoxShadow(
// //               color: Colors.black.withOpacity(0.04),
// //               blurRadius: 6,
// //               offset: const Offset(0, 2),
// //             ),
// //         ],
// //       ),
// //       child: Center(
// //         child: Text(
// //           title,
// //           style: TextStyle(
// //             fontSize: 14,
// //             fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
// //             color: isSelected ? Colors.white : Colors.black87,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:smartcanteen/model/user_model.dart';
// import 'package:smartcanteen/view/home/home_header.dart';
// import 'package:smartcanteen/view/home/menu.dart';
// import 'package:smartcanteen/view/home/recent_order.dart';
// import 'package:smartcanteen/view/home/shop.dart';
// import 'package:smartcanteen/view/shop_detail_screen.dart';

// // import 'widgets/home_header.dart';
// // import 'widgets/menu_section.dart';
// // import 'widgets/shop_card.dart';
// // import 'widgets/recent_order_card.dart';

// // import 'shop_detail_screen.dart';

// class Homescreen extends StatefulWidget {
//   final UserModel user;
//   const Homescreen({super.key, required this.user});

//   @override
//   State<Homescreen> createState() => _HomescreenState();
// }

// class _HomescreenState extends State<Homescreen> {
//   // Mock grouped order history data
//   final List<Map<String, dynamic>> recentOrdersData = [
//     {
//       "shopName": "Coffee Corner",
//       "orderDate": "Today, 10:15 AM",
//       "totalPrice": "4,500 pts",
//       "items": [
//         const OrderItem(name: "Milk Tea", quantity: 2),
//         const OrderItem(name: "Iced Americano", quantity: 1),
//       ],
//     },
//     {
//       "shopName": "Aunt May Noodles",
//       "orderDate": "Yesterday",
//       "totalPrice": "5,000 pts",
//       "items": [
//         const OrderItem(name: "Shan Noodle", quantity: 1),
//         const OrderItem(name: "Fried Tofu", quantity: 1),
//         const OrderItem(name: "Green Tea", quantity: 1),
//       ],
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     // Restrict list to only the 5 most recent items
//     final limitedOrders = recentOrdersData.take(5).toList();

//     return Scaffold(
//       backgroundColor: const Color(0xffF6F8FC),

//       body: SafeArea(
//         child: CustomScrollView(
//           physics: const BouncingScrollPhysics(),

//           slivers: [
//             /// HEADER
//             SliverToBoxAdapter(
//   child: HomeHeader(
//     userName: widget.user.userName,
//     major: widget.user.student?.yearLevel ?? "",
//     studentId: widget.user.student?.studentId ?? "",
//     points: widget.user.wallet?.balance ?? 0,
//   ),
// ),

//             SliverToBoxAdapter(child: SizedBox(height: 60)),

//             /// POPULAR MENU
//             const SliverToBoxAdapter(child: MenuSection()),

//             /// POPULAR SHOPS TITLE
//             const SliverToBoxAdapter(
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
//                 child: Text(
//                   "Shops",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),

//             /// SHOPS
//             SliverList(
//               delegate: SliverChildListDelegate([
//                 ShopCard(
//                   shopName: "Coffee Corner",
//                   category: "Coffee & Drinks",
//                   rating: 4.8,
//                   estimatedTime: "5 - 10 min",
//                   isOpen: true,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) =>
//                             const ShopDetailScreen(shopName: "Coffee Corner"),
//                       ),
//                     );
//                   },
//                 ),

//                 ShopCard(
//                   shopName: "Aunt May Noodles",
//                   category: "Noodles",
//                   rating: 4.9,
//                   estimatedTime: "10 - 15 min",
//                   isOpen: true,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const ShopDetailScreen(
//                           shopName: "Aunt May Noodles",
//                         ),
//                       ),
//                     );
//                   },
//                 ),

//                 ShopCard(
//                   shopName: "Snack House",
//                   category: "Snacks",
//                   rating: 4.7,
//                   estimatedTime: "5 - 8 min",
//                   isOpen: false,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) =>
//                             const ShopDetailScreen(shopName: "Snack House"),
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
//                       "Recent Orders",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xff1E293B),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         // TODO: Navigate to full OrdersScreen / Orders tab
                        
//                       },
//                       style: TextButton.styleFrom(
//                         padding: EdgeInsets.zero,
//                         minimumSize: const Size(50, 30),
//                         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                       ),
//                       child: const Text(
//                         "See All",
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

//             /// RECENT ORDERS (MAX 5 ORDER BLOCKS)
//             SliverList(
//               delegate: SliverChildBuilderDelegate((context, index) {
//                 final order = limitedOrders[index];
//                 return RecentOrderCard(
//                   shopName: order["shopName"],
//                   orderDate: order["orderDate"],
//                   totalPrice: order["totalPrice"],
//                   items: order["items"],
//                   onReorder: () {
//                     // Reorder all items logic
//                   },
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

import 'package:flutter/material.dart';

import 'package:smartcanteen/view/home/home_header.dart';
import 'package:smartcanteen/view/home/menu.dart';
import 'package:smartcanteen/view/home/recent_order.dart';
import 'package:smartcanteen/view/home/shop.dart';
import 'package:smartcanteen/view/shop_detail_screen.dart';


class Homescreen extends StatefulWidget {

  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();

}


class _HomescreenState extends State<Homescreen> {


  final List<Map<String,dynamic>> recentOrdersData = [

    {
      "shopName":"Coffee Corner",
      "orderDate":"Today, 10:15 AM",
      "totalPrice":"4,500 pts",

      "items":[

        OrderItem(
          name:"Milk Tea",
          quantity:2,
        ),

        OrderItem(
          name:"Iced Americano",
          quantity:1,
        ),

      ],

    },


    {

      "shopName":"Aunt May Noodles",
      "orderDate":"Yesterday",
      "totalPrice":"5,000 pts",

      "items":[

        OrderItem(
          name:"Shan Noodle",
          quantity:1,
        ),

        OrderItem(
          name:"Fried Tofu",
          quantity:1,
        ),

        OrderItem(
          name:"Green Tea",
          quantity:1,
        ),

      ],

    },


  ];




  @override
  Widget build(BuildContext context) {


    final limitedOrders =
        recentOrdersData.take(5).toList();


    return Scaffold(

      backgroundColor:
      const Color(0xffF6F8FC),


      body: SafeArea(

        child: CustomScrollView(

          physics:
          const BouncingScrollPhysics(),


          slivers: [


            /// HEADER

            SliverToBoxAdapter(

              child: HomeHeader(

                userName:"Honey",

                major:"Computer Science",

                studentId:"CS-2026-001",

                points:12500,

              ),

            ),




            const SliverToBoxAdapter(

              child:SizedBox(height:60),

            ),





            /// MENU

            const SliverToBoxAdapter(

              child:MenuSection(),

            ),






            /// SHOP TITLE

            const SliverToBoxAdapter(

              child:Padding(

                padding:
                EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    8
                ),


                child:Text(

                  "Shops",

                  style:TextStyle(

                    fontSize:20,

                    fontWeight:
                    FontWeight.bold,

                  ),

                ),

              ),

            ),







            /// SHOP LIST

            SliverList(

              delegate:
              SliverChildListDelegate([



                ShopCard(

                  shopName:
                  "Coffee Corner",

                  category:
                  "Coffee & Drinks",

                  rating:4.8,

                  estimatedTime:
                  "5 - 10 min",

                  isOpen:true,


                  onTap:(){


                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder:(_)=>
                        const ShopDetailScreen(

                          shopName:
                          "Coffee Corner",

                        ),

                      ),

                    );


                  },

                ),






                ShopCard(

                  shopName:
                  "Aunt May Noodles",

                  category:
                  "Noodles",

                  rating:4.9,

                  estimatedTime:
                  "10 - 15 min",

                  isOpen:true,


                  onTap:(){


                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder:(_)=>
                        const ShopDetailScreen(

                          shopName:
                          "Aunt May Noodles",

                        ),

                      ),

                    );


                  },


                ),







                ShopCard(

                  shopName:
                  "Snack House",

                  category:
                  "Snacks",

                  rating:4.7,

                  estimatedTime:
                  "5 - 8 min",

                  isOpen:false,


                  onTap:(){


                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder:(_)=>
                        const ShopDetailScreen(

                          shopName:
                          "Snack House",

                        ),

                      ),

                    );


                  },

                ),



              ]),


            ),







            /// RECENT ORDER TITLE


            SliverToBoxAdapter(

              child:Padding(

                padding:
                const EdgeInsets.fromLTRB(
                    20,
                    24,
                    20,
                    8
                ),


                child:Row(

                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,


                  children:[


                    const Text(

                      "Recent Orders",

                      style:TextStyle(

                        fontSize:20,

                        fontWeight:
                        FontWeight.bold,

                        color:
                        Color(0xff1E293B),

                      ),

                    ),





                    TextButton(

                      onPressed:(){},


                      child:const Text(

                        "See All",

                        style:TextStyle(

                          color:
                          Color(0xff117992),

                          fontWeight:
                          FontWeight.bold,

                        ),

                      ),

                    ),


                  ],

                ),

              ),

            ),







            /// RECENT ORDERS


            SliverList(

              delegate:
              SliverChildBuilderDelegate(

                    (context,index){


                  final order =
                  limitedOrders[index];


                  return RecentOrderCard(

                    shopName:
                    order["shopName"],


                    orderDate:
                    order["orderDate"],


                    totalPrice:
                    order["totalPrice"],


                    items:
                    order["items"],


                    onReorder:(){},


                  );


                },


                childCount:
                limitedOrders.length,

              ),

            ),





            const SliverToBoxAdapter(

              child:SizedBox(height:120),

            ),



          ],


        ),

      ),

    );

  }

}