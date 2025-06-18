import 'package:flutter/material.dart';
import 'package:foodtek_app/core/constants/constant_colors.dart';
import 'package:foodtek_app/view/screens/checkout_screens/order_success_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/app_theme/theme_provider.dart';
import '../../../core/widgets/bottom_navigation_track.dart';
import '../../../data/models/cart_item.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final List<CartItem> _cartItems = [];

  void _addToCart(CartItem item) {
    setState(() {
      final existingIndex = _cartItems.indexWhere(
              (cartItem) =>
          cartItem.name == item.name &&
              cartItem.restaurant == item.restaurant);

      if (existingIndex >= 0) {
        _cartItems[existingIndex].quantity += 1;
      } else {
        _cartItems.add(item);
      }
    });
  }

  final _nameController = TextEditingController(text: 'Raya Daboor');
  final _cardNumberController =
  TextEditingController(text: '6578 8756 4238 92764');
  final _expiryController = TextEditingController(text: '04/23');
  final _cvcController = TextEditingController(text: '875');

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add Card',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * 0.02),

                      Image.asset(
                        'assets/images/card.png',
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: 200,
                      ),
                      SizedBox(height: size.height * 0.025),

                      const Text('Name'),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),

                      SizedBox(height: size.height * 0.02),

                      const Text('Card Number'),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _cardNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              'assets/images/minicard.png',
                              width: 40,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.02),

                      Row(
                        children: const [
                          Expanded(child: Text('Expiry')),
                          SizedBox(width: 16),
                          Expanded(child: Text('CVC')),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _expiryController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: TextField(
                              controller: _cvcController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.025,
                            horizontal: size.width * 0.1),
                        child: const Center(
                          child: Text(
                            'We will send you an order details to your email after the successful payment.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const OrderSuccessScreen()),
                            );
                          },
                          icon: const Icon(Icons.lock),
                          label: const Text('Pay for the order',
                              style: TextStyle(fontSize: 16)),
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
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationTrack(
        context: context,
        isDark: themeProvider.isDarkMode,
        cartItems: _cartItems,
        onAddToCart: _addToCart,
        activeIndex: 2,
      ),
    );
  }
}
