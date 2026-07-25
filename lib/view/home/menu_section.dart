import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({super.key});

  static const Color primaryColor = Color(0xff117992);

  Widget _buildCategoryButton(String title, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: isSelected ? primaryColor : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
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
    final List<Map<String, dynamic>> menuItems = [
      {
        "image": "assets/image/ကြက်ဟင်းခါးသီးကြော်.jpg",
        "menuName": "ကြက်ဟင်းခါးသီးကြော်",
        "shopName": "Aunty Mon",
        "price": 1500,
      },
      {
        "image": "assets/image/လက်ဖက်ထမင်း.jpg",
        "menuName": "လက်ဖက်ထမင်း",
        "shopName": "Tun",
        "price": 2200,
      },
      {
        "image": "assets/image/ဘဲဥဟင်း.jpg",
        "menuName": "မုန့်ဟင်းခါး",
        "shopName": "Daw Nu",
        "price": 1800,
      },
      {
        "image": "assets/image/ကြာဇံကြော်.jpg",
        "menuName": "သံပရာရည်",
        "shopName": "Chill Zone",
        "price": 1200,
      },
    ];

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
                onPressed: () {},
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

        /// CATEGORY PILLS HORIZONTAL SCROLL (Optimized gesture handling)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              _buildCategoryButton("နေ့လယ်စာ", true),
              const SizedBox(width: 10),
              _buildCategoryButton("မနက်စာ", false),
              const SizedBox(width: 10),
              _buildCategoryButton("မုန့်များ", false),
              const SizedBox(width: 10),
              _buildCategoryButton("အချိုရည်", false),
              const SizedBox(width: 10),
              _buildCategoryButton("အချိုပွဲ", false),
            ],
          ),
        ),

        const SizedBox(height: 16),

        /// MENU GRID SECTION (Fixed non-scrollable configuration)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // 👈 Disables inner vertical scrolling completely
            itemCount: menuItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85, 
            ),
            itemBuilder: (context, index) {
              final item = menuItems[index];
              return _PopularMenuCard(
                image: item["image"],
                menuName: item["menuName"],
                shopName: item["shopName"],
                price: item["price"],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PopularMenuCard extends StatefulWidget {
  final String image;
  final String menuName;
  final String shopName;
  final int price;

  const _PopularMenuCard({
    required this.image,
    required this.menuName,
    required this.shopName,
    required this.price,
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
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
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

          /// 2. TEXT/CONTENT SECTION
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
                          widget.menuName,
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
                          "${NumberFormat('#,###').format(widget.price)} ပွိုင့်",
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
                    onTap: () {},
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