import 'package:flutter/material.dart';
import '../../../core/widgets/bottom_navigation_bar.dart';
import '../../../data/models/cart_item.dart';
import '../../widgets/category_chips_widget.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/promo_banner_widget.dart';
import '../../widgets/recommended_widget.dart';
import '../../widgets/search_bar_widget.dart';
import '../../widgets/top_rated.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _favoriteItems = [];
  final List<CartItem> _cartItems = [];

  void _addToFavorites(Map<String, dynamic> item) {
    setState(() {
      if (!_favoriteItems.any((favorite) => favorite['name'] == item['name'])) {
        _favoriteItems.add(item);
      }
    });
  }

  void _addToCart(CartItem item) {
    setState(() {
      final existingIndex = _cartItems.indexWhere(
              (cartItem) => cartItem.name == item.name && cartItem.restaurant == item.restaurant);

      if (existingIndex >= 0) {
        // Item exists - increment quantity
        _cartItems[existingIndex].quantity += 1;
      } else {
        // New item - add to cart
        _cartItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HeaderWidget(),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: SearchBarWidget(),
                ),
              ),
              const CategoryChipsWidget(),
              SliverToBoxAdapter(
                child: AutoChangingBanner(),
              ),
              SliverToBoxAdapter(
                child: TopRatedWidget(
                  onFavoriteAdd: _addToFavorites,
                  onAddToCart: _addToCart,
                ),
              ),

                 RecommendedWidget(
                ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        context: context,
        isDark: Theme.of(context).brightness == Brightness.dark,
        cartItems: _cartItems,
        onAddToCart: _addToCart,
          activeIndex: 0
      ),
    );
  }
}