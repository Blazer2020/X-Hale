import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:app/screens/bluetooth_off_screen.dart';
import 'package:app/screens/scan_screen.dart';

class FlutterBlueApp extends StatefulWidget {
  const FlutterBlueApp({super.key});

  @override
  State<FlutterBlueApp> createState() => _FlutterBlueAppState();
}

class _FlutterBlueAppState extends State<FlutterBlueApp> {
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  @override
  void initState() {
    //initstate initialize states and start listening to bluetooth adapter state
    super.initState();
    _adapterStateStateSubscription =
        FlutterBluePlus.adapterState.listen((state) {
      _adapterState = state;
      if (mounted) {
        setState(() {}); //setstate is used to update the state of the object
      }
    });
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel(); //cancel the subscription
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget screen;
    if (_adapterState == BluetoothAdapterState.on) {
      screen = const ScanScreen();
    } else {
      screen = BluetoothOffScreen(adapterState: _adapterState);
    }
    return screen;
  }
}

class BluetoothAdapterStateObserver extends NavigatorObserver {
  StreamSubscription<BluetoothAdapterState>?
      _adapterStateSubscription; //listens to changes in bluetooth adapter state

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == '/DeviceScreen') {
      _adapterStateSubscription ??=
          FlutterBluePlus.adapterState.listen((state) {
        if (state != BluetoothAdapterState.on) {
          navigator?.pop();
        }
      });
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _adapterStateSubscription?.cancel();
    _adapterStateSubscription = null;
  }
}
