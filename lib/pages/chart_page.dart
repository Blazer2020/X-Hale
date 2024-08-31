import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<double> fvcData = [];
  List<double> fev1Data = [];
  List<double> ratioData = [];

  @override
  void initState() {
    super.initState();
    loadDetailsFromDevice();
  }

  // Save data to SharedPreferences
  Future<void> saveDetailsToDevice() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      "FVC_History",
      fvcData.map((e) => e.toString()).toList(),
    );
    await prefs.setStringList(
      "FEV1_History",
      fev1Data.map((e) => e.toString()).toList(),
    );
    await prefs.setStringList(
      "Ratio_History",
      ratioData.map((e) => e.toString()).toList(),
    );
  }

  // Load data from SharedPreferences
  Future<void> loadDetailsFromDevice() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? fvcStringList = prefs.getStringList("FVC_History");
    List<String>? fev1StringList = prefs.getStringList("FEV1_History");

    setState(() {
      fvcData = fvcStringList?.map((e) => double.tryParse(e) ?? 0).toList() ?? [];
      fev1Data = fev1StringList?.map((e) => double.tryParse(e) ?? 0).toList() ?? [];

      // Initialize with default values if empty
      if (fvcData.isEmpty || fev1Data.isEmpty) {
        fvcData = [5.0, 4.8, 5.1, 5.3, 5.4, 5.2, 5.0];
        fev1Data = [4.0, 3.8, 4.1, 4.3, 4.2, 4.0, 3.9];
      }

      ratioData = List.generate(
        fvcData.length,
        (index) => fvcData[index] != 0 ? fev1Data[index] / fvcData[index] : 0,
      );

      // Ensure only the last 7 values are kept
      if (fvcData.length > 7) {
        fvcData = fvcData.sublist(fvcData.length - 7);
        fev1Data = fev1Data.sublist(fev1Data.length - 7);
        ratioData = ratioData.sublist(ratioData.length - 7);
      }
    });
  }

  void _addValue(double value, List<double> dataList, String key) {
    setState(() {
      if (dataList.length >= 7) {
        dataList.removeAt(0);
      }
      dataList.add(value);
      ratioData = List.generate(
        fvcData.length,
        (index) => fvcData[index] != 0 ? fev1Data[index] / fvcData[index] : 0,
      );
      saveDetailsToDevice();
    });
  }

  // Updated buildChart method
  Widget _buildChart(double value, String label, double chartSize, String type) {
  double percent = 0;

  // Calculate percent based on the type of chart
  switch (type) {
    case 'fvc':
      percent = value / 5.5; // Assuming 5.5 is the maximum value for FVC
      break;
    case 'fev1':
      percent = fvcData.isNotEmpty ? value / fvcData[0] : 0; // Use the first FVC value as reference
      break;
    case 'ratio':
      percent = value; // Ratio is already in percentage form
      break;
  }

  // Constrain the percent value to be between 0.0 and 1.0
  percent = percent.clamp(0.0, 1.0);

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
                  _getIndicatorText(value),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 25, 24, 24),
                  ),
                ),
                progressColor: _getIndicatorColor(value),
                backgroundColor: Colors.grey[300]!,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
            Text(
              '$label: $value%',
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
    return const Color.fromARGB(255, 30, 125, 6); // Normal
  }

  String _getIndicatorText(double value) {
    if (value <= 50) return '$value%\nSevere';
    if (value <= 60) return '$value%\nModerate';
    if (value <= 70) return '$value%\nMild';
    return '$value%\nNormal';
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double chartSize = screenWidth * 0.5; // Chart size relative to screen width

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Trends",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        backgroundColor: const Color(0xFF81C9F3),
        elevation: 0,
      ),
      body: Container(
        color: const Color(0xFF81C9F3),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            const Text(
              'FVC Charts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: fvcData
                    .map((value) => _buildChart(value, 'FVC', chartSize, 'fvc'))
                    .toList(),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'FEV1 Charts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: fev1Data
                    .map((value) => _buildChart(value, 'FEV1', chartSize, 'fev1'))
                    .toList(),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'FEV1/FVC Charts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ratioData
                    .map((value) => _buildChart(value * 100, 'FEV1/FVC', chartSize, 'ratio')) // Convert ratio to percentage
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
