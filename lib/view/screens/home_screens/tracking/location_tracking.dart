import 'package:flutter/material.dart';
import 'package:foodtek_app/view/screens/home_screens/tracking/Order_details.dart';
import 'package:foodtek_app/view/screens/home_screens/tracking/chat_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme/theme_provider.dart';
import '../../../../core/widgets/bottom_navigation_track.dart';
import '../../../../data/models/cart_item.dart';


class LocationTracking extends StatefulWidget {
  const LocationTracking({super.key});

  @override
  State<LocationTracking> createState() => _LocationTrackingState();
}

class _LocationTrackingState extends State<LocationTracking> {
  GoogleMapController? _mapController;
  bool _loading = true;
  final List<CartItem> _cartItems = [];
  static const LatLng _startLocation = LatLng(-7.98, 112.63);
  static const LatLng _destinationLocation = LatLng(-7.975, 112.65);

  final List<LatLng> _routePoints = [
    _startLocation,
    LatLng(-7.978, 112.64),
    _destinationLocation,
  ];

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    }

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      setState(() => _loading = false);
    }
  }
  void _addToCart(CartItem item) {
    setState(() {
      final existingIndex = _cartItems.indexWhere(
              (cartItem) => cartItem.name == item.name && cartItem.restaurant == item.restaurant);

      if (existingIndex >= 0) {
        _cartItems[existingIndex].quantity += 1;
      } else {
        _cartItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _loading
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
              },
              initialCameraPosition: const CameraPosition(
                target: _startLocation,
                zoom: 14.0,
              ),
              markers: {
                const Marker(
                  markerId: MarkerId('start'),
                  position: _startLocation,
                  infoWindow: InfoWindow(title: 'Pickup'),
                ),
                const Marker(
                  markerId: MarkerId('destination'),
                  position: _destinationLocation,
                  infoWindow: InfoWindow(title: 'Destination'),
                ),
              },
              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  color: Colors.green,
                  width: 5,
                  points: _routePoints,
                ),
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),

            // Search Bar
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Find your location',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Delivery Details Panel
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'On The Way',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  OrderDetailsScreen()),
                            );
                          },
                          child: const Text(
                            'AllDetails',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatusStep('Order Placed', true),
                        _buildStatusStep('On The Way', true),
                        _buildStatusStep('Delivered', false),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/images/avatar.jpg'),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Your Delivery Hero'),
                            Row(
                              children: const [
                                Text('Aleksandr V.'),
                                Icon(Icons.star, color: Colors.yellow, size: 18),
                                Text('4.9'),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.phone, color: Colors.green),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ChatScreen()),
                            );
                          },
                          icon: const Icon(Icons.message, color: Colors.green),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Icon(Icons.location_on, color: Colors.green),
                        SizedBox(width: 5),
                        Text('123 Al-Madina Street, Abdali, Amman, Jordan'),
                      ],
                    ),
                    const SizedBox(height: 10),

                  ],
                ),
              ),
            ),
          ],
        ),
          bottomNavigationBar: BottomNavigationTrack(
            context: context,
            isDark: themeProvider.isDarkMode,
            cartItems: _cartItems,
            onAddToCart: _addToCart,
          activeIndex: 3,)
      ),
    );
  }

  Widget _buildStatusStep(String title, bool isActive) {
    return Column(
      children: [
        Container(
          width: 45,
          height: 5,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: isActive ? Colors.green : Colors.grey,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(color: isActive ? Colors.green : Colors.grey),
        ),
      ],
    );
  }

}
