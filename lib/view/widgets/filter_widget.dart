import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _priceRange = const RangeValues(0, 100);
  double _discountValue = 0; // Changed from RangeValues to single value
  String? _selectedCategory;
  String? _selectedLocation;
  final Set<String> _selectedDishes = {};

  final List<String> categories = ['Fast Food', 'Sea Food', 'Dessert'];
  final List<String> locations = ['1 KM', '5 KM', '10 KM'];
  final List<String> dishes = [
    'Tuna Tartare',
    'Spicy Crub Cakes',
    'Seafood Paella',
    'Clam Chowder',
    'Miso-Glazed Cod',
    'Lobster Thermidor'
  ];

  void _resetFilters() {
    setState(() {
      _priceRange = const RangeValues(0, 100);
      _discountValue = 0;
      _selectedCategory = null;
      _selectedLocation = null;
      _selectedDishes.clear();
    });
  }

  void _applyFilters() {
    print('Applied Filters:');
    print('Price Range: \$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}');
    print('Discount: ${_discountValue.toInt()}%');
    print('Selected Category: $_selectedCategory');
    print('Selected Location: $_selectedLocation');
    print('Selected Dishes: $_selectedDishes');

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Price Range Section - Now with green slider
            const Text('Price range', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Min/Max labels and values row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Min column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Min', style: TextStyle(color: Colors.grey, fontSize: 18)),
                        SizedBox(height: 4),
                        Text('\$${_priceRange.start.toInt()}',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    // Max column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Max', style: TextStyle(color: Colors.grey, fontSize: 18)),
                        SizedBox(height: 4),
                        Text('\$${_priceRange.end.toInt()}',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                // Slider
                RangeSlider(
                  values: _priceRange,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey[300],
                  onChanged: (RangeValues values) {
                    setState(() {
                      _priceRange = values;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Discount Section - Now single slider
            const Text('Discount', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('${_discountValue.toInt()}%',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: _discountValue,
              min: 0,
              max: 100,
              divisions: 10,
              activeColor: Colors.green, // Green slider color
              inactiveColor: Colors.grey[300],
              label: '${_discountValue.toInt()}%',
              onChanged: (double value) {
                setState(() {
                  _discountValue = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Category Section - No checkmark, just color change
            const Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: categories.map((category) {
                return ChoiceChip(
                  label: Text(category),
                  selected: _selectedCategory == category,
                  selectedColor: Colors.green,
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color: _selectedCategory == category ? Colors.white : Colors.black,
                  ),
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = selected ? category : null;
                    });
                  },
                  showCheckmark: false, // No checkmark

                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Location Section - No checkmark, just color change
            const Text('Location', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10, // Exactly 5 pixels between chips
              children: locations.map((location) {
                return ChoiceChip(
                  label: Text(location),
                  selected: _selectedLocation == location,
                  selectedColor: Colors.green,
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color: _selectedLocation == location ? Colors.white : Colors.black,
                  ),
                  onSelected: (selected) {
                    setState(() {
                      _selectedLocation = selected ? location : null;
                    });
                  },
                  showCheckmark: false,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Dish Section - No checkmark, just color change
            // Dish Section
            const Text('Dish', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: dishes.map((dish) {
                return ChoiceChip(
                  label: Text(dish),
                  selected: _selectedDishes.contains(dish),
                  selectedColor: Colors.green,
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color: _selectedDishes.contains(dish) ? Colors.white : Colors.black,
                  ),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedDishes.add(dish);
                      } else {
                        _selectedDishes.remove(dish);
                      }
                    });
                  },
                  showCheckmark: false,
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: _resetFilters,
                child: const Text('Reset', style: TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Apply', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
