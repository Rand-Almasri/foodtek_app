import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AutoChangingBanner extends StatefulWidget {
  @override
  _AutoChangingBannerState createState() => _AutoChangingBannerState();
}

class _AutoChangingBannerState extends State<AutoChangingBanner> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> _adImages = [
    'assets/images/ads1.jpg',
    'assets/images/ads2.jpg',
    'assets/images/ads3.jpg',
    'assets/images/ads4.jpg',
    'assets/images/ads5.jpg',
  ];

  @override
  void initState() {
    super.initState();
    // Auto-play functionality
    Future.delayed(Duration(seconds: 3), _autoPlay);
  }

  void _autoPlay() {
    if (_currentIndex < _adImages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    } else {
      _pageController.jumpToPage(0);
    }
    Future.delayed(Duration(seconds: 3), _autoPlay);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        Container(
          width: MediaQuery.of(context).size.width, // Use full width
          height: 125, // Set a reasonable height
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: _adImages.map((imagePath) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imagePath,
                  width: MediaQuery.of(context).size.width, // Use full width
                  height: 120,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 10),
        SmoothPageIndicator(
          controller: _pageController,
          count: _adImages.length,
          effect: WormEffect(
            activeDotColor: Colors.green,
            dotColor: Colors.grey,
            dotWidth: 10,
            dotHeight: 10,
          ),
        ),
      ],
    );
  }
}
