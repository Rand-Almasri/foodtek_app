import 'package:flutter/material.dart';

import '../../core/constants/constant_colors.dart';

class EmptyHistoryWidget extends StatelessWidget {
  const EmptyHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty cart image
          Image.asset(
            'assets/images/empty_history.jpg',
            height: 250,
          ),
          const SizedBox(height: 30),
          // Empty text
          const Text(
            'History Empty',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Description
          const Text(
            "You don't have order any foods before",
            style: TextStyle(
              fontSize: 16,
              color: AppColors.secondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}