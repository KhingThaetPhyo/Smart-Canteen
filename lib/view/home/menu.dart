import 'package:flutter/material.dart';
import 'package:smartcanteen/view/home/menu_section.dart';
//import 'popular_menu_card.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// SECTION HEADER
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Popular Menu",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Most ordered items on campus",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        /// HORIZONTAL LIST
        SizedBox(
          height: 250,
          child: ListView(
            padding: const EdgeInsets.only(left: 20, right: 4),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              PopularMenuCard(
                menuName: "Milk Tea",
                shopName: "Coffee Corner",
                price: 1500,
                rating: 4.8,
                onTap: () {},
              ),
              PopularMenuCard(
                menuName: "Shan Noodle",
                shopName: "Aunt May Noodles",
                price: 3000,
                rating: 4.9,
                onTap: () {},
              ),
              PopularMenuCard(
                menuName: "Fried Rice",
                shopName: "Snack House",
                price: 2500,
                rating: 4.7,
                onTap: () {},
              ),
              PopularMenuCard(
                menuName: "Thai Milk Tea",
                shopName: "Coffee Corner",
                price: 1800,
                rating: 4.8,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}