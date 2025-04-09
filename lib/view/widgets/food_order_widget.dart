import 'package:flutter/material.dart';

import '../../data/models/favorite_item.dart';

class FoodOrderWidget extends StatefulWidget {
  final FavoriteItem item;
  final VoidCallback onBackPressed;
  final Function(OrderDetails) onAddToCart; // Modified to accept OrderDetails

  const FoodOrderWidget({
    Key? key,
    required this.item,
    required this.onBackPressed,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  State<FoodOrderWidget> createState() => _FoodOrderWidgetState();
}

class _FoodOrderWidgetState extends State<FoodOrderWidget> {
  double _spiciness = 0;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          _buildHeader(),
          _buildFoodImage(),
          _buildFoodDetails(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, size: 24),
            onPressed: widget.onBackPressed,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
          Text(
            'Order Details',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            widget.item.imagePath,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey[200],
              child: const Center(
                child: Icon(Icons.fastfood, size: 40, color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFoodDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleAndRating(),
          const SizedBox(height: 12),
          _buildPriceAndDescription(),
          const SizedBox(height: 16),
          _buildControlsRow(),
          const SizedBox(height: 24),
          _buildAddToCartButton(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTitleAndRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.item.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            ...List.generate(
                4, (_) => const Icon(Icons.star, color: Colors.amber, size: 18)),
            const Icon(Icons.star_border, color: Colors.amber, size: 18),
            const SizedBox(width: 6),
            Text(
              '4.5 (89 reviews)',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceAndDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\$${widget.item.price.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.item.description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
            height: 1.4,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildControlsRow() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Spice Level',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Slider(
                value: _spiciness,
                onChanged: (value) => setState(() => _spiciness = value),
                min: 0,
                max: 10,
                divisions: 10,
                label: _spiciness.round().toString(),
                activeColor: Colors.green,
                inactiveColor: Colors.grey[300],
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quantity',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 36,
                      height: 32,
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            if (_quantity > 1) _quantity--;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Colors.green),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Icon(Icons.remove, size: 16),
                      ),
                    ),
                    const SizedBox(width: 6),
                    SizedBox(
                      width: 28,
                      child: Text(
                        '$_quantity',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    SizedBox(
                      width: 36,
                      height: 32,
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Colors.green),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Icon(Icons.add, size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return ElevatedButton(
      onPressed: () {
        final order = OrderDetails(
          item: widget.item,
          quantity: _quantity,
          spiciness: _spiciness.round(),
        );

        widget.onAddToCart(order); // Call with OrderDetails

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added ${widget.item.name} to cart (x$_quantity)'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: const Text(
        'ADD TO CART ',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class OrderDetails {
  final FavoriteItem item;
  final int quantity;
  final int spiciness;

  OrderDetails({
    required this.item,
    required this.quantity,
    required this.spiciness,
  });
}