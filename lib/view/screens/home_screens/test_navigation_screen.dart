import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';

class TestNavigationScreen extends StatelessWidget {
  const TestNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Navigation')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.setLocation),
              child: const Text('Go to Set Location Screen'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.checkout),
              child: const Text('Go to Checkout Screen'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.addCard),
              child: const Text('Go to Add Card Screen'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.orderSuccess),
              child: const Text('Go to Order Success Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
