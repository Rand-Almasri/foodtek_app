import 'package:flutter/material.dart';

import 'notification_widget.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Current location', style: TextStyle(color: Colors.grey)),
              Text('Jl. Soekarno Hatta 15A',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true, // Still needed for custom height
                backgroundColor: Colors.transparent,
                builder: (context) => Container(
                  height: MediaQuery.of(context).size.height * 0.72, // 50% of screen height
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: NotificationScreen(),
                ),
              );
            },

          ),
        ],
      ),
    );
  }
}