import 'package:flutter/material.dart';
import '../../../../data/models/burger_model.dart';
import '../../../../data/models/favorite_item.dart';
import '../../../widgets/category_chips_widget.dart';
import '../../../widgets/food_order_widget.dart';
import '../../../widgets/header_widget.dart';
import '../../../widgets/search_bar_widget.dart';
import '../favorites_screen.dart';
import '../history_screen.dart';
import '../home_screen.dart';
import '../main_screen.dart';
import '../profile_screen.dart';

class BurgerPage extends StatefulWidget {
  const BurgerPage({super.key});

  @override
  State<BurgerPage> createState() => _BurgerPageState();
}

class _BurgerPageState extends State<BurgerPage> {
  final List<BurgerItem> _burgerItems = [
    BurgerItem(
      name: 'Classic Burger',
      price: 18.5,
      imagePath: 'assets/images/chickenburger.jpg',
      description: 'Juicy beef patty with fresh lettuce and tomato',
      restaurant: 'Burger'
    ),
    BurgerItem(
      name: 'Cheese Burger',
      price: 21.0,
      imagePath: 'assets/images/cheseburger.jpg',
      description: 'Classic burger with melted cheddar cheese',
        restaurant: 'Burger'
    ),
    BurgerItem(
      name: 'Veggie Burger',
      price: 17.0,
      imagePath: 'assets/images/veggie_burger.jpg',
      description: 'Plant-based patty with avocado and sprouts',
        restaurant: 'Burger'
    ),
    BurgerItem(
      name: 'BBQ Bacon Burger',
      price: 24.5,
      imagePath: 'assets/images/bbq_burger.jpg',
      description: 'Beef patty topped with bacon and BBQ sauce',
        restaurant: 'Burger'
    ),
    BurgerItem(
      name: 'Mushroom Swiss',
      price: 22.0,
      imagePath: 'assets/images/mushroom_burger1.jpg',
      description: 'Beef burger with sautéed mushrooms and Swiss cheese',
        restaurant: 'Burger'
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

  void _showAddedToFavoritesSnackbar(String burgerName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$burgerName added to favorites!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showOrderDialog(BurgerItem burgerItem) {
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
              name: burgerItem.name,
              price: burgerItem.price,
              imagePath: burgerItem.imagePath,
              description: burgerItem.description,
              restaurant: burgerItem.restaurant

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
              const CategoryChipsWidget(selectedCategory: '🍔 Burger'),
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
                      final item = _burgerItems[index];
                      return BurgerCard(
                        item: item,
                        onFavoritePressed: () {
                          _showAddedToFavoritesSnackbar(item.name);
                        },
                        onOrderPressed: () {
                          _showOrderDialog(item);
                        },
                      );
                    },
                    childCount: _burgerItems.length,
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

class BurgerCard extends StatelessWidget {
  final BurgerItem item;
  final VoidCallback onFavoritePressed;
  final VoidCallback onOrderPressed;

  const BurgerCard({
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