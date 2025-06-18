import 'package:flutter/material.dart';
import 'package:foodtek_app/view/screens/home_screens/cart_screen.dart';
import 'package:foodtek_app/view/screens/home_screens/favorites_screen.dart';
import 'package:foodtek_app/view/screens/home_screens/history_screen.dart';
import 'package:foodtek_app/view/screens/home_screens/home_screen.dart';
import 'package:foodtek_app/view/screens/home_screens/profile/profile_screen.dart';
import '../../data/models/cart_item.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final BuildContext context;
  final bool isDark;
  final List<CartItem> cartItems;
  final Function(CartItem) onAddToCart;
  final int activeIndex;

  const CustomBottomNavigationBar({
    super.key,
    required this.context,
    required this.isDark,
    required this.cartItems,
    required this.onAddToCart,
    required this.activeIndex,
  });

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {

  void _navigateTo(Widget page) {
    Navigator.push(
      widget.context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final greenColor = const Color(0xFF2EA44F);

    return BottomNavigationBar(
      currentIndex: widget.activeIndex,
      onTap: (index) {
        if (index == widget.activeIndex) return;
        switch (index) {
          case 0:
            _navigateTo(const HomeScreen());
            break;
          case 1:
            _navigateTo(FavoritesScreen(
              cartItems: widget.cartItems,
              onAddToCart: widget.onAddToCart,
            ));
            break;
          case 2:
            _navigateTo(CartScreen(
              cartItems: widget.cartItems,
              onAddToCart: widget.onAddToCart,
            ));
            break;
          case 3:
            _navigateTo(HistoryScreen(
              cartItems: widget.cartItems,
              onAddToCart: widget.onAddToCart,
            ));
            break;
          case 4:
            _navigateTo(const ProfileScreen());
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: greenColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: widget.isDark ? theme.colorScheme.surface : const Color(0xFFDFF3D1),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: widget.activeIndex  == 0 ? greenColor : Colors.grey,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite_border,
            color: widget.activeIndex  == 1 ? greenColor : Colors.grey,
          ),
          label: "Favorites",
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: widget.isDark ? theme.colorScheme.primary : greenColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_cart,
              color: widget.activeIndex  == 2 ? Colors.white : Colors.white,
            ),
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.history,
            color: widget.activeIndex  == 3 ? greenColor : Colors.grey,
          ),
          label: "History",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: widget.activeIndex  == 4 ? greenColor : Colors.grey,
          ),
          label: "Profile",
        ),
      ],
    );
  }
}