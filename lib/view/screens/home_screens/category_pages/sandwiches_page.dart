import 'package:flutter/material.dart';
import '../../../../data/models/sandwich_model.dart';
import '../../../widgets/header_widget.dart';
import '../../../widgets/search_bar_widget.dart';
import '../favorites_screen.dart';
import '../history_screen.dart';
import '../home_screen.dart';
import '../main_screen.dart';
import '../profile_screen.dart';


class SandwichesPage extends StatefulWidget {
  const SandwichesPage({super.key});

  @override
  State<SandwichesPage> createState() => _SandwichesPageState();
}

class _SandwichesPageState extends State<SandwichesPage> {
  final List<SandwichItem> _sandwichItems = [
    SandwichItem(
      name: 'Chicken Club',
      price: 15.0,
      imagePath: 'assets/images/chicken_club.jpg',
      description: 'Grilled chicken with bacon, lettuce, and tomato',
    ),
    SandwichItem(
      name: 'BLT Sandwich',
      price: 12.5,
      imagePath: 'assets/images/blt_sandwich.jpg',
      description: 'Classic bacon, lettuce, and tomato on toasted bread',
    ),
    SandwichItem(
      name: 'Tuna Melt',
      price: 14.0,
      imagePath: 'assets/images/tuna_melt.jpg',
      description: 'Tuna salad with melted cheese on grilled bread',
    ),
    SandwichItem(
      name: 'Veggie Wrap',
      price: 11.5,
      imagePath: 'assets/images/veggie_wrap.jpg',
      description: 'Fresh vegetables with hummus in a whole wheat wrap',
    ),
    SandwichItem(
      name: 'Grilled Cheese',
      price: 10.0,
      imagePath: 'assets/images/grilled_cheese.jpg',
      description: 'Triple cheese blend melted between buttery bread',
    ),
    SandwichItem(
      name: 'Turkey Avocado',
      price: 16.5,
      imagePath: 'assets/images/turkey_avocado.jpg',
      description: 'Sliced turkey with avocado, sprouts, and aioli',
    ),
  ];

  // Set to 2 for shopping cart (current page is related to food)
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    // Don't navigate if we're already on the selected index
    if (index == _selectedIndex) {
      return;
    }

    // Handle navigation based on the index
    switch (index) {
      case 0:
      // Navigate to Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
        break;
      case 1:
      // Navigate to Favorites
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FavoritesScreen()),
        );
        break;
      case 2:
      // Already on food screen, no need to navigate
        break;
      case 3:
      // Navigate to History
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HistoryScreen()),
        );
        break;
      case 4:
      // Navigate to Profile
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
    }
  }

  void _showAddedToFavoritesSnackbar(String sandwichName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$sandwichName added to favorites!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 3 : 2;

    return WillPopScope(
      // Handle back button to ensure proper navigation
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        return false; // Prevent default back behavior
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
                      final item = _sandwichItems[index];
                      return SandwichCard(
                        item: item,
                        onFavoritePressed: () {
                          _showAddedToFavoritesSnackbar(item.name);
                        },
                      );
                    },
                    childCount: _sandwichItems.length,
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

class SandwichCard extends StatelessWidget {
  final SandwichItem item;
  final VoidCallback onFavoritePressed;

  const SandwichCard({
    super.key,
    required this.item,
    required this.onFavoritePressed,
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
                onPressed: () {},
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