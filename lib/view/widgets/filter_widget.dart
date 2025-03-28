import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _priceRange = const RangeValues(0, 100);
  double _discountValue = 0;
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
    Navigator.pop(context, {
      'priceRange': _priceRange,
      'discount': _discountValue,
      'category': _selectedCategory,
      'location': _selectedLocation,
      'dishes': _selectedDishes.toList(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Price Range Section
            _buildSectionHeader('Price range'),
            const SizedBox(height: 10),
            _buildPriceRangeSection(),
            const SizedBox(height: 20),

            // Discount Section
            _buildSectionHeader('Discount'),
            const SizedBox(height: 10),
            Text('${_discountValue.toInt()}%',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: _discountValue,
              min: 0,
              max: 100,
              divisions: 10,
              activeColor: Colors.green,
              inactiveColor: Colors.grey[300],
              label: '${_discountValue.toInt()}%',
              onChanged: (double value) {
                setState(() => _discountValue = value);
              },
            ),
            const SizedBox(height: 20),

            // Category Section
            _buildSectionHeader('Category'),
            const SizedBox(height: 10),
            _buildChipSelection(
              items: categories,
              selected: _selectedCategory,
              onSelected: (selected, item) {
                setState(() => _selectedCategory = selected ? item : null);
              },
            ),
            const SizedBox(height: 20),

            // Location Section
            _buildSectionHeader('Location'),
            const SizedBox(height: 10),
            _buildChipSelection(
              items: locations,
              selected: _selectedLocation,
              onSelected: (selected, item) {
                setState(() => _selectedLocation = selected ? item : null);
              },
            ),
            const SizedBox(height: 20),

            // Dish Section
            _buildSectionHeader('Dish'),
            const SizedBox(height: 10),
            _buildChipSelection(
              items: dishes,
              selected: null,
              isMultiSelect: true,
              selectedItems: _selectedDishes,
              onSelected: (selected, item) {
                setState(() {
                  selected ? _selectedDishes.add(item) : _selectedDishes.remove(item);
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title, style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ));
  }

  Widget _buildPriceRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPriceLabel('Min', '\$${_priceRange.start.toInt()}'),
            _buildPriceLabel('Max', '\$${_priceRange.end.toInt()}'),
          ],
        ),
        const SizedBox(height: 12),
        RangeSlider(
          values: _priceRange,
          min: 0,
          max: 100,
          divisions: 10,
          activeColor: Colors.green,
          inactiveColor: Colors.grey[300],
          onChanged: (RangeValues values) {
            setState(() => _priceRange = values);
          },
        ),
      ],
    );
  }

  Widget _buildPriceLabel(String label, String value) {
    return Column(
      crossAxisAlignment: label == 'Min' ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(label, style: TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  Widget _buildChipSelection({
    required List<String> items,
    required Function(bool, String) onSelected,
    String? selected,
    Set<String>? selectedItems,
    bool isMultiSelect = false,
  }) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: items.map((item) {
        final isSelected = isMultiSelect
            ? selectedItems?.contains(item) ?? false
            : selected == item;

        return ChoiceChip(
          label: Text(item),
          selected: isSelected,
          selectedColor: Colors.green,
          backgroundColor: Colors.grey[200],
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 14,
          ),
          onSelected: (selected) => onSelected(selected, item),
          showCheckmark: false,
        );
      }).toList(),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: _resetFilters,
            child: const Text('RESET', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: _applyFilters,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('APPLY', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}