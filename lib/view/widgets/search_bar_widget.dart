import 'package:flutter/material.dart';
import 'filter_widget.dart';

class SearchBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    hintText: 'Search menu, restaurant or etc',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    isDense: true,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.menu_outlined, color: Colors.grey[600]),
                onPressed: () async {
                  final filters = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilterScreen()),
                  );
                  if (filters != null) {
                    print('Applied filters: $filters');
                    // Handle filters here
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}