import 'package:flutter/material.dart';

import 'filter_widget.dart';

class SearchBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(Icons.search, color: Colors.grey[600]),
                      ),
                      hintText: 'Search menu, restaurant or etc',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.grey[600]),
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

        ),
      ],
    );
  }

}