import 'package:flutter/material.dart';

import '../../../core/constants/constant_colors.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              // for tablets & responsiveness
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Text(
                          'checkout ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Column(
                      children: [
                        SizedBox(height: 80),

                        Image.asset(
                          'assets/images/done_cheakout.png',
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 55),
                      child: Center(
                        child: Text(
                          'Your Order Done Successfully',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 55),
                      child: Center(
                        child: Text(
                          'you will get your order within 12min.\n thanks for using our services',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Pay Button
                    SizedBox(
                      width: 300,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Handle payment logic
                        },

                        label: Text('Track Your Order', style: TextStyle(
                            fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: AppColors.primaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}