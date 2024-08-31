import 'package:app/pages/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:app/pages/bluetooth_page.dart';
import 'package:app/screens/scan_screen.dart';
import 'package:app/screens/test_screen.dart';
import 'package:app/screens/bluetooth_off_screen.dart';
import 'package:app/providers/goals_provider.dart';

void main() {
  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
  runApp(const XHaleApp()); // Renamed for clarity
}

class XHaleApp extends StatefulWidget {
  const XHaleApp({super.key});

  @override
  State<XHaleApp> createState() => _XHaleAppState();
}

class _XHaleAppState extends State<XHaleApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoalsProvider()), // Register GoalsProvider
        // You can add more providers here if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroPage(),
        routes: {
          '/bluetoothpage': (context) => FlutterBlueApp(),
          '/scanpage': (context) => ScanScreen(),
          '/bluetoothoffpage': (context) => BluetoothOffScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/testpage') {
            final args = settings.arguments as BluetoothCharacteristic;
            return MaterialPageRoute(
              builder: (context) {
                return TestScreen(characteristic: args);
              },
            );
          }
          return null; 
        },
        navigatorObservers: [BluetoothAdapterStateObserver()],
      ),
    );
  }
}
