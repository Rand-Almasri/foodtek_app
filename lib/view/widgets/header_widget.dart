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
          // Location section
          Expanded(
            child: Row(
              children: [
                Icon(Icons.location_pin, color: Colors.green),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Current location",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Jl. Soekarno Hatta 15A...",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

          // Notification icon
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => Container(
                  height: MediaQuery.of(context).size.height * 0.72,
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
