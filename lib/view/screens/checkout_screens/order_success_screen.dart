import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_theme/theme_provider.dart';
import '../../../core/constants/constant_colors.dart';
import '../../../core/widgets/bottom_navigation_track.dart';
import '../../../data/models/cart_item.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  final List<CartItem> _cartItems = [];
  void _addToCart(CartItem item) {
    setState(() {
      final existingIndex = _cartItems.indexWhere(
              (cartItem) => cartItem.name == item.name && cartItem.restaurant == item.restaurant);

      if (existingIndex >= 0) {
        _cartItems[existingIndex].quantity += 1;
      } else {
        _cartItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              // for tablets & responsiveness
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Text(
                          'checkout ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Column(
                      children: [
                        SizedBox(height: 80),

                        Image.asset(
                          'assets/images/done_cheakout.png',
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 55),
                      child: Center(
                        child: Text(
                          'Your Order Done Successfully',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 55),
                      child: Center(
                        child: Text(
                          'you will get your order within 12min.\n thanks for using our services',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Pay Button
                    SizedBox(
                      width: 300,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Handle payment logic
                        },

                        label: Text('Track Your Order', style: TextStyle(
                            fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: AppColors.primaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
        bottomNavigationBar: BottomNavigationTrack(
          context: context,
          isDark: themeProvider.isDarkMode,
          cartItems: _cartItems,
          onAddToCart: _addToCart,
        activeIndex: 2,)
    );
  }
}