import 'package:flutter/material.dart';
import 'package:foodtek_app/view/screens/home_screens/history_screen.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../data/models/cart_item.dart';
import '../../../data/models/favorite_item.dart';
import '../../widgets/header_widget.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  CartScreen({super.key, required this.cartItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    cartItems = List.from(widget.cartItems); // Copy the initial items
  }

  void addToCart(FavoriteItem favoriteItem, int quantity) {
    setState(() {
      // Check if already exists
      final existingIndex =
      cartItems.indexWhere((item) => item.name == favoriteItem.name);
      if (existingIndex != -1) {
        cartItems[existingIndex].quantity += quantity;
      } else {
        cartItems.add(
          CartItem(
            name: favoriteItem.name,
            image: favoriteItem.imagePath,
            restaurant: favoriteItem.restaurant,
            price: favoriteItem.price,
            quantity: quantity,
          ),
        );
      }
    });
  }
  bool _isHistorySelected = false;
  void navigateTohistoryScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>  HistoryScreen(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: cartItems.isEmpty
            ? _buildEmptyCartScreen(context)
            : Column(
          children: [
            Expanded(
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        children: [
                          HeaderWidget(),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                // Cart Tab - 50%
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isHistorySelected = true;
                                      });
                                      navigateTohistoryScreen();
                                    },
                                    child: Column(
                                      children: [
                                        Text(
                                          'Cart',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: _isHistorySelected
                                                ? AppColors.secondary
                                                : AppColors.primaryGreen,
                                            fontWeight: _isHistorySelected
                                                ? FontWeight.normal
                                                : FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          height: 2,
                                          color: _isHistorySelected
                                              ? Colors.transparent
                                              : AppColors.primaryGreen,
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
                                        _isHistorySelected = true;
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Text(
                                          'History',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: _isHistorySelected
                                                ? AppColors.primaryGreen
                                                : AppColors.secondary,
                                            fontWeight: _isHistorySelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                        Container(
                                          height: 2,
                                          color: _isHistorySelected
                                              ? AppColors.primaryGreen
                                              : Colors.transparent,
                                          margin: const EdgeInsets.only(top: 4),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return Dismissible(
                          key: Key(cartItems[index].name),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.yellow.shade700,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0),
                            child: const Icon(Icons.delete,
                                color: Colors.white),
                          ),
                          onDismissed: (direction) {
                            setState(() {
                              cartItems.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      '${cartItems[index].name} removed')),
                            );
                          },
                          child: _buildCartItem(cartItems[index], index),
                        );
                      },
                      childCount: cartItems.length,
                    ),
                  ),
                ],
              ),
            ),
            _buildOrderSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(CartItem item, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              item.image,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 70,
                height: 70,
                color: Colors.grey[200],
                child: const Icon(Icons.fastfood),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  item.restaurant,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 26,
                  height: 22,
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        if (cartItems[index].quantity > 1) {
                          cartItems[index].quantity--;
                        }
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.green),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Icon(Icons.remove, size: 16),
                  ),
                ),
                const SizedBox(width: 3),
                SizedBox(
                  width: 28,
                  child: Text(
                    cartItems[index].quantity.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 3),
                SizedBox(
                  width: 26,
                  height: 22,
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        cartItems[index].quantity++;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.green),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Icon(Icons.add, size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    if (cartItems.isEmpty) {
      return const SizedBox.shrink();
    }

    double subTotal = 0;
    for (var item in cartItems) {
      subTotal += item.price * item.quantity;
    }
    const deliveryCharge = 10.0;
    const discount = 10.0;
    final total = subTotal + deliveryCharge - discount;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cartbackground.png'),
            fit: BoxFit.cover,
          ),
          color: Colors.green,
          borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
        ),
        child: Column(
          children: [
            summaryRow('Sub-Total', '\$${subTotal.toStringAsFixed(2)}'),
            summaryRow('Delivery Charge', '\$${deliveryCharge.toStringAsFixed(2)}'),
            summaryRow('Discount', '\$${discount.toStringAsFixed(2)}'),
            const SizedBox(height: 7),
            summaryRow('Total', '\$${total.toStringAsFixed(2)}', isBold: true),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 120, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Place My Order',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildEmptyCartScreen(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: HeaderWidget(),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/emptycartbackground.png',
                  height: 150,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Cart Empty',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "You don't have add any foods in cart at this time",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}