import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcanteen/model/menu_model.dart';
import 'package:smartcanteen/service/secure_storage_service.dart';

/// ==========================================
/// 1. FAVORITES MANAGER (Persistent State Handler)
/// ==========================================
class FavoriteItem {
  final String shopName;
  final MenuModel menu;

  FavoriteItem({required this.shopName, required this.menu});

  Map<String, dynamic> toJson() => {
        'shopName': shopName,
        'menu': menu.toJson(),
      };

  factory FavoriteItem.fromJson(Map<String, dynamic> json) => FavoriteItem(
        shopName: json['shopName'],
        menu: MenuModel.fromJson(json['menu']),
      );
}

class FavoritesManager extends ChangeNotifier {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  
  FavoritesManager._internal() {
    loadFavorites(); // Load on initial creation
  }

  static const String _storageKey = 'saved_user_favorites';
  final List<FavoriteItem> _favorites = [];

  List<FavoriteItem> get favorites => _favorites;

  bool isFavorite(MenuModel menu) {
    return _favorites.any((item) => item.menu.menuId == menu.menuId);
  }

  Future<void> toggleFavorite(String shopName, MenuModel menu) async {
    if (isFavorite(menu)) {
      _favorites.removeWhere((item) => item.menu.menuId == menu.menuId);
    } else {
      _favorites.add(FavoriteItem(shopName: shopName, menu: menu));
    }
    notifyListeners();
    await _saveFavorites();
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> jsonList = _favorites
          .map((item) => jsonEncode(item.toJson()))
          .toList();
      await prefs.setStringList(_storageKey, jsonList);
    } catch (e) {
      debugPrint("Error saving favorites: $e");
    }
  }

  /// Public method to reload preferences from disk (ideal after a login state change)
  Future<void> loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Ensure we pull fresh data from disk storage if modified outside isolate cache
      await prefs.reload(); 
      final List<String>? jsonList = prefs.getStringList(_storageKey);

      _favorites.clear();
      if (jsonList != null) {
        for (String jsonStr in jsonList) {
          final Map<String, dynamic> map = jsonDecode(jsonStr);
          _favorites.add(FavoriteItem.fromJson(map));
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading favorites: $e");
    }
  }

  Future<void> clearFavoritesOnLogout() async {
    _favorites.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
    notifyListeners();
  }
}
/// ==========================================
/// 2. FAVOURITE SCREEN UI
/// ==========================================
class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  static const Color primaryColor = Color(0xff117992);
  final FavoritesManager _favoritesManager = FavoritesManager();
  bool _isLoading = true;
  bool _isLoggedIn = false; // Track login state

  @override
  void initState() {
    super.initState();
    _favoritesManager.addListener(_onFavoritesChanged);
    _refreshData();
  }

  Future<void> _refreshData() async {
    // Check if user has an auth token stored
    final token = await SecureStorageService.getToken();
    _isLoggedIn = token != null && token.isNotEmpty;

    if (_isLoggedIn) {
      // Explicitly pull fresh favorite data if logged in
      await _favoritesManager.loadFavorites();
    }
    
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _favoritesManager.removeListener(_onFavoritesChanged);
    super.dispose();
  }

  void _onFavoritesChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final favoriteItems = _favoritesManager.favorites;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      // appBar: AppBar(
      //   title: const Text(
      //     "အကြိုက်ဆုံး မီနူးများ",
      //     style: TextStyle(
      //       color: Colors.black87,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 18,
      //     ),
      //   ),
      //   backgroundColor: const Color(0xff117992),
      //   elevation: 0.5,
      //   iconTheme: const IconThemeData(color: Colors.black87),
      // ),
      appBar: PreferredSize(
  // Increase the height (e.g., kToolbarHeight + 30) to accommodate top spacing
  preferredSize: const Size.fromHeight(kToolbarHeight + 30), 
  child: AppBar(
    title: Padding(
      padding: const EdgeInsets.only(top: 30),
      child: const Text(
        "အကြိုက်ဆုံး မီနူးများ",
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    ),
    backgroundColor: const Color(0xff117992),
    elevation: 0.5,
    iconTheme: const IconThemeData(color: Colors.black87),
  ),
),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: primaryColor))
            : !_isLoggedIn
                // Show text when user is not logged in
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text(
                        "အကြိုက်ဆုံးမီနူးများကိုကြည့်ရှုရန် ကျေးဇူးပြု၍ အကောင့်ဝင်ပါ။",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                : favoriteItems.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                            SizedBox(height: 12),
                            Text(
                              "အကြိုက်ဆုံး မီနူးများ မရှိသေးပါ။",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20),
                        child: GridView.builder(
                          itemCount: favoriteItems.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.85,
                          ),
                          itemBuilder: (context, index) {
                            final item = favoriteItems[index];
                            return _FavoriteMenuCard(
                              shopName: item.shopName,
                              menu: item.menu,
                              onRemove: () {
                                _favoritesManager.toggleFavorite(item.shopName, item.menu);
                              },
                            );
                          },
                        ),
                      ),
      ),
    );
  }
}
/// ==========================================
/// 3. FAVORITE MENU CARD WIDGET
/// ==========================================
class _FavoriteMenuCard extends StatelessWidget {
  final String shopName;
  final dynamic menu;
  final VoidCallback onRemove;

  static const Color primaryColor = Color(0xff117992);

  const _FavoriteMenuCard({
    required this.shopName,
    required this.menu,
    required this.onRemove,
  });

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
                      menu.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.fastfood, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.itemName,
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
                          shopName,
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
                    "${NumberFormat('#,###').format(menu.itemPrice)} ပွိုင့်",
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
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