import 'package:flutter/material.dart';

import 'notification_widget.dart';

class HeaderWidget extends StatelessWidget {
  String currentLocation = 'Jl. Soekarno Hatta 15A';


  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Text('Current location', style: TextStyle(color: Colors.grey)),
                Text(currentLocation,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
          ],
        ),

        // Search Bar with Filter


      ),


    );
  }
}