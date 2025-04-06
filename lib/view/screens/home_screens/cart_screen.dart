import 'package:flutter/material.dart';
import '../../../core/constants/constant_colors.dart';
import '../../widgets/header_widget.dart';
import 'history_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isCartSelected = true;
  bool get isCartEmpty => true;

  void navigateToHistoryScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HistoryScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Using the HeaderWidget
            const HeaderWidget(),

            // Tabs - Cart and History
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Cart Tab - 50%
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _isCartSelected = true;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            'Cart',
                            style: TextStyle(
                              fontSize: 18,
                              color: _isCartSelected
                                  ? AppColors.primaryGreen
                                  : AppColors.secondary,
                              fontWeight: _isCartSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          Container(
                            height: 2,
                            color: _isCartSelected
                                ? AppColors.primaryGreen
                                : Colors.transparent,
                            margin: const EdgeInsets.only(top: 4),
                          )
                        ],
                      ),
                    ),
                  ),

                  // History Tab - 50%
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _isCartSelected = false;
                        });
                        navigateToHistoryScreen();
                      },
                      child: Column(
                        children: [
                          Text(
                            'History',
                            style: TextStyle(
                              fontSize: 18,
                              color: _isCartSelected
                                  ? AppColors.secondary
                                  : AppColors.primaryGreen,
                              fontWeight: _isCartSelected
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 2,
                            color: _isCartSelected
                                ? Colors.transparent
                                : AppColors.primaryGreen,
                            margin: const EdgeInsets.only(top: 4),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Content - Either cart items or empty state
            Expanded(
              child: isCartEmpty
                  ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 60,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Your cart is empty',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: 0,
                itemBuilder: (context, index) => Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}