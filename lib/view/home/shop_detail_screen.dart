import 'package:flutter/material.dart';
import 'widgets/cart_receipt_sheet.dart';

class ShopDetailScreen extends StatefulWidget {
  final String shopName;

  const ShopDetailScreen({super.key, required this.shopName});

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  static const Color primaryColor = Color(0xff117992);

  String selectedMealType = "All";
  String selectedCategory = "All";

  // Seat Reservation State
  String? selectedSeatId;
  bool isSeatSectionExpanded = true;

  final List<String> mealTypes = ["All", "Breakfast", "Lunch"];
  final List<String> categories = [
    "All",
    "Main",
    "Appetizer",
    "Salad",
    "Drinks",
    "Snacks",
  ];

  // ===========================================================================
  // DYNAMIC SHOP SEATING CONFIGURATION
  // ===========================================================================
  String seatLayoutType = "grid"; // Options: "grid" or "canvas"

  // UPDATED: Set crossAxisCount to 4 for 4x4 layout
  int gridCrossAxisCount = 4;

  // Canvas Configuration
  double canvasWidth = 350;
  double canvasHeight = 270;

  // Dynamic Seats Data (Configured for 4x4 Grid and Canvas)
  final List<Map<String, dynamic>> seats = [
    // Row 1
    {
      "id": "T1",
      "label": "Table 1",
      "status": "disabled",
      "x": 10.0,
      "y": 10.0,
      "width": 70.0,
      "height": 55.0,
    },
    {
      "id": "T2",
      "label": "Table 2",
      "status": "available",
      "x": 90.0,
      "y": 10.0,
      "width": 70.0,
      "height": 55.0,
    },
    {
      "id": "T3",
      "label": "Table 3",
      "status": "available",
      "x": 170.0,
      "y": 10.0,
      "width": 70.0,
      "height": 55.0,
    },
    {
      "id": "T4",
      "label": "Table 4",
      "status": "available",
      "x": 250.0,
      "y": 10.0,
      "width": 70.0,
      "height": 55.0,
    },

    // Row 2
    {
      "id": "T5",
      "label": "Table 5",
      "status": "available",
      "x": 10.0,
      "y": 75.0,
      "width": 70.0,
      "height": 55.0,
    },
    {
      "id": "T6",
      "label": "Table 6",
      "status": "available",
      "x": 90.0,
      "y": 75.0,
      "width": 70.0,
      "height": 55.0,
    },
    {
      "id": "T7",
      "label": "Table 7",
      "status": "occupied",
      "x": 170.0,
      "y": 75.0,
      "width": 70.0,
      "height": 55.0,
    },
    {
      "id": "T8",
      "label": "Table 8",
      "status": "occupied",
      "x": 250.0,
      "y": 75.0,
      "width": 70.0,
      "height": 55.0,
    },

    // Row 3
    {
      "id": "T9",
      "label": "Table 9",
      "status": "available",
      "x": 10.0,
      "y": 140.0,
      "width": 70.0,
      "height": 55.0,
    },
    {
      "id": "T10",
      "label": "Table 10",
      "status": "reserved",
      "x": 90.0,
      "y": 140.0,
      "width": 70.0,
      "height": 55.0,
    },
    {
      "id": "T11",
      "label": "Table 11",
      "status": "reserved",
      "x": 170.0,
      "y": 140.0,
      "width": 70.0,
      "height": 55.0,
    },
    {
      "id": "T12",
      "label": "Table 12",
      "status": "available",
      "x": 250.0,
      "y": 140.0,
      "width": 70.0,
      "height": 55.0,
    },

    // Row 4
    {
      "id": "T13",
      "label": "Table 13",
      "status": "available",
      "x": 10.0,
      "y": 205.0,
      "width": 70.0,
      "height": 55.0,
    },
    {
      "id": "T14",
      "label": "Table 14",
      "status": "available",
      "x": 90.0,
      "y": 205.0,
      "width": 70.0,
      "height": 55.0,
    },
    {
      "id": "T15",
      "label": "Table 15",
      "status": "available",
      "x": 170.0,
      "y": 205.0,
      "width": 70.0,
      "height": 55.0,
    },
    {
      "id": "T16",
      "label": "Table 16",
      "status": "available",
      "x": 250.0,
      "y": 205.0,
      "width": 70.0,
      "height": 55.0,
    },
  ];

