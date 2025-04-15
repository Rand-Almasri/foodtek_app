import 'package:flutter/material.dart';
import 'package:foodtek_app/core/constants/constant_colors.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _nameController = TextEditingController(text: 'Raya Daboor');
  final _cardNumberController = TextEditingController(text: '6578 8756 4238 92764');
  final _expiryController = TextEditingController(text: '04/23');
  final _cvcController = TextEditingController(text: '875');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500), // for tablets & responsiveness
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Add Card',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Image.asset(
                      'assets/images/card.png',
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
                    SizedBox(height: 20),

                    // Name
                    Align(alignment: Alignment.centerLeft, child: Text('Name')),
                    SizedBox(height: 4),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),

                    SizedBox(height: 15),

                    // Card Number
                    Align(alignment: Alignment.centerLeft, child: Text('Card Number')),
                    SizedBox(height: 4),
                    TextField(
                      controller: _cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Image.asset(
                            'assets/images/minicard.png',
                            width: 40,
                            height: 20,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

                    // Expiry & CVC
                    Row(
                      children: [
                        Expanded(child: Text('Expiry')),
                        SizedBox(width: 16),
                        Expanded(child: Text('CVC')),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _expiryController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _cvcController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ],
                    ),


                    // Info Text
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 55),
                      child: Center(
                        child: Text(
                          'We will send you an order details to your email after the successful payment.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),

                    // Pay Button
                    SizedBox(
                      width: 300,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Handle payment logic
                        },
                        icon: Icon(Icons.lock),
                        label: Text('Pay for the order', style: TextStyle(fontSize: 16)),
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
