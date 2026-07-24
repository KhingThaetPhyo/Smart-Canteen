import 'package:flutter/material.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({super.key});

  static const Color primaryColor = Color(0xff117992);

  Widget _buildCategoryButton(String title, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white70,
          width: 1,
        ),
        boxShadow:[

                BoxShadow(

                  color:
                  Colors.black12,

                  blurRadius:3,

                  offset:
                  Offset(0,2),

                )

              ],
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
            color: isSelected ? Colors.white : primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
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
        /// Categories
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: SizedBox(
            height: 42,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryButton("All", true),
                  const SizedBox(width: 10),
                  _buildCategoryButton("Breakfast", false),
                  const SizedBox(width: 10),
                  _buildCategoryButton("Noodles", false),
                  const SizedBox(width: 10),
                  _buildCategoryButton("Drinks", false),
                  const SizedBox(width: 10),
                  _buildCategoryButton("Desserts", false),
                  const SizedBox(width: 10),
                  _buildCategoryButton("Snacks", false),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        /// Popular Menu
        SizedBox(
          height: 320,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 10),
            physics: const BouncingScrollPhysics(),
            children: const [
              _PopularMenuCard(
                image: "assets/image/ကြက်ဟင်းခါးသီးကြော်.jpg",
                menuName: "ကြက်ဟင်းခါးသီးကြော်",
                shopName: "Aunty Mon",
                price: 2000,
                
              ),
              SizedBox(width: 16),
              _PopularMenuCard(
                image: "assets/image/လက်ဖက်ထမင်း.jpg",
                menuName: "လက်ဖက်ထမင်း",
                shopName: "Tun",
                price: 3000,
                
              ),
              SizedBox(width: 16),
              _PopularMenuCard(
                image: "assets/image/ဘဲဥဟင်း.jpg",
                menuName: "ဘဲဥဟင်း",
                shopName: "Aunty Mon",
                price: 2500,
                
              ),
              SizedBox(width: 16),
              _PopularMenuCard(
                image: "assets/image/ကြာဇံကြော်.jpg",
                menuName: "ကြာဇံကြော်",
                shopName: "Tun",
                price: 1500,
                
              ),
            ],
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
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            /// IMAGE
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: SizedBox.expand(
                      child: Image.asset(
                        widget.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  /// FAVORITE BUTTON
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.95),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// TEXT
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.menuName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Icon(
                          Icons.storefront_rounded,
                          size: 18,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            widget.shopName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${widget.price} ",
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(
                                text: "pts",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}