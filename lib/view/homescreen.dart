import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedCategoryIndex = 0;

  final List<String> categories = [
    'All',
    'Snack',
    'Drinks',
    'Dessert',
    'Bakery',
    'Candy',
    'Ice Cream',
    'Smoothies',
    'Fast Food',
    'Coffee',
  ];

  final List<Map<String, String>> horizontalIceCreams = [
    {'name': 'Matcha Delight', 'price': '\$ 12.34'},
    {'name': 'Mango Smoothie', 'price': '\$ 10.50'},
    {'name': 'Strawberry Twist', 'price': '\$ 11.99'},
    {'name': 'Vanilla Bean', 'price': '\$ 9.00'},
    {'name': 'Chocolate Fudge', 'price': '\$ 13.00'},
    {'name': 'Taro Heaven', 'price': '\$ 11.50'},
    {'name': 'Berry Blast', 'price': '\$ 12.00'},
    {'name': 'Coconut Dream', 'price': '\$ 10.00'},
    {'name': 'Avocado Cream', 'price': '\$ 14.00'},
    {'name': 'Durian Special', 'price': '\$ 15.50'},
  ];

  final List<Map<String, String>> verticalIceCreams = [
    {'name': 'Mint Chocolate Chip', 'price': '\$3.99'},
    {'name': 'Caramel Crunch', 'price': '\$4.50'},
    {'name': 'Cookie Dough Special', 'price': '\$4.99'},
    {'name': 'Coffee Almond Fudge', 'price': '\$5.20'},
    {'name': 'Pistachio Perfection', 'price': '\$4.80'},
    {'name': 'Rocky Road Classic', 'price': '\$4.60'},
    {'name': 'Banana Split Cup', 'price': '\$6.00'},
    {'name': 'Blueberry Cheesecake', 'price': '\$5.50'},
    {'name': 'Mango Tango Gelato', 'price': '\$4.20'},
    {'name': 'Red Velvet Scoop', 'price': '\$5.00'},
  ];

  @override
  Widget build(BuildContext context) {
    const customTealColor = Color(
      0xFF0F7B8E,
    ); // Good morning ရဲ့ နောက်ခံ Teal အရောင်

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            // ၁။ Header Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: customTealColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: customTealColor.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 24.0,
                right: 24.0,
                bottom: 20.0,
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white24,
                    child: Icon(
                      Icons.person_outline,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Good morning',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 1),
                            Text(
                              'Wa Thon',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'MY POINTS',
                              style: TextStyle(
                                color: Colors.white54,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                                fontSize: 10,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: const [
                                Text(
                                  '1555',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Text(
                                  'pts',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ၂။ Search Bar နှင့် Category Tabs
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 46,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search_',
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9CA3AF),
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xFF9CA3AF),
                            size: 20,
                          ),
                          suffixIcon: const Icon(
                            Icons.close,
                            color: Color(0xFF9CA3AF),
                            size: 20,
                          ),
                          filled: true,
                          fillColor: const Color(
                            0xFFF3F4F6,
                          ), // အဖြူရောင်ပေါ်မှာ ထင်ရှားအောင် မီးခိုးနုလေး သုံးထားပါတယ်
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: List.generate(categories.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategoryIndex = index;
                              });
                            },
                            child: CategoryTab(
                              title: categories[index],
                              isSelected: _selectedCategoryIndex == index,
                              activeColor: customTealColor,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5),

            // ၃။ Horizontal Cards (Teal အရောင် ဖောင်းကြွကတ်များ)
            SizedBox(
              height: 150,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: horizontalIceCreams.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 14.0,
                      bottom: 12.0,
                      top: 4,
                    ),
                    child: _buildGridItem(
                      horizontalIceCreams[index]['name']!,
                      horizontalIceCreams[index]['price']!,
                      Icons.icecream_outlined,
                      customTealColor,
                    ),
                  );
                },
              ),
            ),

            // ၄။ Vertical Cards (Teal အရောင် ဖောင်းကြွကတ်များ)
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 110.0,
                ),
                itemCount: verticalIceCreams.length,
                itemBuilder: (context, index) {
                  final item = verticalIceCreams[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: _buildListItem(
                      item['name']!,
                      item['price']!,
                      Icons.icecream_rounded,
                      customTealColor,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button (QR Scan - အဖြူရောင် ပေါ်လွင်စေရန် ပြင်ဆင်ထားသည်)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 12),
        child: Container(
          height: 58,
          width: 58,
          decoration: BoxDecoration(
            color: Colors
                .white, // အောက်ခြေ Teal ထဲမှာ ပေါ်လွင်အောင် အဖြူရောင် ပြောင်းထားပါတယ်
            shape: BoxShape.circle,
            border: Border.all(color: customTealColor, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.transparent,
            onPressed: () {},
            child: const Icon(
              Icons.qr_code_scanner,
              color: customTealColor,
              size: 24,
            ),
          ),
        ),
      ),

      // Bottom Navigation Bar (Teal အရောင် ဖောင်းကြွဒီဇိုင်း)
      bottomNavigationBar: Container(
        height: 68,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        decoration: BoxDecoration(
          color:
              customTealColor, // Good morning နောက်ခံအတိုင်း ပြောင်းလဲပေးထားပါတယ်
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: customTealColor.withOpacity(
                0.4,
              ), // ထင်းနေသော ဖောင်းကြွ Shadow
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavItem(Icons.home_rounded, 'ပင်မ', true),
            _buildBottomNavItem(Icons.assignment_rounded, 'အော်ဒါများ', false),
            const SizedBox(width: 40), // QR နေရာလွတ်
            _buildBottomNavItem(
              Icons.account_balance_wallet_rounded,
              'ပိုက်ဆံအိတ်',
              false,
            ),
            _buildBottomNavItem(Icons.person_rounded, 'ကိုယ်ရေး', false),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, bool isActive) {
    final color = isActive
        ? Colors.white
        : Colors.white60; // စာလုံးနှင့် အိုင်ကွန်များကို အဖြူရောင်သန်းထားပါတယ်
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildGridItem(
    String name,
    String price,
    IconData icon,
    Color themeColor,
  ) {
    return Container(
      width: 135,
      decoration: BoxDecoration(
        color: themeColor, // ကတ်နောက်ခံကို Teal အရောင်ပြောင်းထားပါတယ်
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: themeColor.withOpacity(
              0.4,
            ), // ပိုမိုထင်ရှားသော ဖောင်းကြွရိပ်
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 65,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(
                0.15,
              ), // ကတ်ထဲက အိုင်ကွန်ကွက်ကို အဖြူလင်းလင်းလေး ထားထားပါတယ်
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 28, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            price,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(
    String name,
    String price,
    IconData icon,
    Color themeColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: themeColor, // ကတ်နောက်ခံကို Teal အရောင်ပြောင်းထားပါတယ်
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: themeColor.withOpacity(
              0.35,
            ), // ပိုမိုထင်ရှားသော ဖောင်းကြွရိပ်
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 26, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Color activeColor;

  const CategoryTab({
    super.key,
    required this.title,
    required this.isSelected,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? activeColor : const Color(0xFF9CA3AF),
          ),
        ),
        SizedBox(
          height: 5.0,
          child: isSelected
              ? Container(
                  margin: const EdgeInsets.only(top: 4.0),
                  height: 3.0,
                  width: 16,
                  decoration: BoxDecoration(
                    color: activeColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
