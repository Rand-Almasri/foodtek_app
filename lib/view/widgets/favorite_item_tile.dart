import 'package:flutter/material.dart';
import 'package:foodtek_app/data/models/favorite_item.dart';

class FavoriteItemTile extends StatefulWidget {
  final FavoriteItem item;
  final VoidCallback onOrderPressed;
  final VoidCallback onRemoveFromFavorites;
  final bool isFavorite;
  final Function(int) onAddToCart;

  const FavoriteItemTile({
    Key? key,
    required this.item,
    required this.onOrderPressed,
    required this.onRemoveFromFavorites,
    required this.isFavorite,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  State<FavoriteItemTile> createState() => _FavoriteItemTileState();
}

class _FavoriteItemTileState extends State<FavoriteItemTile> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  void didUpdateWidget(covariant FavoriteItemTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFavorite != oldWidget.isFavorite) {
      setState(() {
        _isFavorite = widget.isFavorite;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Are you sure you want to remove it from favorites?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
            ),
          );
        },
      ) ?? false;

      if (confirmed && mounted) {
        widget.onRemoveFromFavorites();
      }
    } else {
      setState(() {
        _isFavorite = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isFavorite) {
      return const SizedBox.shrink();
    }

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
                      backgroundImage: AssetImage(widget.item.imagePath),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.green,
                      ),
                      iconSize: 24,
                      onPressed: _toggleFavorite,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.item.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${widget.item.price.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.green),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: widget.onOrderPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 36),
              ),
              child: const Text(
                'Order Now',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
