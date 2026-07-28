
// import 'package:flutter/material.dart';
// import 'package:smartcanteen/service/api_service.dart';
// import 'package:smartcanteen/view/add_to_cart_screen.dart';

// class ShopDetailScreen extends StatefulWidget {
//   final String shopName;
//   final int shopId;

//   const ShopDetailScreen({
//     super.key,
//     required this.shopName,
//     required this.shopId,
//   });

//   @override
//   State<ShopDetailScreen> createState() => _ShopDetailScreenState();
// }

// class _ShopDetailScreenState extends State<ShopDetailScreen> {
//   static const Color primaryColor = Color(0xff117992);
//   final ApiService _apiService = ApiService();

//   final TextEditingController _searchController = TextEditingController();
//   String searchQuery = "";

//   String? selectedSeatId;

//   String selectedMealType = "အားလုံး";
//   String selectedCategory = "အားလုံး";

//   final List<String> mealTypes = ["အားလုံး", "မနက်စာ", "နေ့လည်စာ"];
//   List<String> categories = ["အားလုံး"];

//   List<Map<String, dynamic>> menuItems = [];
//   bool isLoading = true;
//   String? errorMessage;

//   String breakfastTime = "6AM-10AM";
//   String lunchTime = "11AM-2PM";
//   bool isOpen = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchShopMenus();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchShopMenus() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });

//     try {
//       final responseData = await _apiService.getShopAllMenus(widget.shopId);

//       if (responseData != null &&
//           responseData["success"] == true &&
//           responseData["data"] != null) {
//         final data = responseData["data"];

//         // 1. Map Meal Times & Shop Open Status
//         if (data["shop"] != null) {
//           final shopData = data["shop"];
//           isOpen = (shopData["is_open"] ?? 1) == 1;
//           if (shopData["meal_times"] != null) {
//             breakfastTime =
//                 shopData["meal_times"]["breakfast"] ?? breakfastTime;
//             lunchTime = shopData["meal_times"]["lunch"] ?? lunchTime;
//           }
//         }

//         // 2. Map Categories
//         final List<String> apiCategories = ["အားလုံး"];
//         if (data["categories"] != null) {
//           for (var cat in data["categories"]) {
//             if (cat["category_name"] != null) {
//               apiCategories.add(cat["category_name"]);
//             }
//           }
//         }

//         // 3. Map Menus to State
//         final List<Map<String, dynamic>> loadedMenus = [];
//         if (data["menus"] != null) {
//           for (var menu in data["menus"]) {
//             loadedMenus.add({
//               "id": menu["menu_id"],
//               "name": menu["item_name"] ?? "",
//               "description": menu["description"] ?? "",
//               "price": "${menu["item_price"]} ပွိုင့်",
//               "rawPrice": menu["item_price"],
//               "mealType": null,
//               "category": menu["category_name"] ?? "Uncategorized",
//               "categoryId": menu["category_id"],
//               "isAvailable": menu["is_available"] ?? true,
//               "cartQuantity": 0,
//               "imageUrl": menu["image_url"],
//             });
//           }
//         }

//         setState(() {
//           categories = apiCategories;
//           menuItems = loadedMenus;
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           errorMessage = responseData?["message"] ?? "ဒေတာရယူရာတွင် အဆင်မပြေပါ";
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = e.toString();
//         isLoading = false;
//       });
//     }
//   }

//   void _addToCart(Map<String, dynamic> item) {
//     setState(() {
//       final bool isCountable = item["isCountable"] ?? false;

//       if (isCountable) {
//         if ((item["stockCount"] ?? 0) > 0) {
//           item["stockCount"] -= 1;
//           item["cartQuantity"] = (item["cartQuantity"] ?? 0) + 1;
//         }
//       } else {
//         item["cartQuantity"] = (item["cartQuantity"] ?? 0) + 1;
//       }
//     });
//   }

//   void _removeFromCart(Map<String, dynamic> item) {
//     setState(() {
//       final bool isCountable = item["isCountable"] ?? false;

//       if ((item["cartQuantity"] ?? 0) > 0) {
//         if (isCountable) {
//           item["stockCount"] = (item["stockCount"] ?? 0) + 1;
//         }
//         item["cartQuantity"] -= 1;
//       }
//     });
//   }

