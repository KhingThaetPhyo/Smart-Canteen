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
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sample items list matching your design
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
          padding: const EdgeInsets.symmetric(horizontal: 20,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Categories",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "View All",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// CATEGORY PILLS HORIZONTAL SCROLL
        SizedBox(
          height: 35,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildCategoryButton("lunch", true),
              const SizedBox(width: 10),
              _buildCategoryButton("Breakfast", false),
              const SizedBox(width: 10),
              _buildCategoryButton("Noodles", false),
              const SizedBox(width: 10),
              _buildCategoryButton("Drinks", false),
              const SizedBox(width: 10),
              _buildCategoryButton("Desserts", false),
            ],
          ),
        ),

        const SizedBox(height: 12),

        /// MENU GRID SECTION (2 COLUMNS)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: menuItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85, // Adjust aspect ratio as needed
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
  static const Color accentBgColor = Color(0xffB5EAE1);

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
          /// 1. IMAGE SECTION (Takes exactly 2/3 of card)
          Expanded(
            flex: 2, // 👈 2/3 of space
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
                       
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 2. TEXT/CONTENT SECTION (Takes exactly 1/3 of card)
          Expanded(
  flex: 1, // 👈 1/3 of card space
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// LEFT SIDE: Title, Shop Name, and Price
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Menu Name
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

              // 2. Shop Name with Icon
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

              // 3. Price
              Text(
                "${NumberFormat('#,###').format(widget.price)} pts",
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 6),

        /// RIGHT SIDE: Add (+) Button
       InkWell(
  onTap: () {},
  borderRadius: BorderRadius.circular(6),
  child: Container(
    width: 25,
    height: 25,
    decoration: BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.circular(6), // Square with slightly rounded corners
    ),
    child: const Icon(
      Icons.arrow_forward_rounded,
      color: Colors.white,
      size: 18,
    ),
  ),
)
      ],
    ),
  ),
)
        ],
      ),
    );
  }
}