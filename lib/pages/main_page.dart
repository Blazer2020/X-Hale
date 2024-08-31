import 'package:app/pages/bluetooth_page.dart';
import 'package:app/pages/chart_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final String name;
  final String imagePath;
  const MainPage({super.key, required this.name, required this.imagePath});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int nowindex = 0;

  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = [
      HomePage(name: widget.name, imagePath: widget.imagePath),
      const FlutterBlueApp(),
      ChartPage(),
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      nowindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF81C9F3),
      body: _children[nowindex],
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color(0xFF1A237E),
        items: const <Widget>[
          Icon(
            Icons.home_outlined,
            size: 30,
            semanticLabel: "Home",
            color: Colors.white,
          ),
          Icon(
            Icons.add,
            size: 30,
            semanticLabel: "New Test",
            color: Colors.white,
          ),
          Icon(
            Icons.history,
            size: 30,
            semanticLabel: "Records",
            color: Colors.white,
          ),
        ],
        index: nowindex,
        onTap: onTabTapped,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOutCirc,
      ),
    );
  }
}
