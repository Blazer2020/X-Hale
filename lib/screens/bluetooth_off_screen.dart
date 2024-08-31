import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../utils/snackbar.dart';

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen(
      {super.key, this.adapterState}); //statelsess widget bluetooth off screen

  final BluetoothAdapterState? adapterState;

  Widget buildBluetoothOffIcon(BuildContext context) {
    return const Icon(
      Icons.bluetooth_disabled,
      size: 200.0,
      color: Colors.white54,
    );
  }

  Widget buildTitle(BuildContext context) {
    String? state = adapterState?.toString().split(".").last;
    return Text(
      'Bluetooth Adapter is ${state ?? 'not available'}', //if bluetooth adapter state is not null dsiplay the state else display not available
      style: Theme.of(context)
          .primaryTextTheme
          .titleSmall
          ?.copyWith(color: Colors.white),
    );
  }

  Widget buildTurnOnButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        child: const Text('TURN ON'),
        onPressed: () async {
          try {
            //try to turn the bluetooth on
            if (Platform.isAndroid) {
              await FlutterBluePlus.turnOn();
            }
          } catch (e) {
            //if exception occurs display the error
            Snackbar.show(ABC.a, prettyException("Error Turning On:", e),
                success: false);
          }
        },
      ),
    );
  }

//snakcbar is used to display temporary messages on the screen
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      //used to show the snackbar
      key: Snackbar.snackBarKeyA,
      child: Scaffold(
        backgroundColor: Color(0xFF81C9F3),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildBluetoothOffIcon(
                  context), //displaying  widgets that were built above
              buildTitle(context),
              if (Platform.isAndroid) buildTurnOnButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
