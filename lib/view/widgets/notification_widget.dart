import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, dynamic>> notifications = [
    {'title': 'Delayed Order:', 'message': "We're sorry! Your order is running late. New ETA: 10:30 PM. Thanks for your patience!", 'icon': Icons.access_time, 'isRead': false},
    {'title': 'Promotional Offer:', 'message': "Craving something delicious? 🍔 Get 20% off on your next order. Use code: YUMMY20.", 'icon': Icons.local_offer, 'isRead': false},
    {'title': 'Out for Delivery:', 'message': "Your order is on the way! 🚗 Estimated arrival: 15 mins. Stay hungry!", 'icon': Icons.delivery_dining, 'isRead': false},
    {'title': 'Order Confirmation:', 'message': "Your order has been placed! 🍟 We're preparing it now. Track your order live!", 'icon': Icons.check_circle, 'isRead': false},
    {'title': 'Delivered:', 'message': "Enjoy your meal! 🔔 Your order has been delivered.", 'icon': Icons.done_all, 'isRead': false},
  ];

  int selectedTab = 0;

  void markAsRead(int index) {
    setState(() {
      notifications[index]['isRead'] = true;
    });
  }

  void deleteAllMessages() {
    setState(() {
      notifications.clear();
    });
  }

  void deleteReadMessages() {
    setState(() {
      notifications.removeWhere((notif) => notif['isRead']);
    });
  }

  @override

  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredNotifications = notifications.where((notif) {
      if (selectedTab == 1) return !notif['isRead'];
      if (selectedTab == 2) return notif['isRead'];
      return true;
    }).toList();

    return Column(
      children: [
        // Add a drag handle at the top
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 8),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
          ),
        ),

        // Add a custom header instead of AppBar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              Text(
                "Notifications",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: Colors.black),
                onSelected: (value) {
                  if (value == 'delete_all') {
                    deleteAllMessages();
                  } else if (value == 'delete_read') {
                    deleteReadMessages();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: 'delete_all', child: Text('Delete All Messages')),
                  PopupMenuItem(value: 'delete_read', child: Text('Delete Read Messages')),
                ],
              ),
            ],
          ),
        ),

        // Rest of your content remains the same
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NotificationTab(
              label: "All",
              isSelected: selectedTab == 0,
              onTap: () => setState(() => selectedTab = 0),
            ),
            SizedBox(width: 18),
            NotificationTab(
              label: "Unread",
              isSelected: selectedTab == 1,
              onTap: () => setState(() => selectedTab = 1),
            ),
            SizedBox(width: 18),
            NotificationTab(
              label: "Read",
              isSelected: selectedTab == 2,
              onTap: () => setState(() => selectedTab = 2),
            ),
          ],
        ),

        Expanded(
          child: filteredNotifications.isEmpty
              ? Center(child: Text("No notifications"))
              : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            itemCount: filteredNotifications.length,
            itemBuilder: (context, index) {
              int originalIndex = notifications.indexOf(filteredNotifications[index]);
              return GestureDetector(
                onTap: () => markAsRead(originalIndex),
                child: NotificationItem(
                  title: filteredNotifications[index]['title'],
                  message: filteredNotifications[index]['message'],
                  icon: filteredNotifications[index]['icon'],
                  isNew: !filteredNotifications[index]['isRead'],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Tab Widget
class NotificationTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  NotificationTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: isSelected ? Colors.green : Colors.grey,
        ),
      ),
    );
  }
}


// Notification Item Widget
class NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final bool isNew;

  NotificationItem({required this.title, required this.message, required this.icon, this.isNew = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // Set the container width to screen width
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isNew ? Colors.blue[50] : Colors.white,
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(fontSize: 16, color: Colors.grey[1000]),
                ),
                SizedBox(height: 6),
                Text(
                  "Last Wednesday at 9:42 AM",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
