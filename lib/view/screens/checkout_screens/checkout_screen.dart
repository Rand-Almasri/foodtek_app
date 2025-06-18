import 'package:flutter/material.dart';
import 'package:foodtek_app/view/screens/checkout_screens/add_card_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/app_theme/theme_provider.dart';
import '../../../core/widgets/bottom_navigation_track.dart';
import '../../../data/models/cart_item.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
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
  String selectedPayment = "Card"; // Default to Card based on design
  String selectedCardType = "MasterCard"; // Default to MasterCard based on design

  void _placeOrder() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  AddCardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pay With:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            // Combined address selection area
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.location_on, color: Colors.white, size: 13),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "88 Zurab Gorgiladze Street",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Georgia, Batumi",
                              style: TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.green, size: 18),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "5 Noe Zhordania St",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Georgia, Batumi",
                              style: TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Change",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Promo code section and add button
            const Text(
              "Promo Code?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Your Promo",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  ),
                  child: const Text("Add"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Payment method selection
            const Text(
              "Pay With:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Radio<String>(
                  value: "Card",
                  groupValue: selectedPayment,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      selectedPayment = value!;
                    });
                  },
                ),
                const Text("Card"),
                const SizedBox(width: 20),
                Radio<String>(
                  value: "Cash",
                  groupValue: selectedPayment,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      selectedPayment = value!;
                    });
                  },
                ),
                const Text("Cash"),
              ],
            ),
            const SizedBox(height: 16),
            // Card type selection
            const Text(
              "Card Type:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Radio<String>(
                  value: "MasterCard",
                  groupValue: selectedCardType,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      selectedCardType = value!;
                    });
                  },
                ),
                Image.asset("assets/images/mastercard.png", height: 20),
                const SizedBox(width: 20),
                Radio<String>(
                  value: "Visa",
                  groupValue: selectedCardType,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      selectedCardType = value!;
                    });
                  },
                ),
                Image.asset("assets/images/visa.png", height: 18),
              ],
            ),
            const SizedBox(height: 18),
            // Order summary with Place Order button inside
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/images/cartbackground.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sub-Total", style: TextStyle(color: Colors.white)),
                      Text("100 \$", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivery Charge", style: TextStyle(color: Colors.white)),
                      Text("10 \$", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Discount", style: TextStyle(color: Colors.white)),
                      Text("-10 \$", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Divider(color: Colors.white.withOpacity(0.3), height: 24),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total:", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("110\$", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _placeOrder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Place My Order",
                        style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
