import 'package:flutter/material.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                "Leaderboard",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Center(
              child: Image(
                image: AssetImage("assets/lb.png"),
                fit: BoxFit.fill,
                width: 350,
                height: 600,
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}