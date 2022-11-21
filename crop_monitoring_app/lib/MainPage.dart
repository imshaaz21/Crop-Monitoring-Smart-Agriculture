import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import './ChatPage.dart';
import './SelectBondedDevicePage.dart';

// import './helpers/LineChart.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "...";
  String _name = "...";

  Timer? _discoverableTimeoutTimer;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address!;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name!;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
        _discoverableTimeoutTimer = null;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Crop Monitoring')),
      ),
      backgroundColor: Color(0xFFffffff),
      body: Container(
        child: ListView(
          children: <Widget>[
            SwitchListTile(
              title: const Text('Enable Bluetooth'),
              value: _bluetoothState.isEnabled,
              onChanged: (bool value) {
                // Do the request and update with the true value then
                future() async {
                  // async lambda seems to not working
                  if (value)
                    await FlutterBluetoothSerial.instance.requestEnable();
                  else
                    await FlutterBluetoothSerial.instance.requestDisable();
                }

                future().then((_) {
                  setState(() {});
                });
              },
            ),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: const Text('Bluetooth status'),
                    subtitle: Text(_bluetoothState.toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        FlutterBluetoothSerial.instance.openSettings();
                      },
                    ),
                  ),
                  // ListTile(title: const Text('Devices discovery and connection')),
                  ListTile(
                    title: ElevatedButton(
                      child: const Text('Connect to paired device to chat'),
                      onPressed: () async {
                        final BluetoothDevice? selectedDevice =
                            await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return SelectBondedDevicePage(
                                  checkAvailability: false);
                            },
                          ),
                        );

                        if (selectedDevice != null) {
                          print(
                              'Connect -> selected ' + selectedDevice.address);
                          _startChat(context, selectedDevice);
                        } else {
                          print('Connect -> no device selected');
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            // ListTile(
            //   title: const Text('Bluetooth status'),
            //   subtitle: Text(_bluetoothState.toString()),
            //   trailing: IconButton(
            //     icon: Icon(Icons.settings),
            //     onPressed: () {
            //       FlutterBluetoothSerial.instance.openSettings();
            //     },
            //   ),
            // ),
            // // ListTile(title: const Text('Devices discovery and connection')),
            // ListTile(
            //   title: ElevatedButton(
            //     child: const Text('Connect to paired device to chat'),
            //     onPressed: () async {
            //       final BluetoothDevice? selectedDevice =
            //           await Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) {
            //             return SelectBondedDevicePage(checkAvailability: false);
            //           },
            //         ),
            //       );

            //       if (selectedDevice != null) {
            //         print('Connect -> selected ' + selectedDevice.address);
            //         _startChat(context, selectedDevice);
            //       } else {
            //         print('Connect -> no device selected');
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ChatPage(server: server);
        },
      ),
    );
  }
}