//   void _resetOrder() {
//     setState(() {
//       for (var item in menuItems) {
//         item["cartQuantity"] = 0;
//       }
//     });
//   }

//   int get totalCartCount {
//     return menuItems.fold(
//       0,
//       (sum, item) => sum + ((item["cartQuantity"] as int?) ?? 0),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filteredItems = menuItems.where((item) {
//       final matchesMeal =
//           selectedMealType == "အားလုံး" || item["mealType"] == selectedMealType;
//       final matchesCategory =
//           selectedCategory == "အားလုံး" || item["category"] == selectedCategory;
//       final matchesSearch = searchQuery.isEmpty ||
//           (item["name"] as String)
//               .toLowerCase()
//               .contains(searchQuery.toLowerCase());
//       return matchesMeal && matchesCategory && matchesSearch;
//     }).toList();

//     return Scaffold(
//       backgroundColor: const Color(0xffF6F8FC),
//       floatingActionButton: (totalCartCount > 0)
//           ? FloatingActionButton.extended(
//               onPressed: () {
//                 showModalBottomSheet(
//                   context: context,
//                   isScrollControlled: true,
//                   backgroundColor: Colors.transparent,
//                   builder: (context) => AddToCartScreen(
//                     shopName: widget.shopName,
//                     selectedSeatId: selectedSeatId,
//                     menuItems: menuItems,
//                     onAddToCart: _addToCart,
//                     onRemoveFromCart: _removeFromCart,
//                     onConfirmOrder: _resetOrder,
//                   ),
//                 );
//               },
//               backgroundColor: primaryColor,
//               elevation: 4,
//               icon: Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   const Icon(Icons.shopping_bag_outlined, color: Colors.white),
//                   Positioned(
//                     right: -6,
//                     top: -6,
//                     child: Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: const BoxDecoration(
//                         color: Colors.redAccent,
//                         shape: BoxShape.circle,
//                       ),
//                       constraints: const BoxConstraints(
//                         minWidth: 16,
//                         minHeight: 16,
//                       ),
//                       child: Text(
//                         '$totalCartCount',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               label: const Text(
//                 "ဈေးဝယ်ခြင်း",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             )
//           : null,
//       body: CustomScrollView(
//         physics: const BouncingScrollPhysics(),
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 110,
//             pinned: true,
//             backgroundColor: primaryColor,
//             elevation: 0,
//             automaticallyImplyLeading: false,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Color(0xff117992), Color(0xff0D5B6E)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: SafeArea(
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(8, 20, 20, 16),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             IconButton(
//                               icon: const Icon(
//                                 Icons.arrow_back_ios_new_rounded,
//                                 color: Colors.white,
//                                 size: 20,
//                               ),
//                               onPressed: () => Navigator.pop(context),
//                             ),
//                             const SizedBox(width: 4),
//                             Container(
//                               width: 52,
//                               height: 52,
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.15),
//                                 borderRadius: BorderRadius.circular(14),
//                               ),
//                               child: const Icon(
//                                 Icons.storefront_rounded,
//                                 color: Colors.white,
//                                 size: 30,
//                               ),
//                             ),
//                             const SizedBox(width: 14),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     widget.shopName,
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         Icons.circle,
//                                         color: isOpen
//                                             ? const Color(0xff34D399)
//                                             : Colors.redAccent,
//                                         size: 8,
//                                       ),
//                                       const SizedBox(width: 4),
//                                       Text(
//                                         isOpen ? "ဆိုင်ဖွင့်သည်" : "ဆိုင်ပိတ်သည်",
//                                         style: TextStyle(
//                                           color: isOpen
//                                               ? const Color(0xff34D399)
//                                               : Colors.redAccent,
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Container(
//               margin: const EdgeInsets.fromLTRB(20, 16, 20, 8),
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(14),
//                 border: Border.all(color: Colors.grey.shade200),
//               ),
//               child: Row(
//                 children: [
//                   const Icon(
//                     Icons.access_time_filled_rounded,
//                     color: primaryColor,
//                     size: 18,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     "မနက်စာ: $breakfastTime",
//                     style: TextStyle(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.grey.shade700,
//                     ),
//                   ),
//                   const Spacer(),
//                   Container(width: 1, height: 12, color: Colors.grey.shade300),
//                   const Spacer(),
//                   const Icon(
//                     Icons.lunch_dining_rounded,
//                     color: Colors.orange,
//                     size: 18,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     "နေ့လည်စာ: $lunchTime",
//                     style: TextStyle(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.grey.shade700,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//               child: Container(
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: Colors.grey.shade200),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.02),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: TextField(
//                   controller: _searchController,
//                   onChanged: (value) {
//                     setState(() {
//                       searchQuery = value;
//                     });
//                   },
//                   style: const TextStyle(fontSize: 14),
//                   decoration: InputDecoration(
//                     hintText: "ရှာဖွေပါ...",
//                     hintStyle:
//                         TextStyle(color: Colors.grey.shade400, fontSize: 14),
//                     prefixIcon:
//                         const Icon(Icons.search_rounded, color: Colors.grey),
//                     border: InputBorder.none,
//                     suffixIcon: searchQuery.isNotEmpty
//                         ? IconButton(
//                             icon: const Icon(Icons.clear_rounded,
//                                 color: Colors.grey, size: 20),
//                             onPressed: () {
//                               _searchController.clear();
//                               setState(() {
//                                 searchQuery = "";
//                               });
//                             },
//                           )
//                         : null,
//                     contentPadding: const EdgeInsets.symmetric(vertical: 12),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
//               child: Container(
//                 padding: const EdgeInsets.all(4),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 child: Row(
//                   children: mealTypes.map((type) {
//                     final isSelected = selectedMealType == type;

//                     return Expanded(
//                       child: GestureDetector(
//                         onTap: () => setState(() => selectedMealType = type),
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 200),
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                           decoration: BoxDecoration(
//                             color: isSelected
//                                 ? Colors.white
//                                 : Colors.transparent,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: isSelected
//                                 ? [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.05),
//                                       blurRadius: 4,
//                                     ),
//                                   ]
//                                 : null,
//                           ),
//                           child: Center(
//                             child: Text(
//                               type,
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: isSelected
//                                     ? FontWeight.bold
//                                     : FontWeight.w500,
//                                 color: isSelected
//                                     ? primaryColor
//                                     : Colors.grey.shade600,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 4,
//                   ),
//                   child: Text(
//                     "အမျိုးအစားများ",
//                     style: TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey.shade600,
//                       letterSpacing: 0.2,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 SizedBox(
//                   height: 42,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     physics: const BouncingScrollPhysics(),
//                     itemCount: categories.length,
//                     itemBuilder: (context, index) {
//                       final category = categories[index];
//                       final isSelected = selectedCategory == category;

//                       return GestureDetector(
//                         onTap: () =>
//                             setState(() => selectedCategory = category),
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 200),
//                           margin: const EdgeInsets.only(right: 10),
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 18,
//                             vertical: 8,
//                           ),
//                           decoration: BoxDecoration(
//                             color: isSelected ? primaryColor : Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(
//                               color: isSelected
//                                   ? primaryColor
//                                   : Colors.grey.shade200,
//                               width: 1,
//                             ),
//                             boxShadow: isSelected
//                                 ? [
//                                     BoxShadow(
//                                       color: primaryColor.withOpacity(0.25),
//                                       blurRadius: 8,
//                                       offset: const Offset(0, 3),
//                                     ),
//                                   ]
//                                 : [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.02),
//                                       blurRadius: 4,
//                                     ),
//                                   ],
//                           ),
//                           child: Center(
//                             child: Text(
//                               category,
//                               style: TextStyle(
//                                 color: isSelected
//                                     ? Colors.white
//                                     : Colors.grey.shade700,
//                                 fontWeight: isSelected
//                                     ? FontWeight.bold
//                                     : FontWeight.w600,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SliverToBoxAdapter(child: SizedBox(height: 16)),
//           if (isLoading)
//             const SliverFillRemaining(
//               child: Center(
//                 child: CircularProgressIndicator(color: primaryColor),
//               ),
//             )
//           else if (errorMessage != null)
//             SliverFillRemaining(
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.error_outline_rounded,
//                         color: Colors.red.shade300, size: 48),
//                     const SizedBox(height: 12),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 24),
//                       child: Text(
//                         errorMessage!,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.grey.shade600),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     ElevatedButton(
//                       onPressed: _fetchShopMenus,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: primaryColor,
//                       ),
//                       child: const Text("ထပ်မံကြိုးစားမည်",
//                           style: TextStyle(color: Colors.white)),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           else if (filteredItems.isEmpty)
//             SliverFillRemaining(
//               child: Center(
//                 child: Text(
//                   "မည်သည့် Menu မှ မရှိပါ",
//                   style: TextStyle(color: Colors.grey.shade500),
//                 ),
//               ),
//             )
//           else
//             SliverList(
//               delegate: SliverChildBuilderDelegate((context, index) {
//                 final item = filteredItems[index];
//                 final bool isAvailable = item["isAvailable"] ?? true;
//                 final String? mealType = item["mealType"];

