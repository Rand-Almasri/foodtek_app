import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current location', style: TextStyle(color: Colors.grey)),
                  Text('Jl. Soekarno Hatta 15A',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Icon(Icons.notifications_none)
            ],
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search menu, restaurant or etc',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(height: 20),
          SectionTitle(title: 'Top Rated'),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FoodCard(title: 'Chicken burger', rating: 3.8, price: 20.00),
                FoodCard(title: 'Cheese burger', rating: 4.5, price: 15.00),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class SectionTitle extends StatelessWidget {
  final String title;
  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class FoodCard extends StatelessWidget {
  final String title;
  final double rating;
  final double price;
  FoodCard({required this.title, required this.rating, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(title),
          Text('⭐ $rating'),
          Text('\$ $price'),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  CategoryChip({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: isSelected ? Colors.green : Colors.grey[300],
    );
  }
}