import 'package:flutter/material.dart';
import '../../../../data/models/pizza_model.dart';
import '../../../../data/models/favorite_item.dart';
import '../../../widgets/category_chips_widget.dart';
import '../../../widgets/header_widget.dart';
import '../../../widgets/search_bar_widget.dart';
import '../../../widgets/food_order_widget.dart';
import '../favorites_screen.dart';
import '../history_screen.dart';
import '../home_screen.dart';
import '../main_screen.dart';
import '../profile_screen.dart';

class PizzaPage extends StatefulWidget {
  const PizzaPage({super.key});

  @override
  State<PizzaPage> createState() => _PizzaPageState();
}

class _PizzaPageState extends State<PizzaPage> {
  final List<PizzaItem> _pizzaItems = [
    PizzaItem(
      name: 'Pepperoni Pizza',
      price: 29.0,
      imagePath: 'assets/images/pepperoni.jpg',
      description: 'Classic pizza with pepperoni and tomato sauce',
      restaurant: 'Pizza'
    ),
    PizzaItem(
      name: 'Pizza Cheese',
      price: 23.0,
      imagePath: 'assets/images/bigpizza.jpg',
      description: 'Pizza with layers of melted cheese',
        restaurant: 'Pizza'

    ),
    PizzaItem(
      name: 'Peppy Paneer',
      price: 13.0,
      imagePath: 'assets/images/peppy-paneer.jpg',
      description: 'Indian-style pizza with paneer and spices',
        restaurant: 'Pizza'

    ),
    PizzaItem(
      name: 'Mexican Green Wave',
      price: 23.0,
      imagePath: 'assets/images/Mexican_Green_Wave.jpg',
      description: 'A pizza with bold Mexican flavors, loaded with crunchy onions',
        restaurant: 'Pizza'

    ),
  ];

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      return;
    }

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FavoritesScreen(cartItems: [], onAddToCart: (CartItem ) {  },)),
        );
        break;
      case 2:
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HistoryScreen()),
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
    }
  }

  void _showAddedToFavoritesSnackbar(String pizzaName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$pizzaName added to favorites!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showOrderDialog(PizzaItem pizzaItem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: FoodOrderWidget(
            item: FavoriteItem(
              name: pizzaItem.name,
              price: pizzaItem.price,
              imagePath: pizzaItem.imagePath,
              description: pizzaItem.description,
              restaurant: pizzaItem.restaurant
            ),
            onBackPressed: () => Navigator.pop(context),
            onAddToCart: (orderDetails) {
              // Handle the order here
              print('Added to cart: ${orderDetails.item.name}');
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('added ${orderDetails.item.name} to cart'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 3 : 2;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const HeaderWidget(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: SearchBarWidget(),
                    ),
                  ],
                ),
              ),
              const CategoryChipsWidget(selectedCategory: '🍕 Pizza'),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: _calculateChildAspectRatio(context),
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final item = _pizzaItems[index];
                      return PizzaCard(
                        item: item,
                        onFavoritePressed: () {
                          _showAddedToFavoritesSnackbar(item.name);
                        },
                        onOrderPressed: () {
                          _showOrderDialog(item);
                        },
                      );
                    },
                    childCount: _pizzaItems.length,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFFDFF3D1),
          selectedItemColor: const Color(0xFF2EA44F),
          unselectedItemColor: Colors.black54,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: "Favorites",
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFF2EA44F),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.shopping_cart, color: Colors.white),
              ),
              label: "",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "History",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  double _calculateChildAspectRatio(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return screenWidth > 600 ? (screenWidth > screenHeight ? 1.1 : 0.85)
        : (screenHeight > screenWidth ? 0.75 : 0.85);
  }
}

class PizzaCard extends StatelessWidget {
  final PizzaItem item;
  final VoidCallback onFavoritePressed;
  final VoidCallback onOrderPressed;

  const PizzaCard({
    super.key,
    required this.item,
    required this.onFavoritePressed,
    required this.onOrderPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.green, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Stack(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(item.imagePath),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.green,
                      ),
                      onPressed: onFavoritePressed,
                      iconSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 36,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 36),
                ),
                onPressed: onOrderPressed,
                child: const Text(
                  'ORDER NOW',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}