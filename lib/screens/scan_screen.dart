// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../utils/snackbar.dart';
import '../widgets/system_device_tile.dart';
import '../widgets/scan_result_tile.dart';
import '../screens/test_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  List<BluetoothDevice> _systemDevices = []; // already paired devices
  List<ScanResult> _scanResults = []; // devices found during scan
  bool _isScanning = false;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;

  @override
  void initState() {
    super.initState();
    _initializeStreams();
    _fetchSystemDevices(); // Fetch initially paired devices
  }

  void _initializeStreams() {
    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        _scanResults = results;
      });
    }, onError: (e) {
      Snackbar.show(ABC.b, prettyException("Scan Error:", e), success: false);
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      setState(() {
        _isScanning = state;
      });
    });
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    super.dispose();
  }

  Future<void> _fetchSystemDevices() async {
    try {
      List<BluetoothDevice> devices = await FlutterBluePlus.systemDevices;
      setState(() {
        _systemDevices = devices;
      });
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("System Devices Error:", e),
          success: false);
    }
  }

  List<Widget> _buildSystemDeviceTiles(BuildContext context) {
    return _systemDevices
        .map(
          (d) => SystemDeviceTile(
            device: d,
            onDisconnect: () => onDisconnectPressed(d),
            onConnect: () => onConnectPressed(d),
          ),
        )
        .toList();
  }

  List<Widget> _buildScanResultTiles(BuildContext context) {
    return _scanResults
        .map(
          (r) => ScanResultTile(
            result: r,
            onTap: () => onConnectPressed(
                r.device), // onTap callback for the Connect button
          ),
        )
        .toList();
  }

  Future<void> onScanPressed() async {
    try {
      _systemDevices = await FlutterBluePlus.systemDevices;
      setState(() {
        _systemDevices.clear(); // Clear existing devices before scanning
      });
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("System Devices Error:", e),
          success: false);
    }
    showModalBottomSheet(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 10),
      showDragHandle: true,
      context: context,
      builder: (context) {
        return StreamBuilder<List<ScanResult>>(
          stream: FlutterBluePlus.scanResults,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No devices found.'));
            } else {
              _scanResults = snapshot.data!;
              return Container(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: <Widget>[
                    ..._buildSystemDeviceTiles(context),
                    ..._buildScanResultTiles(context),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }

  Future<void> onStopPressed() async {
    try {
      await FlutterBluePlus.stopScan();
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Stop Scan Error:", e),
          success: false);
    }
  }

  void onConnectPressed(BluetoothDevice device) async {
    try {
      await device.connect();
      List<BluetoothService> services = await device.discoverServices();
      BluetoothCharacteristic? characteristic;
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic c in service.characteristics) {
          if (c.properties.read && c.properties.write) {
            characteristic = c;
            List<int> value = await characteristic.read();
            String valueString = String.fromCharCodes(value);
            print('///////////////////////////////////////////////');
            print('#################################################');
            print(characteristic.uuid.toString());
            print(valueString);
            print('#################################################');
            print('/////////////////////////////////////////////////');
            //List<int> value = await c.read();
            // Assuming you want to navigate to another screen with characteristic
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TestScreen(characteristic: characteristic!),
              ),
            );
            return; // Exit the loop once found and navigated
          }
        }
      }
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Connect Error:", e),
          success: false);
    }
  }

  void onDisconnectPressed(BluetoothDevice device) async {
    try {
      await device.disconnect();
      setState(() {
        _systemDevices
            .remove(device); // Remove from _systemDevices when disconnected
      });
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Disconnect Error:", e),
          success: false);
    }
  }

  Future<void> onRefresh() async {
    if (!_isScanning) {
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    }
    if (mounted) {
      setState(() {});
    }
    return Future.delayed(const Duration(milliseconds: 500));
  }

  Widget buildScanButton(BuildContext context) {
    if (_isScanning) {
      return ElevatedButton(
        child: const Icon(
          Icons.stop,
          size: 50,
          color: Color.fromARGB(255, 0, 96, 185),
        ),
        onPressed: onStopPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fixedSize: const Size(100, 100),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: onScanPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF1A237E),
          fixedSize: const Size(100, 100),
          elevation: 10.0,
        ),
        child: Icon(
          Icons.bluetooth,
          size: 50,
          color: Colors.white,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: Snackbar.snackBarKeyB,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 129, 201, 243),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Container(
                    width: 500, // Adjust these values as needed
                    height: 200, // Adjust these values as needed
                    child: Image.asset(
                      'assets/gifs/centered.gif',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    height: 100,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: buildScanButton(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
