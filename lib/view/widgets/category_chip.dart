import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final String? icon;
  final bool isSelected;

  const CategoryChip({
    super.key,
    required this.label,
    this.icon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Chip(
        label: Text(label),
        avatar: icon != null ? Text(icon!) : null,
        backgroundColor: isSelected ? Colors.green : Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
        side: BorderSide(
          color: isSelected ? Colors.green : Colors.grey.shade300,
        ),
      ),
    );
  }
}