import 'package:app/providers/goals_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BadgesPage extends StatelessWidget {
  BadgesPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine number of columns based on screen width
    int crossAxisCount = (screenWidth / 200).floor(); // 200 is an approximate minimum width for each card

    return Scaffold(
      backgroundColor: Color(0xFF81C9F3),
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1, // 10% of screen height
        centerTitle: true,
        title: Text(
          "Badges",
          style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.05), // Font size 5% of screen width
        ),
        backgroundColor: Color(0xFF81C9F3),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02), // 2% of screen width as padding
        child: Consumer<GoalsProvider>(
          builder: (context, goalsProvider, child) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: screenWidth * 0.02, // 2% of screen width
                mainAxisSpacing: screenHeight * 0.02, // 2% of screen height
                childAspectRatio: 1, // Aspect ratio of each badge item
              ),
              itemCount: _badgeItems.length,
              itemBuilder: (context, index) {
                BadgeItem badge = _badgeItems[index];
                // Update the badge earned status based on completed tasks
                badge.isEarned = goalsProvider.completedGoalsCount >= badge.goalThreshold;
                return _buildBadgeCard(context, badge);
              },
            );
          },
        ),
      ),
    );
  }

  // Sample badge data
  final List<BadgeItem> _badgeItems = [
    BadgeItem('assets/images/breathe_deeply.jpeg', 'Achievement 1', false, 10),
    BadgeItem('assets/images/breathe_mindfully.jpeg', 'Achievement 2', false, 25),
    BadgeItem('assets/images/protect_your_lungs.jpeg', 'Achievement 3', false, 50),
  ];

  Widget _buildBadgeCard(BuildContext context, BadgeItem badge) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        _showBadgeDetail(context, badge);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Stack(
                  children: [
                    Image.asset(
                      badge.imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity, // Make image fill the width of the card
                    ),
                    if (!badge.isEarned) // Add overlay if badge is not yet earned
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.6),
                          child: Center(
                            child: Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: screenWidth * 0.1, // Lock icon size
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.03), // 3% of screen width
              child: Text(
                badge.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.04, // Font size 4% of screen width
                  fontWeight: FontWeight.bold,
                  color: badge.isEarned ? Colors.black : Colors.grey, // Grey text if not earned
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show badge detail dialog
  void _showBadgeDetail(BuildContext context, BadgeItem badge) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(badge.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(badge.imagePath),
              SizedBox(height: 10),
              Text(
                badge.isEarned
                    ? "Congratulations! You've earned this badge."
                    : "Keep up the effort to earn this badge!",
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}

// Badge item model
class BadgeItem {
  final String imagePath;
  final String title;
  bool isEarned;
  final int goalThreshold;

  BadgeItem(this.imagePath, this.title, this.isEarned, this.goalThreshold);
}