  // Menu items list
  final List<Map<String, dynamic>> menuItems = [
    {
      "name": "Mohinga",
      "description":
          "Classic Burmese fish noodle soup served with crispy fritters and cooked egg",
      "price": "250 pts",
      "mealType": "Breakfast",
      "category": "Main",
      "isCountable": false,
      "cartQuantity": 0,
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "name": "Shan Noodle",
      "description":
          "Sticky rice noodles tossed with savory chicken tomato gravy",
      "price": "300 pts",
      "mealType": "Breakfast",
      "category": "Main",
      "isCountable": false,
      "cartQuantity": 0,
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "name": "Canned Green Tea",
      "description": "Refreshing cold green tea in a can",
      "price": "150 pts",
      "mealType": null,
      "category": "Drinks",
      "isCountable": true,
      "stockCount": 10,
      "cartQuantity": 0,
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "name": "Canned Cola",
      "description": "Chilled canned soda",
      "price": "150 pts",
      "mealType": null,
      "category": "Drinks",
      "isCountable": true,
      "stockCount": 8,
      "cartQuantity": 0,
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "name": "Potato Chips",
      "description": "Crispy salted potato chips pack",
      "price": "120 pts",
      "mealType": null,
      "category": "Snacks",
      "isCountable": true,
      "stockCount": 15,
      "cartQuantity": 0,
      "imageUrl": "https://via.placeholder.com/150",
    },
  ];

  void _addToCart(Map<String, dynamic> item) {
    setState(() {
      final bool isCountable = item["isCountable"] ?? false;

      if (isCountable) {
        if (item["stockCount"] > 0) {
          item["stockCount"] -= 1;
          item["cartQuantity"] += 1;
        }
      } else {
        item["cartQuantity"] += 1;
      }
    });
  }

  void _removeFromCart(Map<String, dynamic> item) {
    setState(() {
      final bool isCountable = item["isCountable"] ?? false;

      if (item["cartQuantity"] > 0) {
        if (isCountable) {
          item["stockCount"] += 1;
        }
        item["cartQuantity"] -= 1;
      }
    });
  }

  void _resetOrder() {
    setState(() {
      // 1. Reset seat selection
      selectedSeatId = null;

      // 2. Reset cart quantity for all items
      for (var item in menuItems) {
        item["cartQuantity"] = 0;
      }
    });
  }

