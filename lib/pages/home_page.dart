import 'package:app/pages/badges_page.dart';
import 'package:app/pages/goals_page.dart';
import 'package:app/providers/goals_provider.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/login_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:app/pages/news_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
    required this.name,
    required this.imagePath,
  });

  final double fvc = 2.97;
  final double fev1 = 2.19;
  final String lungState = "Normal";
  final String name;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    // Fetch screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF81C9F3),
      appBar: AppBar(
        title: Text("X-Hale Home"),
        centerTitle: true,
        backgroundColor: Color(0xFF81C9F3),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: Icon(Icons.logout),
            color: Color(0xFF1A237E),
          )
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.12, // Adjusted to avoid overlap
              horizontal: screenWidth * 0.05,
            ),
            children: [
              _buildWelcomeCard(screenHeight),
              SizedBox(height: screenHeight * 0.02),
              _buildSpirometryTestCard(screenHeight),
              SizedBox(height: screenHeight * 0.02),
              _buildTestResults(screenWidth),
              SizedBox(height: screenHeight * 0.02),
              _buildHealthGoalsCard(context, screenHeight),
              SizedBox(height: screenHeight * 0.02),
              _buildBadgesCard(context, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.02),
              _buildNewsCard(context, screenWidth, screenHeight),
            ],
          ),
          Positioned(
            top: screenHeight * 0.02, // Adjusted positioning
            left: screenWidth * 0.35,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(imagePath),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _textStyle(double size, Color color, {bool isBold = false}) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    );
  }

  Widget _buildContainer({required Widget child, double? height}) {
    return Container(
      height: height,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: child,
    );
  }

  Widget _buildWelcomeCard(double screenHeight) {
    return _buildContainer(
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.06),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome!",
                style: _textStyle(40, Color(0xFF1A237E), isBold: true),
              ),
              Text(
                name,
                style: _textStyle(30, Color(0xFF1A237E), isBold: true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpirometryTestCard(double screenHeight) {
    return _buildContainer(
      height: screenHeight * 0.15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Last Spirometry Test",
            style: _textStyle(20, Color(0xFF1A237E), isBold: true),
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            "Lung Function Level - $lungState",
            style: _textStyle(16, Colors.green, isBold: true),
          ),
        ],
      ),
    );
  }

  Widget _buildTestResults(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildResultCard("FVC", fvc.toString(), 0.7, screenWidth),
        _buildResultCard("FEV1", fev1.toString(), 0.5, screenWidth),
      ],
    );
  }

  Widget _buildResultCard(
      String title, String value, double percentage, double screenWidth) {
    return SizedBox(
      width: screenWidth * 0.4,
      child: Card(
        elevation: 10,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: _textStyle(18, Color(0xFF1A237E))),
              CircularPercentIndicator(
                animation: true,
                animationDuration: 500,
                radius: 70,
                lineWidth: 20,
                percent: percentage,
                center: Text(
                  value,
                  style: _textStyle(20, Color(0xFF1A237E)),
                ),
                progressColor: Color.fromARGB(255, 53, 197, 207),
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealthGoalsCard(BuildContext context, double screenHeight) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoalsPage()),
        );
      },
      child: Consumer<GoalsProvider>(
        builder: (context, goalsProvider, child) {
          return Container(
            height: screenHeight * 0.4,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Health Goals Today",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF1A237E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Expanded(
                  child: goalsProvider.toDoList.isNotEmpty
                      ? ListView.builder(
                          itemCount: goalsProvider.toDoList.length,
                          itemBuilder: (context, index) {
                            final task = goalsProvider.toDoList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0),
                              child: Row(
                                children: [
                                  Icon(
                                    task.isCompleted
                                        ? Icons.check_circle
                                        : Icons.radio_button_unchecked,
                                    color: task.isCompleted ? Colors.green : Colors.red,
                                    size: 24,
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      task.taskName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                        decoration: task.isCompleted
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            "No goals for today.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBadgesCard(BuildContext context, double screenWidth, double screenHeight) {
    return _buildContainer(
      height: screenHeight * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Badges",
            style: _textStyle(20, Color(0xFF1A237E), isBold: true),
          ),
          SizedBox(height: screenHeight * 0.01),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BadgesPage()),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/badges.jpeg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context, double screenWidth, double screenHeight) {
    return _buildContainer(
      height: screenHeight * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "News",
            style: _textStyle(20, Color(0xFF1A237E), isBold: true),
          ),
          SizedBox(height: screenHeight * 0.01),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsPage()),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/news.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
