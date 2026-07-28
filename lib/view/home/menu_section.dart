// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class MenuSection extends StatelessWidget {
//   const MenuSection({super.key});

//   static const Color primaryColor = Color(0xff117992);

//   Widget _buildCategoryButton(String title, bool isSelected) {
//     return Container(
//       decoration: BoxDecoration(
//         color: isSelected ? primaryColor : Colors.white,
//         borderRadius: BorderRadius.circular(25),
//         border: Border.all(
//           color: isSelected ? primaryColor : Colors.grey.shade300,
//           width: 1,
//         ),
//       ),
//       child: TextButton(
//         onPressed: () {},
//         style: TextButton.styleFrom(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 8,
//           ),
//           minimumSize: Size.zero,
//           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.black87,
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//             fontSize: 12,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> menuItems = [
//       {
//         "image": "assets/image/ကြက်ဟင်းခါးသီးကြော်.jpg",
//         "menuName": "ကြက်ဟင်းခါးသီးကြော်",
//         "shopName": "Aunty Mon",
//         "price": 1500,
//       },
//       {
//         "image": "assets/image/လက်ဖက်ထမင်း.jpg",
//         "menuName": "လက်ဖက်ထမင်း",
//         "shopName": "Tun",
//         "price": 2200,
//       },
//       {
//         "image": "assets/image/ဘဲဥဟင်း.jpg",
//         "menuName": "မုန့်ဟင်းခါး",
//         "shopName": "Daw Nu",
//         "price": 1800,
//       },
//       {
//         "image": "assets/image/ကြာဇံကြော်.jpg",
//         "menuName": "သံပရာရည်",
//         "shopName": "Chill Zone",
//         "price": 1200,
//       },
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// CATEGORIES HEADER
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "အမျိုးအစားများ",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   "အားလုံးကြည့်ရန်",
//                   style: TextStyle(
//                     color: primaryColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         /// CATEGORY PILLS HORIZONTAL SCROLL (Optimized gesture handling)
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             children: [
//               _buildCategoryButton("နေ့လယ်စာ", true),
//               const SizedBox(width: 10),
//               _buildCategoryButton("မနက်စာ", false),
//               const SizedBox(width: 10),
//               _buildCategoryButton("မုန့်များ", false),
//               const SizedBox(width: 10),
//               _buildCategoryButton("အချိုရည်", false),
//               const SizedBox(width: 10),
//               _buildCategoryButton("အချိုပွဲ", false),
//             ],
//           ),
//         ),

//         const SizedBox(height: 16),

//         /// MENU GRID SECTION (Fixed non-scrollable configuration)
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(), // 👈 Disables inner vertical scrolling completely
//             itemCount: menuItems.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 14,
//               mainAxisSpacing: 16,
//               childAspectRatio: 0.85, 
//             ),
//             itemBuilder: (context, index) {
//               final item = menuItems[index];
//               return _PopularMenuCard(
//                 image: item["image"],
//                 menuName: item["menuName"],
//                 shopName: item["shopName"],
//                 price: item["price"],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _PopularMenuCard extends StatefulWidget {
//   final String image;
//   final String menuName;
//   final String shopName;
//   final int price;

//   const _PopularMenuCard({
//     required this.image,
//     required this.menuName,
//     required this.shopName,
//     required this.price,
//   });

//   @override
//   State<_PopularMenuCard> createState() => _PopularMenuCardState();
// }

// class _PopularMenuCardState extends State<_PopularMenuCard> {
//   bool isFavorite = false;

//   static const Color primaryColor = Color(0xff117992);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.04),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           /// 1. IMAGE SECTION
//           Expanded(
//             flex: 2,
//             child: Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(16),
//                   ),
//                   child: SizedBox.expand(
//                     child: Image.asset(
//                       widget.image,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 6,
//                   right: 6,
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         isFavorite = !isFavorite;
//                       });
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(.9),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         isFavorite ? Icons.favorite : Icons.favorite_border,
//                         color: isFavorite ? Colors.red : Colors.grey.shade600,
//                         size: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           /// 2. TEXT/CONTENT SECTION
//           Expanded(
//             flex: 1,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.menuName,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.storefront_outlined,
//                               size: 11,
//                               color: Colors.grey.shade600,
//                             ),
//                             const SizedBox(width: 2),
//                             Expanded(
//                               child: Text(
//                                 widget.shopName,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   color: Colors.grey.shade600,
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Text(
//                           "${NumberFormat('#,###').format(widget.price)} ပွိုင့်",
//                           style: const TextStyle(
//                             color: primaryColor,
//                             fontSize: 11,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 4),
//                   InkWell(
//                     onTap: () {},
//                     borderRadius: BorderRadius.circular(6),
//                     child: Container(
//                       width: 25,
//                       height: 25,
//                       decoration: BoxDecoration(
//                         color: primaryColor,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: const Icon(
//                         Icons.arrow_forward_ios,
//                         color: Colors.white,
//                         size: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';// Adjust path if necessary
// import 'package:smartcanteen/model/menu_model.dart';
// import 'package:smartcanteen/service/api_service.dart'; // Adjust path if necessary

// class MenuSection extends StatefulWidget {
//   const MenuSection({super.key});

//   @override
//   State<MenuSection> createState() => _MenuSectionState();
// }

// class _MenuSectionState extends State<MenuSection> {
//   static const Color primaryColor = Color(0xff117992);
  
//   final ApiService _apiService = ApiService();
//   late Future<List<_DisplayMenuItem>> _futureMenuItems;

//   @override
//   void initState() {
//     super.initState();
//     _futureMenuItems = _fetchDisplayItems();
//   }

//   /// Helper to fetch and extract all items across all shops
//   Future<List<_DisplayMenuItem>> _fetchDisplayItems() async {
//     final response = await _apiService.getShopsWithMenus();
//     List<_DisplayMenuItem> displayItems = [];

//     if (response != null && response.success) {
//       for (var shop in response.data) {
//         for (var menu in shop.menus!) {
//           displayItems.add(
//             _DisplayMenuItem(
//               shopName: shop.shopName,
//               menu: menu,
//             ),
//           );
//         }
//       }
//     }
//     return displayItems;
//   }

//   Widget _buildCategoryButton(String title, bool isSelected) {
//     return Container(
//       decoration: BoxDecoration(
//         color: isSelected ? primaryColor : Colors.white,
//         borderRadius: BorderRadius.circular(25),
//         border: Border.all(
//           color: isSelected ? primaryColor : Colors.grey.shade300,
//           width: 1,
//         ),
//       ),
//       child: TextButton(
//         onPressed: () {},
//         style: TextButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//           minimumSize: Size.zero,
//           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.black87,
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//             fontSize: 12,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// CATEGORIES HEADER
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "အမျိုးအစားများ",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   "အားလုံးကြည့်ရန်",
//                   style: TextStyle(
//                     color: primaryColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         /// CATEGORY PILLS HORIZONTAL SCROLL
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             children: [
//               _buildCategoryButton("နေ့လယ်စာ", true),
//               const SizedBox(width: 10),
//               _buildCategoryButton("မနက်စာ", false),
//               const SizedBox(width: 10),
//               _buildCategoryButton("မုန့်များ", false),
//               const SizedBox(width: 10),
//               _buildCategoryButton("အချိုရည်", false),
//               const SizedBox(width: 10),
//               _buildCategoryButton("အချိုပွဲ", false),
//             ],
//           ),
//         ),

//         const SizedBox(height: 16),

//         /// MENU GRID SECTION
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: FutureBuilder<List<_DisplayMenuItem>>(
//             future: _futureMenuItems,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(32.0),
//                     child: CircularProgressIndicator(color: primaryColor),
//                   ),
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       "အချက်အလက် ရယူ၍ မရပါ: ${snapshot.error}",
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   ),
//                 );
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return const Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Text("Menu များ မရှိသေးပါ။"),
//                   ),
//                 );
//               }

//               final menuItems = snapshot.data!;

//               return GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: menuItems.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 14,
//                   mainAxisSpacing: 16,
//                   childAspectRatio: 0.85,
//                 ),
//                 itemBuilder: (context, index) {
//                   final item = menuItems[index];
//                   return _PopularMenuCard(
//                     shopName: item.shopName,
//                     menu: item.menu,
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// /// Dynamic model linking menu data to its corresponding shop name
// class _DisplayMenuItem {
//   final String shopName;
//   final MenuModel menu;

//   _DisplayMenuItem({
//     required this.shopName,
//     required this.menu,
//   });
// }

// class _PopularMenuCard extends StatefulWidget {
//   final String shopName;
//   final MenuModel menu;

//   const _PopularMenuCard({
//     required this.shopName,
//     required this.menu,
//   });

//   @override
//   State<_PopularMenuCard> createState() => _PopularMenuCardState();
// }

// class _PopularMenuCardState extends State<_PopularMenuCard> {
//   bool isFavorite = false;
//   static const Color primaryColor = Color(0xff117992);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.04),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           /// 1. IMAGE SECTION
//           Expanded(
//             flex: 2,
//             child: Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(16),
//                   ),
//                   child: SizedBox.expand(
//                     child: Image.network(
//                       widget.menu.imageUrl,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) => Container(
//                         color: Colors.grey.shade200,
//                         child: const Icon(Icons.fastfood, color: Colors.grey),
//                       ),
//                       loadingBuilder: (context, child, loadingProgress) {
//                         if (loadingProgress == null) return child;
//                         return Container(
//                           color: Colors.grey.shade100,
//                           child: const Center(
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: primaryColor,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 6,
//                   right: 6,
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         isFavorite = !isFavorite;
//                       });
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(.9),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         isFavorite ? Icons.favorite : Icons.favorite_border,
//                         color: isFavorite ? Colors.red : Colors.grey.shade600,
//                         size: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           /// 2. TEXT/CONTENT SECTION
//           Expanded(
//             flex: 1,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.menu.itemName,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.storefront_outlined,
//                               size: 11,
//                               color: Colors.grey.shade600,
//                             ),
//                             const SizedBox(width: 2),
//                             Expanded(
//                               child: Text(
//                                 widget.shopName,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   color: Colors.grey.shade600,
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Text(
//                           "${NumberFormat('#,###').format(widget.menu.itemPrice)} ပွိုင့်",
//                           style: const TextStyle(
//                             color: primaryColor,
//                             fontSize: 11,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 4),
//                   InkWell(
//                     onTap: () {},
//                     borderRadius: BorderRadius.circular(6),
//                     child: Container(
//                       width: 25,
//                       height: 25,
//                       decoration: BoxDecoration(
//                         color: primaryColor,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: const Icon(
//                         Icons.arrow_forward_ios,
//                         color: Colors.white,
//                         size: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:smartcanteen/model/category_model.dart';
// import 'package:smartcanteen/model/menu_model.dart';
// import 'package:smartcanteen/service/api_service.dart';

// class MenuSection extends StatefulWidget {
//   const MenuSection({super.key});

//   @override
//   State<MenuSection> createState() => _MenuSectionState();
// }

// class _MenuSectionState extends State<MenuSection> {
//   static const Color primaryColor = Color(0xff117992);
//   final ApiService _apiService = ApiService();

//   late Future<List<CategoryModel>> _futureCategories;
//   late Future<List<_DisplayMenuItem>> _futureMenuItems;

//   // Track the selected category ID (null or 0 means "All")
//   int? _selectedCategoryId;

//   @override
//   void initState() {
//     super.initState();
//     _futureCategories = _apiService.getCategories();
//     _futureMenuItems = _fetchDisplayItems();
//   }

//   /// Helper to fetch and extract all items across all shops
//   Future<List<_DisplayMenuItem>> _fetchDisplayItems() async {
//     final response = await _apiService.getShopsWithMenus();
//     List<_DisplayMenuItem> displayItems = [];

//     if (response != null && response.success) {
//       for (var shop in response.data) {
//         if (shop.menus != null) {
//           for (var menu in shop.menus!) {
//             displayItems.add(
//               _DisplayMenuItem(
//                 shopName: shop.shopName,
//                 menu: menu,
//               ),
//             );
//           }
//         }
//       }
//     }
//     return displayItems;
//   }

//   Widget _buildCategoryButton({
//     required String title,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(right: 8),
//       decoration: BoxDecoration(
//         color: isSelected ? primaryColor : Colors.white,
//         borderRadius: BorderRadius.circular(25),
//         border: Border.all(
//           color: isSelected ? primaryColor : Colors.grey.shade300,
//           width: 1,
//         ),
//       ),
//       child: TextButton(
//         onPressed: onTap,
//         style: TextButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
//           minimumSize: Size.zero,
//           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.black87,
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//             fontSize: 12,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// CATEGORIES HEADER
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "အမျိုးအစားများ",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   "အားလုံးကြည့်ရန်",
//                   style: TextStyle(
//                     color: primaryColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         /// DYNAMIC CATEGORIES FROM API
//         FutureBuilder<List<CategoryModel>>(
//           future: _futureCategories,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const SizedBox(
//                 height: 38,
//                 child: Center(
//                   child: SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2,
//                       color: primaryColor,
//                     ),
//                   ),
//                 ),
//               );
//             } else if (snapshot.hasError) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Text(
//                   "အမျိုးအစားများ ရယူ၍ မရပါ: ${snapshot.error}",
//                   style: const TextStyle(color: Colors.red, fontSize: 12),
//                 ),
//               );
//             }

//             final categories = snapshot.data ?? [];

//             return SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                   // "All" Category Pill
//                   _buildCategoryButton(
//                     title: "အားလုံး",
//                     isSelected: _selectedCategoryId == null,
//                     onTap: () {
//                       setState(() {
//                         _selectedCategoryId = null;
//                       });
//                     },
//                   ),

//                   // Dynamic API Category Pills
//                   ...categories.map((category) {
//                     final isSelected =
//                         _selectedCategoryId == category.categoryId;
//                     return _buildCategoryButton(
//                       title: category.categoryName,
//                       isSelected: isSelected,
//                       onTap: () {
//                         setState(() {
//                           _selectedCategoryId = category.categoryId;
//                         });
//                       },
//                     );
//                   }),
//                 ],
//               ),
//             );
//           },
//         ),

//         const SizedBox(height: 16),

//         /// MENU GRID SECTION
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: FutureBuilder<List<_DisplayMenuItem>>(
//             future: _futureMenuItems,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(32.0),
//                     child: CircularProgressIndicator(color: primaryColor),
//                   ),
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       "အချက်အလက် ရယူ၍ မရပါ: ${snapshot.error}",
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   ),
//                 );
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return const Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Text("Menu များ မရှိသေးပါ။"),
//                   ),
//                 );
//               }

//               // Filter menu items by selected category ID if applicable
//               final filteredMenuItems = _selectedCategoryId == null
//                   ? snapshot.data!
//                   : snapshot.data!.where((item) {
//                       return item.menu.categoryId == _selectedCategoryId;
//                     }).toList();

//               if (filteredMenuItems.isEmpty) {
//                 return const Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(24.0),
//                     child: Text("ဤအမျိုးအစားတွင် Menu များ မရှိသေးပါ။"),
//                   ),
//                 );
//               }

//               return GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: filteredMenuItems.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 14,
//                   mainAxisSpacing: 16,
//                   childAspectRatio: 0.85,
//                 ),
//                 itemBuilder: (context, index) {
//                   final item = filteredMenuItems[index];
//                   return _PopularMenuCard(
//                     shopName: item.shopName,
//                     menu: item.menu,
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// /// Dynamic model linking menu data to its corresponding shop name
// class _DisplayMenuItem {
//   final String shopName;
//   final MenuModel menu;

//   _DisplayMenuItem({
//     required this.shopName,
//     required this.menu,
//   });
// }

// class _PopularMenuCard extends StatefulWidget {
//   final String shopName;
//   final MenuModel menu;

//   const _PopularMenuCard({
//     required this.shopName,
//     required this.menu,
//   });

//   @override
//   State<_PopularMenuCard> createState() => _PopularMenuCardState();
// }

// class _PopularMenuCardState extends State<_PopularMenuCard> {
//   bool isFavorite = false;
//   static const Color primaryColor = Color(0xff117992);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.04),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           /// 1. IMAGE SECTION
//           Expanded(
//             flex: 2,
//             child: Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(16),
//                   ),
//                   child: SizedBox.expand(
//                     child: Image.network(
//                       widget.menu.imageUrl,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) => Container(
//                         color: Colors.grey.shade200,
//                         child: const Icon(Icons.fastfood, color: Colors.grey),
//                       ),
//                       loadingBuilder: (context, child, loadingProgress) {
//                         if (loadingProgress == null) return child;
//                         return Container(
//                           color: Colors.grey.shade100,
//                           child: const Center(
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: primaryColor,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 6,
//                   right: 6,
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         isFavorite = !isFavorite;
//                       });
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(.9),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         isFavorite ? Icons.favorite : Icons.favorite_border,
//                         color: isFavorite ? Colors.red : Colors.grey.shade600,
//                         size: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           /// 2. TEXT/CONTENT SECTION
//           Expanded(
//             flex: 1,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.menu.itemName,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.storefront_outlined,
//                               size: 11,
//                               color: Colors.grey.shade600,
//                             ),
//                             const SizedBox(width: 2),
//                             Expanded(
//                               child: Text(
//                                 widget.shopName,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   color: Colors.grey.shade600,
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Text(
//                           "${NumberFormat('#,###').format(widget.menu.itemPrice)} ပွိုင့်",
//                           style: const TextStyle(
//                             color: primaryColor,
//                             fontSize: 11,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 4),
//                   InkWell(
//                     onTap: () {},
//                     borderRadius: BorderRadius.circular(6),
//                     child: Container(
//                       width: 25,
//                       height: 25,
//                       decoration: BoxDecoration(
//                         color: primaryColor,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: const Icon(
//                         Icons.arrow_forward_ios,
//                         color: Colors.white,
//                         size: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:smartcanteen/model/category_model.dart';
// import 'package:smartcanteen/model/menu_model.dart';
// import 'package:smartcanteen/service/api_service.dart';

// class MenuSection extends StatefulWidget {
//   const MenuSection({super.key});

//   @override
//   State<MenuSection> createState() => _MenuSectionState();
// }

// class _MenuSectionState extends State<MenuSection> {
//   static const Color primaryColor = Color(0xff117992);
//   final ApiService _apiService = ApiService();

//   late Future<List<CategoryModel>> _futureCategories;
//   late Future<List<_DisplayMenuItem>> _futureMenuItems;

//   // Selected category ID (null indicates "All")
//   int? _selectedCategoryId;

//   @override
//   void initState() {
//     super.initState();
//     _futureCategories = _apiService.getCategories();
//     _futureMenuItems = _fetchDisplayItems();
//   }

//   /// Fetches and flattens all menus from all shops into a display list
//   Future<List<_DisplayMenuItem>> _fetchDisplayItems() async {
//     final response = await _apiService.getShopsWithMenus();
//     List<_DisplayMenuItem> displayItems = [];

//     if (response != null && response.success) {
//       for (var shop in response.data) {
//         if (shop.menus != null) {
//           for (var menu in shop.menus!) {
//             displayItems.add(
//               _DisplayMenuItem(
//                 shopName: shop.shopName,
//                 menu: menu,
//               ),
//             );
//           }
//         }
//       }
//     }
//     return displayItems;
//   }

//   Widget _buildCategoryButton({
//     required String title,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(right: 8),
//       decoration: BoxDecoration(
//         color: isSelected ? primaryColor : Colors.white,
//         borderRadius: BorderRadius.circular(25),
//         border: Border.all(
//           color: isSelected ? primaryColor : Colors.grey.shade300,
//           width: 1,
//         ),
//       ),
//       child: TextButton(
//         onPressed: onTap,
//         style: TextButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
//           minimumSize: Size.zero,
//           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.black87,
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//             fontSize: 12,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// CATEGORIES HEADER
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "အမျိုးအစားများ",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   "အားလုံးကြည့်ရန်",
//                   style: TextStyle(
//                     color: primaryColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         /// DYNAMIC CATEGORY PILLS (API)
//         FutureBuilder<List<CategoryModel>>(
//           future: _futureCategories,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const SizedBox(
//                 height: 38,
//                 child: Center(
//                   child: SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2,
//                       color: primaryColor,
//                     ),
//                   ),
//                 ),
//               );
//             } else if (snapshot.hasError) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Text(
//                   "အမျိုးအစားများ ရယူ၍ မရပါ: ${snapshot.error}",
//                   style: const TextStyle(color: Colors.red, fontSize: 12),
//                 ),
//               );
//             }

//             final categories = snapshot.data ?? [];

//             return SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                   // "All" Filter Button
//                   _buildCategoryButton(
//                     title: "အားလုံး",
//                     isSelected: _selectedCategoryId == null,
//                     onTap: () {
//                       setState(() {
//                         _selectedCategoryId = null;
//                       });
//                     },
//                   ),

//                   // Dynamic API Category Buttons
//                   ...categories.map((category) {
//                     // Check ID field (supports category.id or category.categoryId)
//                     final categoryId = category.categoryId; 
//                     final isSelected = _selectedCategoryId == categoryId;

//                     return _buildCategoryButton(
//                       title: category.categoryName,
//                       isSelected: isSelected,
//                       onTap: () {
//                         setState(() {
//                           _selectedCategoryId = categoryId;
//                         });
//                       },
//                     );
//                   }),
//                 ],
//               ),
//             );
//           },
//         ),

//         const SizedBox(height: 16),

//         /// MENU GRID SECTION (FILTERED)
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: FutureBuilder<List<_DisplayMenuItem>>(
//             future: _futureMenuItems,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(32.0),
//                     child: CircularProgressIndicator(color: primaryColor),
//                   ),
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       "အချက်အလက် ရယူ၍ မရပါ: ${snapshot.error}",
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   ),
//                 );
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return const Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Text("Menu များ မရှိသေးပါ။"),
//                   ),
//                 );
//               }

//               final allMenuItems = snapshot.data!;

//               // Filter logic based on the selected category ID
//               final filteredMenuItems = _selectedCategoryId == null
//                   ? allMenuItems
//                   : allMenuItems.where((item) {
//                       return item.menu.categoryId == _selectedCategoryId;
//                     }).toList();

//               if (filteredMenuItems.isEmpty) {
//                 return const Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(24.0),
//                     child: Text("ဤအမျိုးအစားတွင် Menu များ မရှိသေးပါ။"),
//                   ),
//                 );
//               }

//               return GridView.builder(
//                 key: ValueKey(_selectedCategoryId), // Re-renders grid smoothly on selection change
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: filteredMenuItems.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 14,
//                   mainAxisSpacing: 16,
//                   childAspectRatio: 0.85,
//                 ),
//                 itemBuilder: (context, index) {
//                   final item = filteredMenuItems[index];
//                   return _PopularMenuCard(
//                     shopName: item.shopName,
//                     menu: item.menu,
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _DisplayMenuItem {
//   final String shopName;
//   final MenuModel menu;

//   _DisplayMenuItem({
//     required this.shopName,
//     required this.menu,
//   });
// }

// class _PopularMenuCard extends StatefulWidget {
//   final String shopName;
//   final MenuModel menu;

//   const _PopularMenuCard({
//     required this.shopName,
//     required this.menu,
//   });

//   @override
//   State<_PopularMenuCard> createState() => _PopularMenuCardState();
// }

// class _PopularMenuCardState extends State<_PopularMenuCard> {
//   bool isFavorite = false;
//   static const Color primaryColor = Color(0xff117992);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.04),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           /// 1. IMAGE SECTION
//           Expanded(
//             flex: 2,
//             child: Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(16),
//                   ),
//                   child: SizedBox.expand(
//                     child: Image.network(
//                       widget.menu.imageUrl,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) => Container(
//                         color: Colors.grey.shade200,
//                         child: const Icon(Icons.fastfood, color: Colors.grey),
//                       ),
//                       loadingBuilder: (context, child, loadingProgress) {
//                         if (loadingProgress == null) return child;
//                         return Container(
//                           color: Colors.grey.shade100,
//                           child: const Center(
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: primaryColor,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 6,
//                   right: 6,
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         isFavorite = !isFavorite;
//                       });
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(.9),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         isFavorite ? Icons.favorite : Icons.favorite_border,
//                         color: isFavorite ? Colors.red : Colors.grey.shade600,
//                         size: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           /// 2. TEXT / CONTENT SECTION
//           Expanded(
//             flex: 1,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.menu.itemName,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.storefront_outlined,
//                               size: 11,
//                               color: Colors.grey.shade600,
//                             ),
//                             const SizedBox(width: 2),
//                             Expanded(
//                               child: Text(
//                                 widget.shopName,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   color: Colors.grey.shade600,
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Text(
//                           "${NumberFormat('#,###').format(widget.menu.itemPrice)} ပွိုင့်",
//                           style: const TextStyle(
//                             color: primaryColor,
//                             fontSize: 11,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 4),
//                   InkWell(
//                     onTap: () {},
//                     borderRadius: BorderRadius.circular(6),
//                     child: Container(
//                       width: 25,
//                       height: 25,
//                       decoration: BoxDecoration(
//                         color: primaryColor,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: const Icon(
//                         Icons.arrow_forward_ios,
//                         color: Colors.white,
//                         size: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smartcanteen/model/category_model.dart';
import 'package:smartcanteen/model/menu_model.dart';
import 'package:smartcanteen/service/api_service.dart';
import 'package:smartcanteen/service/shared_preferences_service.dart';

class MenuSection extends StatefulWidget {
  const MenuSection({super.key});

  @override
  State<MenuSection> createState() => _MenuSectionState();
}

class _MenuSectionState extends State<MenuSection> {
  static const Color primaryColor = Color(0xff117992);
  final ApiService _apiService = ApiService();

  late Future<List<CategoryModel>> _futureCategories;
  late Future<List<_DisplayMenuItem>> _futureMenuItems;

  // Selected category ID (null indicates "All")
  int? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _futureCategories = _apiService.getCategories();
    _futureMenuItems = _fetchDisplayItems();
  }

  /// Helper to guard actions that require authentication
  static Future<void> _handleProtectedAction(
      BuildContext context, VoidCallback onAuthenticated) async {
    final currentUser = await SharedPreferencesService.getUser();
    if (context.mounted) {
      if (currentUser == null) {
        context.go('/login');
      } else {
        context.go('/shop_detail');
      }
    }
  }
Future<List<_DisplayMenuItem>> _fetchDisplayItems() async {
  try {
    final response = await _apiService.getShopsWithMenus();
    List<_DisplayMenuItem> displayItems = [];

    // Debug 1: Check response state
    print("DEBUG: API Response received. Success = ${response?.success}");

    if (response != null && response.success) {
      print("DEBUG: Total shops found = ${response.data.length}");

      for (var shop in response.data) {
        print("DEBUG: Processing Shop = '${shop.shopName}' | Menus count = ${shop.menus?.length}");

        if (shop.menus != null && shop.menus!.isNotEmpty) {
          for (var menu in shop.menus!) {
            // Debug individual menu values to catch null String field casts
            print("DEBUG: Found menu '${menu.itemName}' (ID: ${menu.menuId}, CatID: ${menu.categoryId})");
            
            displayItems.add(
              _DisplayMenuItem(
                shopName: shop.shopName ?? 'Unknown Shop',
                menu: menu,
              ),
            );
          }
        } else {
          print("DEBUG: Shop '${shop.shopName}' has no menus.");
        }
      }
    } else {
      print("DEBUG: API call failed or returned success = false");
    }

    return displayItems;
  } catch (e, stackTrace) {
    // Debug 2: Catch casting or parsing errors during model deserialization
    print("DEBUG ERROR in _fetchDisplayItems: $e");
    print("DEBUG STACKTRACE: $stackTrace");
    rethrow;
  }
}
  Widget _buildCategoryButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: isSelected ? primaryColor : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// CATEGORIES HEADER
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "အမျိုးအစားများ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {
                  _handleProtectedAction(context, () {
                    // Navigate to full menu list if logged in
                    context.push('/all_menus'); 
                  });
                },
                child: const Text(
                  "အားလုံးကြည့်ရန်",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// DYNAMIC CATEGORY PILLS (API)
        FutureBuilder<List<CategoryModel>>(
          future: _futureCategories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 38,
                child: Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: primaryColor,
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "အမျိုးအစားများ ရယူ၍ မရပါ: ${snapshot.error}",
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              );
            }

            final categories = snapshot.data ?? [];

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  // "All" Filter Button
                  _buildCategoryButton(
                    title: "အားလုံး",
                    isSelected: _selectedCategoryId == null,
                    onTap: () {
                      setState(() {
                        _selectedCategoryId = null;
                      });
                    },
                  ),

                  // Dynamic API Category Buttons
                  ...categories.map((category) {
                    final categoryId = category.categoryId;
                    final isSelected = _selectedCategoryId == categoryId;

                    return _buildCategoryButton(
                      title: category.categoryName,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          _selectedCategoryId = categoryId;
                        });
                      },
                    );
                  }),
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 16),

        /// MENU GRID SECTION (FILTERED)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder<List<_DisplayMenuItem>>(
            future: _futureMenuItems,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: CircularProgressIndicator(color: primaryColor),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "အချက်အလက် ရယူ၍ မရပါ: ${snapshot.error}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("Menu များ မရှိသေးပါ။"),
                  ),
                );
              }

              final allMenuItems = snapshot.data!;

              // Filter logic based on the selected category ID
              final filteredMenuItems = _selectedCategoryId == null
                  ? allMenuItems
                  : allMenuItems.where((item) {
                      return item.menu.categoryId == _selectedCategoryId;
                    }).toList();

              if (filteredMenuItems.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text("ဤအမျိုးအစားတွင် Menu များ မရှိသေးပါ။"),
                  ),
                );
              }

              return GridView.builder(
                key: ValueKey(_selectedCategoryId),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredMenuItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final item = filteredMenuItems[index];
                  return _PopularMenuCard(
                    shopName: item.shopName,
                    menu: item.menu,
                    onProtectedTap: () => _handleProtectedAction(
                      context,
                      () {
                        // Navigate to item details screen if logged in
                        context.push('/menu_detail', extra: item.menu);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DisplayMenuItem {
  final String shopName;
  final MenuModel menu;

  _DisplayMenuItem({
    required this.shopName,
    required this.menu,
  });
}

class _PopularMenuCard extends StatefulWidget {
  final String shopName;
  final MenuModel menu;
  final VoidCallback onProtectedTap;

  const _PopularMenuCard({
    required this.shopName,
    required this.menu,
    required this.onProtectedTap,
  });

  @override
  State<_PopularMenuCard> createState() => _PopularMenuCardState();
}

class _PopularMenuCardState extends State<_PopularMenuCard> {
  bool isFavorite = false;
  static const Color primaryColor = Color(0xff117992);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// 1. IMAGE SECTION
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: SizedBox.expand(
                    child: Image.network(
                      widget.menu.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.fastfood, color: Colors.grey),
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey.shade100,
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: primaryColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey.shade600,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 2. TEXT / CONTENT SECTION
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.menu.itemName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.storefront_outlined,
                              size: 11,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                widget.shopName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${NumberFormat('#,###').format(widget.menu.itemPrice)} ပွိုင့်",
                          style: const TextStyle(
                            color: primaryColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: widget.onProtectedTap,
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}