  int get totalCartCount {
    return menuItems.fold(
      0,
      (sum, item) => sum + (item["cartQuantity"] as int),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = menuItems.where((item) {
      final matchesMeal =
          selectedMealType == "All" || item["mealType"] == selectedMealType;
      final matchesCategory =
          selectedCategory == "All" || item["category"] == selectedCategory;
      return matchesMeal && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),

      /// BOTTOM RIGHT FLOATING CART & SEAT SUMMARY BUTTON
      floatingActionButton: (totalCartCount > 0 || selectedSeatId != null)
          ? FloatingActionButton.extended(
              onPressed: () {
                // SHOW THE CART RECEIPT SHEET
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => CartReceiptSheet(
                    shopName: widget.shopName,
                    selectedSeatId: selectedSeatId,
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
                  if (totalCartCount > 0)
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
              label: Text(
                selectedSeatId != null
                    ? "Seat: $selectedSeatId | Cart ($totalCartCount)"
                    : "View Cart ($totalCartCount)",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,

      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// APP BAR
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: primaryColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
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
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
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
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        "4.8",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Icon(
                                        Icons.circle,
                                        color: Color(0xff34D399),
                                        size: 8,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Open Now",
                                        style: TextStyle(
                                          color: Color(0xff34D399),
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

          /// MEAL SCHEDULE NOTICE
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
                    "Breakfast: 6AM-10AM",
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
                    "Lunch: 11AM-2PM",
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

          /// SEAT RESERVATION CARD
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  /// SECTION HEADER
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSeatSectionExpanded = !isSeatSectionExpanded;
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.event_seat_rounded,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Dine-in Seat Reservation",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xff1E293B),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  selectedSeatId != null
                                      ? "Selected Seat: $selectedSeatId"
                                      : "Tap to select a seat to dine-in",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: selectedSeatId != null
                                        ? primaryColor
                                        : Colors.grey.shade500,
                                    fontWeight: selectedSeatId != null
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            isSeatSectionExpanded
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (isSeatSectionExpanded) ...[
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          /// COUNTER INDICATOR
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.point_of_sale_rounded,
                                  size: 16,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "COUNTER",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// LAYOUT RENDERER
                          if (seats.isEmpty)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "No seats available for this shop.",
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          else if (seatLayoutType == "canvas")
                            _buildCanvasLayout()
                          else
                            _buildFlexibleGridLayout(),

                          const SizedBox(height: 16),

                          /// LEGEND ROW
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildLegendItem(
                                color: const Color(0xff34D399),
                                label: "Available",
                              ),
                              _buildLegendItem(
                                color: const Color(0xffF87171),
                                label: "Occupied",
                              ),
                              _buildLegendItem(
                                color: const Color(0xffFBBF24),
                                label: "Reserved",
                              ),
                              _buildLegendItem(
                                color: Colors.grey.shade400,
                                label: "Disabled",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          /// MEAL TYPE SEGMENT FILTER
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
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

          /// CATEGORY FILTER
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
                    "Categories",
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

          /// MENU ITEM LIST
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = filteredItems[index];
              final bool isCountable = item["isCountable"] ?? false;
              final int stockCount = item["stockCount"] ?? 0;
              final int cartQuantity = item["cartQuantity"] ?? 0;
              final String? mealType = item["mealType"];

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
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
                    /// ITEM IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: 82,
                        height: 82,
                        color: Colors.grey.shade100,
                        child: item["imageUrl"] != null
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

                    /// ITEM DETAILS
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["name"],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff1E293B),
                            ),
                          ),

                          if (isCountable) ...[
                            const SizedBox(height: 2),
                            Text(
                              stockCount > 0
                                  ? "Stock left: $stockCount"
                                  : "Out of stock",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: stockCount > 3
                                    ? Colors.grey.shade600
                                    : (stockCount > 0
                                          ? Colors.orange.shade800
                                          : Colors.red.shade400),
                              ),
                            ),
                          ],

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

                          /// PRICE & BADGE
                          Row(
                            children: [
                              Text(
                                item["price"],
                                style: const TextStyle(
                                  color: primaryColor,
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
                                    color: mealType == "Breakfast"
                                        ? const Color(0xffFEF3C7)
                                        : const Color(0xffFFEDD5),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    mealType,
                                    style: TextStyle(
                                      color: mealType == "Breakfast"
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

                    /// ACTION BUTTON CONTROLS
                    Align(
                      alignment: Alignment.centerRight,
                      child: isCountable && stockCount == 0 && cartQuantity == 0
                          ? Container(
                              height: 36,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Sold Out",
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                          : cartQuantity == 0
                          ? SizedBox(
                              height: 36,
                              child: ElevatedButton(
                                onPressed: () => _addToCart(item),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  ),
                                ),
                                child: const Text(
                                  "+ Add",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              height: 36,
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: primaryColor),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(
                                      minWidth: 32,
                                    ),
                                    icon: const Icon(
                                      Icons.remove,
                                      size: 16,
                                      color: primaryColor,
                                    ),
                                    onPressed: () => _removeFromCart(item),
                                  ),
                                  Text(
                                    '$cartQuantity',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: primaryColor,
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(
                                      minWidth: 32,
                                    ),
                                    icon: Icon(
                                      Icons.add,
                                      size: 16,
                                      color: (!isCountable || stockCount > 0)
                                          ? primaryColor
                                          : Colors.grey,
                                    ),
                                    onPressed: (!isCountable || stockCount > 0)
                                        ? () => _addToCart(item)
                                        : null,
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

  // ===========================================================================
  // SEAT LAYOUT BUILDERS
  // ===========================================================================

  /// BUILDER 1: Flexible Grid
  Widget _buildFlexibleGridLayout() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: seats.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCrossAxisCount > 0 ? gridCrossAxisCount : 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        final seat = seats[index];
        final String seatId = seat["id"];
        final String label = seat["label"] ?? seatId;
        final String status = seat["status"];
        final bool isSelected = selectedSeatId == seatId;

        return _buildSeatCard(
          seatId: seatId,
          displayLabel: label,
          status: status,
          isSelected: isSelected,
          onTap: () {
            if (status == "available") {
              setState(() {
                selectedSeatId = isSelected ? null : seatId;
              });
            }
          },
        );
      },
    );
  }

  /// BUILDER 2: Canvas Floor Plan
  Widget _buildCanvasLayout() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: canvasWidth,
        height: canvasHeight,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Stack(
          children: seats.map<Widget>((seat) {
            final String seatId = seat["id"];
            final String label = seat["label"] ?? seatId;
            final double x = (seat["x"] as num? ?? 0).toDouble();
            final double y = (seat["y"] as num? ?? 0).toDouble();
            final double w = (seat["width"] as num? ?? 60).toDouble();
            final double h = (seat["height"] as num? ?? 60).toDouble();
            final String status = seat["status"];
            final bool isSelected = selectedSeatId == seatId;

            return Positioned(
              left: x,
              top: y,
              width: w,
              height: h,
              child: _buildSeatCard(
                seatId: seatId,
                displayLabel: label,
                status: status,
                isSelected: isSelected,
                onTap: () {
                  if (status == "available") {
                    setState(() {
                      selectedSeatId = isSelected ? null : seatId;
                    });
                  }
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// HELPER WIDGET FOR SEAT CARD
  Widget _buildSeatCard({
    required String seatId,
    required String displayLabel,
    required String status,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    Color bgColor;
    Color iconColor;
    Color textColor;
    IconData iconData;

    if (isSelected) {
      bgColor = primaryColor;
      iconColor = Colors.white;
      textColor = Colors.white;
      iconData = Icons.check_circle_rounded;
    } else {
      switch (status) {
        case "occupied":
          bgColor = const Color(0xffFEE2E2);
          iconColor = const Color(0xffEF4444);
          textColor = const Color(0xff1E293B);
          iconData = Icons.people_alt_rounded;
          break;
        case "reserved":
          bgColor = const Color(0xffFEF3C7);
          iconColor = const Color(0xffF59E0B);
          textColor = const Color(0xff1E293B);
          iconData = Icons.access_time_filled_rounded;
          break;
        case "disabled":
          bgColor = Colors.grey.shade100;
          iconColor = Colors.grey.shade400;
          textColor = Colors.grey.shade400;
          iconData = Icons.block_rounded;
          break;
        case "available":
        default:
          bgColor = Colors.grey.shade50;
          iconColor = const Color(0xff10B981);
          textColor = const Color(0xff1E293B);
          iconData = Icons.chair_alt_rounded;
          break;
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? primaryColor
                : (status == "available"
                      ? Colors.grey.shade200
                      : Colors.transparent),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 18, color: iconColor),
            const SizedBox(height: 2),
            Text(
              displayLabel,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// HELPER WIDGET FOR LEGEND ITEM
  Widget _buildLegendItem({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
