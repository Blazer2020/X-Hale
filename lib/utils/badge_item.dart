import 'package:flutter/material.dart';

class BadgeItemPage extends StatelessWidget {
  final BadgeItem badge;

  const BadgeItemPage({super.key, required this.badge});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF81C9F3),
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1, // 10% of screen height
        centerTitle: true,
        title: Text(
          badge.title,
          style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.05), // Font size 5% of screen width
        ),
        backgroundColor: Color(0xFF81C9F3),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02), // 2% of screen width as padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    badge.imagePath,
                    fit: BoxFit.cover,
                    width: screenWidth * 0.8, // Adjust image width
                    height: screenHeight * 0.4, // Adjust image height
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Space between image and text
            Text(
              badge.title,
              style: TextStyle(
                fontSize: screenWidth * 0.05, // Font size 5% of screen width
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              badge.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.04, // Font size 4% of screen width
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: screenHeight * 0.03), // Space for padding
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1A237E),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                  vertical: screenHeight * 0.02,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Badge item model
class BadgeItem {
  final String imagePath;
  final String title;
  final String description;

  BadgeItem(this.imagePath, this.title, this.description);
}
