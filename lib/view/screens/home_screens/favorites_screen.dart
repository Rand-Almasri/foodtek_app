// favorites_screen.dart
import 'package:flutter/material.dart';
import 'package:foodtek_app/data/models/favorite_item.dart' as models;
import '../../../data/models/cart_item.dart';
import '../../widgets/favorite_item_tile.dart';
import '../../widgets/food_order_widget.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/search_bar_widget.dart';
import 'cart_screen.dart' show CartScreen;

class FavoritesScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(CartItem) onAddToCart;

  const FavoritesScreen({Key? key, required this.cartItems, required this.onAddToCart}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<models.FavoriteItem> _favoriteItems = [
    models.FavoriteItem(
        name: 'Pepperoni Pizza',
        price: 29.0,
        imagePath: 'assets/images/pepperoni.jpg',
        description: 'Classic pizza with pepperoni and tomato sauce',
        restaurant: 'Pizza'),
    models.FavoriteItem(
        name: 'Pizza Cheese',
        price: 23.0,
        imagePath: 'assets/images/bigpizza.jpg',
        description: 'Pizza with layers of melted cheese',
        restaurant: 'Pizza'),
    models.FavoriteItem(
        name: 'Peppy Paneer',
        price: 13.0,
        imagePath: 'assets/images/peppy-paneer.jpg',
        description:
        'An Indian-style pizza featuring grilled paneer chunks and spicy seasonings',
        restaurant: 'Pizza'),
    models.FavoriteItem(
        name: 'Mexican Green Wave',
        price: 23.0,
        imagePath: 'assets/images/Mexican_Green_Wave.jpg',
        description:
        'A pizza with bold Mexican flavors, loaded with crunchy onions',
        restaurant: 'Pizza'),
  ];

  models.FavoriteItem? _selectedItem;
  bool _showOrderDetails = false;

  void _handleOrderPressed(models.FavoriteItem item) {
    setState(() {
      _selectedItem = item;
      _showOrderDetails = true;
    });
  }

  void _removeFavoriteItem(models.FavoriteItem item) {
    setState(() {
      _favoriteItems.remove(item);
      if (_selectedItem == item) {
        _showOrderDetails = false;
        _selectedItem = null;
      }
    });
  }

  void _handleBackFromOrder() {
    setState(() {
      _showOrderDetails = false;
    });
  }

  void _addToCart(models.FavoriteItem item, int quantity) {
    final existingIndex =
    widget.cartItems.indexWhere((cartItem) => cartItem.name == item.name);
    if (existingIndex != -1) {
      widget.cartItems[existingIndex].quantity += quantity;
    } else {
      widget.cartItems.add(CartItem(
        name: item.name,
        image: item.imagePath,
        restaurant: item.restaurant,
        price: item.price,
        quantity: quantity,
      ));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.name} added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 3 : 2;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const HeaderWidget(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: SearchBarWidget(),
                    ),
                  ],
                ),
              ),
              if (_showOrderDetails && _selectedItem != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: FoodOrderWidget(
                      item: _selectedItem!,
                      onBackPressed: _handleBackFromOrder,
                      onAddToCart: (orderDetails) =>
                          setState(() => _addToCart(orderDetails.item, orderDetails.quantity)),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: _calculateChildAspectRatio(context),
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final item = _favoriteItems[index];
                        return FavoriteItemTile(
                          item: item,
                          isFavorite: true,
                          onOrderPressed: () => _handleOrderPressed(item),
                          onRemoveFromFavorites: () => _removeFavoriteItem(item),
                          onAddToCart: (quantity) => _addToCart(item, quantity),
                        );
                      },
                      childCount: _favoriteItems.length,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),

    );
  }

  double _calculateChildAspectRatio(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (screenWidth > 600) {
      return screenWidth > screenHeight ? 1.1 : 0.85;
    } else {
      return screenHeight > screenWidth ? 0.75 : 0.85;
    }
  }
}