//                 return Container(
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(18),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.03),
//                         blurRadius: 10,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(14),
//                         child: Container(
//                           width: 82,
//                           height: 82,
//                           color: Colors.grey.shade100,
//                           child: item["imageUrl"] != null &&
//                                   (item["imageUrl"] as String).isNotEmpty
//                               ? Image.network(
//                                   item["imageUrl"],
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) =>
//                                       Center(
//                                     child: Icon(
//                                       Icons.fastfood_rounded,
//                                       color: Colors.grey.shade400,
//                                       size: 30,
//                                     ),
//                                   ),
//                                 )
//                               : Center(
//                                   child: Icon(
//                                     Icons.fastfood_rounded,
//                                     color: Colors.grey.shade400,
//                                     size: 30,
//                                   ),
//                                 ),
//                         ),
//                       ),
//                       const SizedBox(width: 14),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               item["name"],
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: isAvailable
//                                     ? const Color(0xff1E293B)
//                                     : Colors.grey.shade400,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               item["description"],
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 color: Colors.grey.shade500,
//                                 fontSize: 11,
//                                 height: 1.3,
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 Text(
//                                   item["price"],
//                                   style: TextStyle(
//                                     color: isAvailable
//                                         ? primaryColor
//                                         : Colors.grey,
//                                     fontWeight: FontWeight.w800,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 if (mealType != null)
//                                   Container(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 7,
//                                       vertical: 2,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: mealType == "မနက်စာ"
//                                           ? const Color(0xffFEF3C7)
//                                           : const Color(0xffFFEDD5),
//                                       borderRadius: BorderRadius.circular(6),
//                                     ),
//                                     child: Text(
//                                       mealType,
//                                       style: TextStyle(
//                                         color: mealType == "မနက်စာ"
//                                             ? const Color(0xffD97706)
//                                             : const Color(0xffEA580C),
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 10,
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: SizedBox(
//                           height: 36,
//                           child: ElevatedButton(
//                             onPressed:
//                                 isAvailable ? () => _addToCart(item) : null,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: isAvailable
//                                   ? primaryColor
//                                   : Colors.grey.shade100,
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 14),
//                             ),
//                             child: Text(
//                               isAvailable ? "+ ဝယ်ရန်" : "ကုန်သွားပြီ",
//                               style: TextStyle(
//                                 color: isAvailable
//                                     ? Colors.white
//                                     : Colors.grey.shade400,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }, childCount: filteredItems.length),
//             ),
//           const SliverToBoxAdapter(child: SizedBox(height: 100)),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:smartcanteen/service/api_service.dart';
import 'package:smartcanteen/view/add_to_cart_screen.dart';

class ShopDetailScreen extends StatefulWidget {
  final String shopName;
  final int shopId;

  const ShopDetailScreen({
    super.key,
    required this.shopName,
    required this.shopId,
  });

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  static const Color primaryColor = Color(0xff117992);
  final ApiService _apiService = ApiService();

  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  String? selectedSeatId;

  String selectedMealType = "အားလုံး";
  String selectedCategory = "အားလုံး";

  final List<String> mealTypes = ["အားလုံး", "မနက်စာ", "နေ့လည်စာ"];
  List<String> categories = ["အားလုံး"];

  List<Map<String, dynamic>> menuItems = [];
  bool isLoading = true;
  String? errorMessage;

  String breakfastTime = "6AM-10AM";
  String lunchTime = "11AM-2PM";
  bool isOpen = true;

  @override
  void initState() {
    super.initState();
    _fetchShopMenus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchShopMenus() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final responseData = await _apiService.getShopAllMenus(widget.shopId);

      if (responseData != null &&
          responseData["success"] == true &&
          responseData["data"] != null) {
        final data = responseData["data"];

        // 1. Map Meal Times & Shop Open Status
        if (data["shop"] != null) {
          final shopData = data["shop"];
          isOpen = (shopData["is_open"] ?? 1) == 1;
          if (shopData["meal_times"] != null) {
            breakfastTime =
                shopData["meal_times"]["breakfast"] ?? breakfastTime;
            lunchTime = shopData["meal_times"]["lunch"] ?? lunchTime;
          }
        }

        // 2. Map Categories
        final List<String> apiCategories = ["အားလုံး"];
        if (data["categories"] != null) {
          for (var cat in data["categories"]) {
            if (cat["category_name"] != null) {
              apiCategories.add(cat["category_name"]);
            }
          }
        }

        // 3. Map Menus to State
        final List<Map<String, dynamic>> loadedMenus = [];
        if (data["menus"] != null) {
          for (var menu in data["menus"]) {
            loadedMenus.add({
              "id": menu["menu_id"],
              "name": menu["item_name"] ?? "",
              "description": menu["description"] ?? "",
              "price": "${menu["item_price"]} ပွိုင့်",
              "rawPrice": menu["item_price"],
              "mealType": null,
              "category": menu["category_name"] ?? "Uncategorized",
              "categoryId": menu["category_id"],
              "isAvailable": menu["is_available"] ?? true,
              "cartQuantity": 0,
              "imageUrl": menu["image_url"],
            });
          }
        }

        setState(() {
          categories = apiCategories;
          menuItems = loadedMenus;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = responseData?["message"] ?? "ဒေတာရယူရာတွင် အဆင်မပြေပါ";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  void _addToCart(Map<String, dynamic> item) {
    setState(() {
      final bool isCountable = item["isCountable"] ?? false;

      if (isCountable) {
        if ((item["stockCount"] ?? 0) > 0) {
          item["stockCount"] -= 1;
          item["cartQuantity"] = (item["cartQuantity"] ?? 0) + 1;
        }
      } else {
        item["cartQuantity"] = (item["cartQuantity"] ?? 0) + 1;
      }
    });
  }

  void _removeFromCart(Map<String, dynamic> item) {
    setState(() {
      final bool isCountable = item["isCountable"] ?? false;

      if ((item["cartQuantity"] ?? 0) > 0) {
        if (isCountable) {
          item["stockCount"] = (item["stockCount"] ?? 0) + 1;
        }
        item["cartQuantity"] -= 1;
      }
    });
  }

  void _resetOrder() {
    setState(() {
      for (var item in menuItems) {
        item["cartQuantity"] = 0;
      }
    });
  }

  int get totalCartCount {
    return menuItems.fold(
      0,
      (sum, item) => sum + ((item["cartQuantity"] as int?) ?? 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = menuItems.where((item) {
      final matchesMeal =
          selectedMealType == "အားလုံး" || item["mealType"] == selectedMealType;
      final matchesCategory =
          selectedCategory == "အားလုံး" || item["category"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          (item["name"] as String)
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
      return matchesMeal && matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),
      floatingActionButton: (totalCartCount > 0)
          ? FloatingActionButton.extended(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => AddToCartScreen(
                    shopName: widget.shopName,
                    menuItems: menuItems,
                    onAddToCart: _addToCart,
                    onRemoveFromCart: _removeFromCart,
                    onConfirmOrder: _resetOrder,
                  ),
                );
              },
              backgroundColor: primaryColor,
              elevation: 4,
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                  Positioned(
                    right: -6,
                    top: -6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '$totalCartCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              label: const Text(
                "ဈေးဝယ်ခြင်း",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 110,
            pinned: true,
            backgroundColor: primaryColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff117992), Color(0xff0D5B6E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 20, 20, 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.storefront_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.shopName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: isOpen
                                            ? const Color(0xff34D399)
                                            : Colors.redAccent,
                                        size: 8,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        isOpen ? "ဆိုင်ဖွင့်သည်" : "ဆိုင်ပိတ်သည်",
                                        style: TextStyle(
                                          color: isOpen
                                              ? const Color(0xff34D399)
                                              : Colors.redAccent,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time_filled_rounded,
                    color: primaryColor,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "မနက်စာ: $breakfastTime",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const Spacer(),
                  Container(width: 1, height: 12, color: Colors.grey.shade300),
                  const Spacer(),
                  const Icon(
                    Icons.lunch_dining_rounded,
                    color: Colors.orange,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "နေ့လည်စာ: $lunchTime",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: "ရှာဖွေပါ...",
                    hintStyle:
                        TextStyle(color: Colors.grey.shade400, fontSize: 14),
                    prefixIcon:
                        const Icon(Icons.search_rounded, color: Colors.grey),
                    border: InputBorder.none,
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded,
                                color: Colors.grey, size: 20),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                searchQuery = "";
                              });
                            },
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: mealTypes.map((type) {
                    final isSelected = selectedMealType == type;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedMealType = type),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 4,
                                    ),
                                  ]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              type,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: isSelected
                                    ? primaryColor
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 4,
                  ),
                  child: Text(
                    "အမျိုးအစားများ",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 42,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategory == category;

                      return GestureDetector(
                        onTap: () =>
                            setState(() => selectedCategory = category),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? primaryColor
                                  : Colors.grey.shade200,
                              width: 1,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.25),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.02),
                                      blurRadius: 4,
                                    ),
                                  ],
                          ),
                          child: Center(
                            child: Text(
                              category,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey.shade700,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          if (isLoading)
            const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: primaryColor),
              ),
            )
          else if (errorMessage != null)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline_rounded,
                        color: Colors.red.shade300, size: 48),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        errorMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _fetchShopMenus,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      child: const Text("ထပ်မံကြိုးစားမည်",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            )
          else if (filteredItems.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Text(
                  "မည်သည့် Menu မှ မရှိပါ",
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = filteredItems[index];
                final bool isAvailable = item["isAvailable"] ?? true;
                final String? mealType = item["mealType"];
                final int qty = (item["cartQuantity"] as int?) ?? 0;

                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 82,
                          height: 82,
                          color: Colors.grey.shade100,
                          child: item["imageUrl"] != null &&
                                  (item["imageUrl"] as String).isNotEmpty
                              ? Image.network(
                                  item["imageUrl"],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Center(
                                    child: Icon(
                                      Icons.fastfood_rounded,
                                      color: Colors.grey.shade400,
                                      size: 30,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Icon(
                                    Icons.fastfood_rounded,
                                    color: Colors.grey.shade400,
                                    size: 30,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["name"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isAvailable
                                    ? const Color(0xff1E293B)
                                    : Colors.grey.shade400,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item["description"],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 11,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  item["price"],
                                  style: TextStyle(
                                    color: isAvailable
                                        ? primaryColor
                                        : Colors.grey,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                if (mealType != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: mealType == "မနက်စာ"
                                          ? const Color(0xffFEF3C7)
                                          : const Color(0xffFFEDD5),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      mealType,
                                      style: TextStyle(
                                        color: mealType == "မနက်စာ"
                                            ? const Color(0xffD97706)
                                            : const Color(0xffEA580C),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: !isAvailable
                            ? SizedBox(
                                height: 36,
                                child: ElevatedButton(
                                  onPressed: null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade100,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14),
                                  ),
                                  child: Text(
                                    "ကုန်သွားပြီ",
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              )
                            : qty == 0
                                ? SizedBox(
                                    height: 36,
                                    child: ElevatedButton(
                                      onPressed: () => _addToCart(item),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14),
                                      ),
                                      child: const Text(
                                        "+ ဝယ်ရန်",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(
                                            minWidth: 28,
                                          ),
                                          icon: const Icon(
                                            Icons.remove,
                                            size: 14,
                                            color: Colors.redAccent,
                                          ),
                                          onPressed: () => _removeFromCart(item),
                                        ),
                                        Text(
                                          '$qty',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(
                                            minWidth: 28,
                                          ),
                                          icon: const Icon(
                                            Icons.add,
                                            size: 14,
                                            color: primaryColor,
                                          ),
                                          onPressed: () => _addToCart(item),
                                        ),
                                      ],
                                    ),
                                  ),
                      ),
                    ],
                  ),
                );
              }, childCount: filteredItems.length),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}