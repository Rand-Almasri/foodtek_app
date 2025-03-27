import 'package:flutter/material.dart';

class FoodOrderWidget extends StatefulWidget {
  final String name;
  final double price;
  final String imagePath;
  final String description;

  const FoodOrderWidget({
    Key? key,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.description,
  }) : super(key: key);

  @override
  _FoodOrderWidgetState createState() => _FoodOrderWidgetState();
}

class _FoodOrderWidgetState extends State<FoodOrderWidget> {
  double _spiciness = 0;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color(0xFF25AE4B),
      appBar: AppBar(
        title: Text('Order Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    widget.imagePath,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: Center(child: Icon(Icons.fastfood)),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    Icon(Icons.star_border, color: Colors.amber, size: 20),
                    SizedBox(width: 8),
                    Text('4.5 (89 reviews)'),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  '\$${widget.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Spicy', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Slider(
                        value: _spiciness,
                        onChanged: (value) {
                          setState(() {
                            _spiciness = value;
                          });
                        },
                        min: 0,
                        max: 10,
                        divisions: 10,
                        activeColor: Colors.green,
                        inactiveColor: Colors.grey[300],
                        label: _spiciness.round().toString(),
                      ),
                    ),
                    SizedBox(width: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Minus button (unchanged)
                        SizedBox(
                          width: 45,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                if (_quantity > 1) _quantity--;
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                side: BorderSide(color: Colors.green),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: Icon(Icons.remove, size: 16),
                          ),
                        ),
                        // Quantity display
                        SizedBox(width: 12),
                        Text(
                          '$_quantity',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 10),
                        // Plus button (modified)
                        SizedBox(
                          width: 45,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _quantity++;
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.green, // Green background
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                side: BorderSide(color: Colors.green), // Green border to match
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: Icon(Icons.add, size: 18, color: Colors.white), // White icon
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    // Add to cart logic
                    print('Added to cart: ${widget.name}, Quantity $_quantity, Spiciness $_spiciness');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}