import 'package:flutter/material.dart';
import 'package:foodtek_app/view/screens/home_screens/cart_screen.dart';

import '../../../data/models/cart_item.dart' show CartItem;
import 'favorites_screen.dart';
import 'home_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<CartItem> _cartItems = [];

  void _addToCart(CartItem item) {
    final index = _cartItems.indexWhere((i) => i.name == item.name);
    if (index != -1) {
      setState(() {
        _cartItems[index].quantity += item.quantity;
      });
    } else {
      setState(() {
        _cartItems.add(item);
      });
    }
  }
  int _selectedIndex = 0;

  List<Widget> get _pages => [
    HomeScreen(),
    FavoritesScreen(cartItems: _cartItems, onAddToCart: _addToCart),
    CartScreen(cartItems: _cartItems),
    HistoryScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFFDFF3D1),
        selectedItemColor: Color(0xFF2EA44F),
        unselectedItemColor: Colors.black54,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF2EA44F),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.shopping_cart, color: Colors.white),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
