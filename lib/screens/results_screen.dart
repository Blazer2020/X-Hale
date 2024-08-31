import 'dart:math';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late double fvc;
  late double fev1;

  @override
  void initState() {
    super.initState();
    generateRandomValues();
  }

  // Generate random values for FVC and FEV1 since the spirometer is not connected
  void generateRandomValues() {
    Random random = Random();
    fvc = 3.5 + random.nextDouble() * 2;
    fev1 = 2.75 + random.nextDouble() * (fvc - 2.75);
    double ratio = fvc != 0 ? fev1 / fvc * 100 : 0;

    saveDetailsToDevice(fvc, fev1, ratio);
    setState(() {});
  }

  Future<void> saveDetailsToDevice(double fvc, double fev1, double ratio) async {
    final prefs = await SharedPreferences.getInstance();
  
    // Add values to the lists and save them
    List<String>? fvcStringList = prefs.getStringList("FVC_History") ?? [];
    List<String>? fev1StringList = prefs.getStringList("FEV1_History") ?? [];
    List<String>? ratioStringList = prefs.getStringList("Ratio_History") ?? [];

    fvcStringList.add(fvc.toString());
    fev1StringList.add(fev1.toString());
    ratioStringList.add(ratio.toString());

    await prefs.setStringList("FVC_History", fvcStringList);
    await prefs.setStringList("FEV1_History", fev1StringList);
    await prefs.setStringList("Ratio_History", ratioStringList);
  }

  Widget buildChart(double value, String label, double chartSize, String type) {
    double percent = 0;

    // Calculate percent based on the type of chart
    switch (type) {
      case 'fvc':
        percent = value / 5.5;
        break;
      case 'fev1':
        percent = fvc != 0 ? value / fvc : 0; // Prevent division by zero
        break;
      case 'ratio':
        percent = value / 100;
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(
          children: [
            Container(
              height: chartSize,
              width: chartSize,
              padding: const EdgeInsets.all(12.0),
              child: CircularPercentIndicator(
                animation: true,
                animationDuration: 1000,
                radius: chartSize / 3,
                lineWidth: chartSize / 20,
                percent: percent,
                center: Text(
                  '${(percent * 100).toStringAsFixed(1)}%',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 25, 24, 24),
                  ),
                ),
                progressColor: _getIndicatorColor(percent * 100),
                backgroundColor: Colors.grey[300]!,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
            Text(
              '$label: ${(percent * 100).toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getIndicatorColor(double value) {
    if (value <= 50) return const Color.fromARGB(255, 110, 11, 5); // Severe
    if (value <= 60) return const Color.fromARGB(255, 223, 95, 10); // Moderate
    if (value <= 70) return const Color.fromARGB(255, 126, 107, 10); // Mild
    if (value <= 100) return const Color.fromARGB(255, 30, 125, 6); // Normal
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double chartSize = screenWidth * 0.4; // Chart size relative to screen width

    // Calculate FEV1/FVC ratio
    double ratio = fvc != 0 ? fev1 / fvc * 100 : 0;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Results",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        backgroundColor: const Color(0xFF81C9F3),
        elevation: 0,
      ),
      body: Container(
        color: const Color(0xFF81C9F3),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'FVC Value',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      buildChart(fvc, 'FVC', chartSize, 'fvc'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'FEV1 Value',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      buildChart(fev1, 'FEV1', chartSize, 'fev1'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              'FEV1/FVC Ratio',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            buildChart(ratio, 'Ratio', chartSize, 'ratio'),
          ],
        ),
      ),
    );
  }
}
