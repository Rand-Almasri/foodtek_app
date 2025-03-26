import 'package:flutter/material.dart';
import '../../widgets/favorite_item_tile.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  final List<Map<String, dynamic>> _favoriteItems = const [
    {
      'name': 'Pepperoni Pizza',
      'price': 29.0,
      'imagePath': 'assets/images/pepperoni.jpg',
      'description': 'A classic pizza topped with delicious pepperoni slices and tomato sauce.',
    },
    {
      'name': 'Pizza Cheese',
      'price': 23.0,
      'imagePath': 'assets/images/bigpizza.jpg',
      'description': ' pizza covered with layers of gooey melted cheese for a creamy texture',
    },
    {
      'name': 'Peppy Paneer',
      'price': 13.0,
      'imagePath': 'assets/images/peppy-paneer.jpg',
      'description': 'An Indian-style pizza featuring grilled paneer chunks and spicy seasonings',
    },
    {
      'name': 'Mexican Green Wave',
      'price': 23.0,
      'imagePath': 'assets/images/Mexican_Green_Wave.jpg',
      'description': 'A pizza with bold Mexican flavors, loaded with crunchy onions',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current location',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Jl. Soekarno Hatta 15A',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.notifications_none)
                  ],
                ),
              ),
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search menu, restaurant or etc',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),

            // Favorites Title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Text(
                  'Favorites',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Favorites Section
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 0.6,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final item = _favoriteItems[index];
                    return FavoriteItemTile(
                      name: item['name'],
                      price: item['price'],
                      imagePath: item['imagePath'],
                      description: item['description'],
                    );
                  },
                  childCount: _favoriteItems.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}