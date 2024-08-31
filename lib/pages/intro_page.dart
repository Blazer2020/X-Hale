import 'package:app/pages/login_page.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: Color(0xFF35C5CF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Image.asset(
                "assets/images/logo.png",
                color: Colors.white,
                height:
                    screenHeight * 0.2, // Adjust height based on screen size
                width: screenWidth * 0.3, // Adjust width based on screen size
              ),
            ),
            SizedBox(height: screenHeight * 0.1), // Dynamic spacing
            // Welcome Text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Text(
                "WELCOME TO X-HALE!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth *
                      0.06, // Adjust font size based on screen width
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Dynamic spacing
            // Login Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                minWidth:
                    screenWidth * 0.7, // Dynamic width based on screen size
                height:
                    screenHeight * 0.06, // Dynamic height based on screen size
                color: Color(0xFF81C9F3),
                textColor: Color(0xFF1A237E),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  "LOG IN",
                  style: TextStyle(
                    fontSize: screenWidth *
                        0.05, // Adjust font size based on screen width
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03), // Dynamic spacing
            // Animation GIF
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Image.asset(
                "assets/gifs/lung_ani.gif",
                height:
                    screenHeight * 0.2, // Adjust height based on screen size
                width: screenWidth * 0.3, // Adjust width based on screen size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
