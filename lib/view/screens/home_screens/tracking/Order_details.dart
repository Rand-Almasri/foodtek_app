import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodtek_app/core/widgets/bottom_navigation_track.dart';
import 'package:foodtek_app/view/screens/home_screens/tracking/location_tracking.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme/theme_provider.dart';
import '../../../../core/constants/constant_colors.dart' show AppColors;
import '../../../../data/models/cart_item.dart' show CartItem;
import 'chat_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
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
    final statusSteps = [
      {"label": "Order received", "icon": Icons.check_circle, "done": true},
      {"label": "Cooking your order", "icon": Icons.store_mall_directory_sharp, "done": true},
      {"label": "Courier is picking up order", "icon": Icons.person, "done": true},
      {"label": "Order delivered", "icon": Icons.home, "done": false},
    ];

    return Scaffold(

      appBar: AppBar(
        title: const Text('Order Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID
            Row(
              children: [
                Image.asset(
                  'assets/images/order.png',
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 4,),
                Column(
                  children: [

                    const Text("Order ID", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                    const SizedBox(height: 2),
                    const Text("#2570-6432",style: TextStyle(fontSize: 12)),
                    const SizedBox(height: 2),
                    const Text("25m", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Order status steps
            Column(
              children: List.generate(statusSteps.length, (index) {
                final step = statusSteps[index];
                final isDone = step["done"] as bool;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Icon(
                          size: 35,
                          step["icon"] as IconData,
                          color: isDone ? Colors.green : Colors.grey,

                        ),
                        if (index != statusSteps.length - 1)
                          Container(
                            width: 4,
                            height: 35,
                            color: isDone ? Colors.green : Colors.grey,
                          ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(step["label"] as String,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                    ),
                  ],
                );
              }),
            ),

            const SizedBox(height: 40),

            // Delivery Hero Info
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1),
              ),
              elevation: 1,
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Delivery Hero',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Row(
                          children: const [
                            Text(
                              'Aleksandr V.',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.star, color: Colors.yellow, size: 18),
                            Text('4.9'),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        // Call action
                      },
                      icon: const Icon(Icons.phone, color: Colors.green),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ChatScreen()),
                        );
                      },
                      icon: const Icon(Icons.message, color: Colors.orangeAccent),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            const SizedBox(height: 10),
            Text('Your Location '),
            const SizedBox(height: 5),

            // Location
            Row(
              children: const [

                Icon(Icons.location_pin, color: Colors.green),
                SizedBox(width: 8),
                Expanded(child: Text("123 Al-Madina Street, Abdali, Amman, Jordan")),
              ],
            ),

            const Spacer(),

            // Live Track Button
            Center(
              child: SizedBox(
                width: 300,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>LocationTracking ()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Live Track'),
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
        bottomNavigationBar: BottomNavigationTrack(
          context: context,
          isDark: themeProvider.isDarkMode,
          cartItems: _cartItems,
          onAddToCart: _addToCart,
        activeIndex: 3,)
    );
  }
}
