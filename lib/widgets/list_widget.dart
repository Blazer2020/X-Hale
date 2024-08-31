import 'package:flutter/material.dart';
import 'package:app/utils/list_item.dart';

Widget ListWidget(ListItem item) {
  return Card(
    elevation: 2.0,
    margin: EdgeInsets.only(bottom: 20.0),
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Hero(
            tag: '${item.newsTitle}',
            child: Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(item.imgUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.newsTitle,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.0),
                Row(
                  children: [
                    /*
                    Icon(Icons.person, size: 14.0, color: Colors.grey),
                    SizedBox(width: 5.0),
                    Text(
                      item.author,
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                    */
                    SizedBox(width: 10.0),
                    Icon(Icons.date_range, size: 14.0, color: Colors.grey),
                    SizedBox(width: 5.0),
                    Text(
                      item.date,
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
