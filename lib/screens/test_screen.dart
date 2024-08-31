import 'package:app/screens/results_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key, required this.characteristic});

  final BluetoothCharacteristic characteristic; // ######change######

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late BluetoothCharacteristic characteristic;
  int count = 0;

  @override
  void initState() {
    super.initState();
    characteristic = widget.characteristic;
    // Uncomment the following line for debugging to reset preferences
    _resetPreferences().then((_) => _checkFirstTime());
    _checkFirstTime();
  }

  Future<void> _resetPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasShownTestScreenDialog', false);
    print("Preferences reset");
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasShownDialog = prefs.getBool('hasShownTestScreenDialog') ?? false;
    print("hasShownDialog: $hasShownDialog");

    if (!hasShownDialog) {
      _showWelcomeDialog();
      await prefs.setBool('hasShownTestScreenDialog', true);
    }
  }

  void _showWelcomeDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const DialogBoxOne();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 164, 214, 255),
      appBar: AppBar(
        title: const Text('Test Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Image(image: AssetImage('assets/gifs/lung_ani.gif')),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () async {
                //countdown();
                sendValueToESP32('start'); // ######change######
                count++;
                if (count == 3) {
                  Timer(Duration(seconds: 12), () async {
                    final receivedData = await characteristic.read();
                    print("Received data: ${utf8.decode(receivedData)}");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResultsScreen(),
                      ),
                    );
                  });
                }
              },
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> countdown() async {
    int count = 3;
    while (count > 0) {
      print(count);
      await Future.delayed(const Duration(seconds: 1));
      count--;
    }
    print('Start blowing');
    int count2 = 10;
    while (count2 > 0) {
      print(count2);
      await Future.delayed(const Duration(seconds: 1));
      count2--;
    }
    print('Test complete');
  }

  void sendValueToESP32(String value) async {
    List<int> bytes = utf8.encode(value);
    await characteristic.write(bytes); // ######change######
  }
}

class DialogBoxOne extends StatelessWidget {
  const DialogBoxOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [
          const CardDialog(),
          Positioned(
            top: 5,
            right: 5,
            height: 30,
            width: 30,
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(4),
                backgroundColor: const Color.fromARGB(255, 105, 18, 163),
                shape: const CircleBorder(),
              ),
              child: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}

class CardDialog extends StatelessWidget {
  const CardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('Test Instructions',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
              'For better accuracy, the test will be performed 3 times. Whenever you are ready to perform the test, press the Start button below. When the countdown reaches zero, please blow into the device for 10 seconds continuously.'),
        ],
      ),
    );
  }
}
