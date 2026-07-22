import 'package:flutter/material.dart';

class ShopDetailScreen extends StatefulWidget {
  final String shopName;

  const ShopDetailScreen({super.key, required this.shopName});

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  static const Color primaryColor = Color(0xff117992);

  // Meal Segment: (All, Breakfast, Lunch)
  String selectedMealType = "All";
  String selectedCategory = "All";

  final List<String> mealTypes = ["All", "Breakfast", "Lunch"];
  final List<String> categories = [
    "All",
    "Main",
    "Appetizer",
    "Salad",
    "Drinks",
  ];

  final List<Map<String, dynamic>> menuItems = [
    {
      "name": "Mohinga",
      "description":
          "Classic Burmese fish noodle soup served with crispy fritters and cooked egg",
      "price": "250 pts",
      "mealType": "Breakfast",
      "category": "Main",
      "isAvailable": true,
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "name": "Shan Noodle",
      "description":
          "Sticky rice noodles tossed with savory chicken tomato gravy",
      "price": "300 pts",
      "mealType": "Breakfast",
      "category": "Main",
      "isAvailable": true,
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "name": "Fried Rice & Egg",
      "description": "Yangon style fried rice served with sunny side up egg",
      "price": "350 pts",
      "mealType": "Lunch",
      "category": "Main",
      "isAvailable": true,
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "name": "Iced Lemon Tea",
      "description": "Refreshing home-brewed iced lemon tea",
      "price": "150 pts",
      "mealType": null, // No meal badge
      "category": "Drinks",
      "isAvailable": true,
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "name": "Tea Leaf Salad",
      "description": "Fermented tea leaf salad mixed with crunchy roasted nuts",
      "price": "200 pts",
      "mealType": "Lunch",
      "category": "Salad",
      "isAvailable": false, // Sold Out
      "imageUrl": "https://via.placeholder.com/150",
    },
  ];

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

          /// MEAL SCHEDULE NOTICE FOR CUSTOMERS
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
                  Icon(
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
                  Icon(
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

          /// MEAL TYPE SEGMENT FILTER: (All, Breakfast, Lunch)
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

          /// REDESIGNED CATEGORY SECTION
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

          /// REDESIGNED MENU ITEM LIST
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = filteredItems[index];
              final bool isAvailable = item["isAvailable"];
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
                    /// MENU ITEM IMAGE
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
                          /// ITEM TITLE
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

                          /// DESCRIPTION
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

                          /// PRICE & MEAL BADGE ROW
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

                              /// OPTIONAL MEAL BADGE (Breakfast / Lunch)
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

                    /// ADD / SOLD OUT ACTION BUTTON
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 36,
                        child: ElevatedButton(
                          onPressed: isAvailable ? () {} : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isAvailable
                                ? primaryColor
                                : Colors.grey.shade100,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                          ),
                          child: Text(
                            isAvailable ? "+ Add" : "Sold Out",
                            style: TextStyle(
                              color: isAvailable
                                  ? Colors.white
                                  : Colors.grey.shade400,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
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
