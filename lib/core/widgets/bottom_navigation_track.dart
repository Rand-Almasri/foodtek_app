import 'package:flutter/material.dart';
import 'package:foodtek_app/view/screens/home_screens/tracking/location_tracking.dart';
import '../../data/models/cart_item.dart';
import '../../view/screens/home_screens/cart_screen.dart';
import '../../view/screens/home_screens/favorites_screen.dart';
import '../../view/screens/home_screens/home_screen.dart';
import '../../view/screens/home_screens/profile/profile_screen.dart';

class BottomNavigationTrack extends StatefulWidget {
  final BuildContext context;
  final bool isDark;
  final List<CartItem> cartItems;
  final Function(CartItem) onAddToCart;
  final int activeIndex;


  const BottomNavigationTrack({
    super.key,
    required this.context,
    required this.isDark,
    required this.cartItems,
    required this.onAddToCart,
    required this.activeIndex,

  });

  @override
  State<BottomNavigationTrack> createState() => _BottomNavigationTrackState();
}

class _BottomNavigationTrackState extends State<BottomNavigationTrack> {
  final Color _selectedColor = const Color(0xFF2EA44F); // Green color
  final Color _unselectedColor = Colors.grey;

  void _navigateTo(Widget page) {
    Navigator.push(
      widget.context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

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
            _navigateTo(const LocationTracking());
            break;
          case 4:
            _navigateTo(const ProfileScreen());
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: _selectedColor,
      unselectedItemColor: _unselectedColor,
      backgroundColor: widget.isDark ? theme.colorScheme.surface : const Color(0xFFDFF3D1),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: widget.activeIndex == 0 ? _selectedColor : _unselectedColor,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite_border,
            color: widget.activeIndex == 1 ? _selectedColor : _unselectedColor,
          ),
          label: "Favorites",
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: widget.isDark ? theme.colorScheme.primary : _selectedColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.shopping_cart, color: Colors.white),
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.location_on_outlined,
            color: widget.activeIndex == 3 ? _selectedColor : _unselectedColor,
          ),
          label: "Track",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: widget.activeIndex == 4 ? _selectedColor : _unselectedColor,
          ),
          label: "Profile",
        ),
      ],
    );
  }
}