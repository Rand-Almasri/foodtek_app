import 'package:flutter/material.dart';
import '../../widgets/category_chips_widget.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/promo_banner_widget.dart';
import '../../widgets/recommended_widget.dart';
import '../../widgets/search_bar_widget.dart';
import '../../widgets/top_rated.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _favoriteItems = [];

  void _addToFavorites(Map<String, dynamic> item) {
    setState(() {
      if (!_favoriteItems.any((favorite) => favorite['name'] == item['name'])) {
        _favoriteItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: CustomScrollView(
            slivers: [
              HeaderWidget(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0), // Adjust as needed
                  child: SearchBarWidget(),
                ),
              ),
              CategoryChipsWidget(),
              SliverToBoxAdapter(
                 // Adjust as needed
                  child: AutoChangingBanner(),
                ),

             // AutoChangingBanner(),
              SliverToBoxAdapter(
                child: TopRatedWidget(
                  onFavoriteAdd: _addToFavorites,
                ),
              ),
              RecommendedWidget(),

            ],
          ),
        ),
      ),
    );
  }
}
