import 'package:flutter/material.dart';

class TopRatedWidget extends StatelessWidget {
  final Function(Map<String, dynamic>) onFavoriteAdd;

  const TopRatedWidget({Key? key, required this.onFavoriteAdd}) : super(key: key);

  Widget _buildTopRatedItem(
      BuildContext context,
      String name,
      double price,
      double rating,
      String imageAsset
      ) {
    return Container(
      width: 150,
      height: 100,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Image.asset(
                    imageAsset,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 2,
                left: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        onFavoriteAdd({
                          'name': name,
                          'price': price,
                          'imagePath': imageAsset,
                          'rating': rating
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Added to Cart'))
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Text(
                              '+',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Rated',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 14),
            children: [
              _buildTopRatedItem(context, 'Chicken burger', 20.0, 3.8, 'assets/images/chickenburger.jpg'),
              _buildTopRatedItem(context, 'Cheese burger', 15.0, 4.5, 'assets/images/cheseburger.jpg'),
              _buildTopRatedItem(context, 'Chicken burger', 20.0, 3.8, 'assets/images/chickenburger2.jpg'),
            ],
          ),
        ),
      ],
    );
  }
}