import 'package:flutter/material.dart';
import '../screens/home_screens/category_pages/burger_page.dart';
import '../screens/home_screens/category_pages/drinks_page.dart';
import '../screens/home_screens/category_pages/pizza_page.dart';
import '../screens/home_screens/category_pages/sandwiches_page.dart';

class CategoryChipsWidget extends StatelessWidget {
  final String? selectedCategory;

  const CategoryChipsWidget({
    super.key,
    this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 34,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            buildCategoryChip(context, 'All', selectedCategory == 'All'),
            buildCategoryChip(context, '🍔 Burger', selectedCategory == '🍔 Burger', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BurgerPage()),
              );
            }),
            buildCategoryChip(context, '🍕 Pizza', selectedCategory == '🍕 Pizza', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PizzaPage()),
              );
            }),
            buildCategoryChip(context, '🥪 Sandwiches', selectedCategory == '🥪 Sandwiches', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SandwichesPage()),
              );
            }),
            buildCategoryChip(context, '🥤 Drinks', selectedCategory == '🥤 Drinks', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DrinksPage()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryChip(
      BuildContext context,
      String label,
      bool isSelected, {
        VoidCallback? onTap,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Chip(
          label: Text(label),
          backgroundColor: isSelected ? Colors.green : Colors.grey[200],
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}