import 'package:flutter/material.dart';

class CategoryChipsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 36,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _buildCategoryChip('All', true),
            _buildCategoryChip('🍔 Burger', false),
            _buildCategoryChip('🍕 Pizza', false),
            _buildCategoryChip('🥪 Sandwiches', false),
            _buildCategoryChip('🥤 Drinks', false),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Chip(
        label: Text(label),
        backgroundColor: isSelected ? Colors.green : Colors.grey[200],
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}