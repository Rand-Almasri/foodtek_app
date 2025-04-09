import 'package:flutter/material.dart';
import '../../../core/constants/constant_colors.dart';
import '../../../data/models/order_history_model.dart';
import '../../widgets/history_item_widget.dart';
import '../../widgets/empty_history_widget.dart';
import '../../widgets/header_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<OrderHistoryModel> historyItems = [
    OrderHistoryModel(
      id: '1',
      name: 'Chicken Burger',
      restaurant: 'Burger Factory LTD',
      price: 20,
      imagePath: 'assets/images/chickenburger.jpg',
      date: '25.3.2024',
    ),
    OrderHistoryModel(
      id: '2',
      name: 'Onion Pizza',
      restaurant: 'Pizza Palace',
      price: 15,
      imagePath: 'assets/images/onion_pizza.jpg',
      date: '25.3.2024',
    ),
    OrderHistoryModel(
      id: '3',
      name: 'Spicy Shawarma',
      restaurant: 'Hot Cool Spot',
      price: 15,
      imagePath: 'assets/images/spicy_shawarma.jpg',
      date: '25.3.2024',
    ),
  ];

  bool get hasHistoryItems => historyItems.isNotEmpty;

  void deleteItem(int index) {
    setState(() {
      historyItems.removeAt(index);
    });
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

            // History Title Centered
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              alignment: Alignment.center,
              child: const Text(
                'History',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Divider line
            Container(
              width: 100,
              height: 2,
              color: AppColors.primaryGreen,
              margin: const EdgeInsets.only(bottom: 16),
            ),

            const SizedBox(height: 10),

            // Content - Either history items or empty state
            Expanded(
              child: hasHistoryItems
                  ? ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: historyItems.length + 1, // +1 for "Load More"
                itemBuilder: (context, index) {
                  if (index < historyItems.length) {
                    final item = historyItems[index];
                    return Dismissible(
                      key: Key(item.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        color: Colors.yellow.shade700,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (direction) {
                        deleteItem(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.name} removed from history'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: HistoryItemWidget(
                        imagePath: item.imagePath,
                        title: item.name,
                        subTitle: item.restaurant,
                        price: item.price,
                        date: item.date,
                      ),
                    );
                  } else {
                    // Last item is "Load More"
                    return const Column(
                      children: [
                        SizedBox(height: 24),
                        Center(
                          child: Text(
                            'Load More..',
                            style: TextStyle(
                              color: AppColors.primaryGreen,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    );
                  }
                },
              )
                  : const EmptyHistoryWidget(),
            ),
          ],
        ),
      ),
    );
  }
}