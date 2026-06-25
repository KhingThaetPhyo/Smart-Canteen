import 'package:flutter/material.dart';
import 'package:smartcanteen/view/historyscreen.dart';
import 'package:smartcanteen/view/orderscreen.dart';
import 'package:smartcanteen/view/profilescreen.dart';
// TODO: သင်တန်း သို့မဟုတ် ပရောဂျက်ထဲက screen file လမ်းကြောင်းတွေကို ဒီမှာ import လုပ်ပေးပါ
// import 'history_screen.dart';
// import 'order_screen.dart';
// import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _selectedCategory = "All";

  final List<String> _categories = [
    "All",
    "Burmese",
    "Chinese",
    "Western",
    "Drinks",
  ];

  // တခြား Screen class တွေ ရှိပြီးသားဖြစ်ရပါမယ် (ဥပမာ - class HistoryScreen extends StatelessWidget ...)
  // ဒီ List ထဲက screens အစဉ်လိုက်ဟာ BottomNavigationBarItem ရဲ့ အစဉ်လိုက်အတိုင်း ဖြစ်ရပါမယ်။
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      _buildHomeContent(), // Index 0: Home Content
      HistoryScreen(), // Index 1: History Screen (သင်ဆောက်ထားတဲ့ class နာမည်ထည့်ရန်)
      const OrderScreen(), // Index 2: Order Screen (သင်ဆောက်ထားတဲ့ class နာမည်ထည့်ရန်)
      const ProfileScreen(), // Index 3: Profile Screen (သင်ဆောက်ထားတဲ့ class နာမည်ထည့်ရန်)
    ];
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF0A7083);

    return Scaffold(
      // body နေရာမှာ လက်ရှိရွေးထားတဲ့ index အလိုက် screen ကို ပြောင်းပြမှာဖြစ်ပါတယ်
      body: _screens[_selectedIndex],

      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex =
                index; // ဒီမှာ နှိပ်လိုက်တဲ့ index အလိုက် State ပြောင်းပေးပါတယ်
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // ကုဒ်တွေ ရှုပ်မသွားအောင် မူလ Home UI တစ်ခုလုံးကို Widget function ခွဲထုတ်လိုက်တာဖြစ်ပါတယ်
  Widget _buildHomeContent() {
    const Color primaryColor = Color(0xFF0A7083);

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER SECTION ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Hello,',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Htet Lin Kyaw 👋',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_none_outlined,
                          size: 28,
                        ),
                      ),
                      Positioned(
                        right: 12,
                        top: 12,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // --- POINTS CARD SECTION ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.auto_awesome_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'MY POINTS',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: const [
                        Text(
                          '1,525',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'pts',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.card_giftcard,
                            color: primaryColor,
                            size: 18,
                          ),
                          label: const Text(
                            'Exchange food',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.trending_up,
                            color: Colors.white,
                            size: 18,
                          ),
                          label: const Text(
                            'Earn more',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // --- SEARCH BAR SECTION ---
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search shops...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // --- CATEGORIES LIST ---
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedCategory == _categories[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ChoiceChip(
                        label: Text(_categories[index]),
                        selected: isSelected,
                        selectedColor: primaryColor,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected
                                ? primaryColor
                                : const Color(0xFFE5E7EB),
                          ),
                        ),
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedCategory = _categories[index];
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // --- SHOPS NEARBY TITLE ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.storefront, color: primaryColor, size: 20),
                      SizedBox(width: 6),
                      Text(
                        'Shops nearby',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '6 open',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // --- SHOP CARD ---
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF3F4F6)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.ramen_dining,
                        color: Colors.orange,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Moe's Burmese Kitchen",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Authentic Burmese cuisine with traditional recipes",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "4.8",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.access_time,
                                color: Colors.grey,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "07:00–18:00",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.chair_alt,
                                color: Colors.grey,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "24 seats",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
