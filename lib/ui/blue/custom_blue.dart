// Copyright 2021, Sebastian Balvin (Balcoder).
// All rights reserved. Use of this source code is governed by a
// AntCodeIT license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/model/user_model.dart';
import 'package:flutter_balcoder_medicalapp/ui/blue/widgets.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/screen/key/model/key_model.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';
import 'package:flutter_blue/flutter_blue.dart';

class FlutterBlueApp extends StatelessWidget {
  FlutterBlueApp({Key? key, required this.userModel}) : super(key: key);
  UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return FindDevicesScreen(
                userModel: userModel,
              );
            }
            return BluetoothOffScreen(
              state: state,
              userModel: userModel,
            );
          }),
    );
  }
}

class BluetoothOffScreen extends StatelessWidget {
  BluetoothOffScreen({Key? key, this.state, required this.userModel})
      : super(key: key);
  UserModel userModel;

  final BluetoothState? state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            Text(
              'Bluetootho is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .subhead
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class FindDevicesScreen extends StatefulWidget {
  FindDevicesScreen({Key? key, required this.userModel});
  UserModel userModel;

  @override
  State<FindDevicesScreen> createState() => _FindDevicesScreenState();
}

class _FindDevicesScreenState extends State<FindDevicesScreen> {
  List<DeviceModel> deviceList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FlutterBlue.instance.startScan(timeout: Duration(seconds: 4));

    FlutterBlue.instance.connectedDevices.then((list) {
      list.forEach((device) {
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DeviceScreen(device: device)));
      });
    });

    getDevicesFirebase();
  }

  getDevicesFirebase() async {
    await FirebaseFirestore.instance
        .collection('deviceCollection')
        .where('isDeleted', isEqualTo: false)
        .where('uid', isEqualTo: widget.userModel.uid)
        .snapshots()
        .listen((event) {
      deviceList = [];

      event.docs.forEach((doc) {
        setState(() {
          deviceList
              .add(new DeviceModel.fromSnapshot(data: doc.data(), id: doc.id));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Dispositivos'),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(Duration(seconds: 2))
                    .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!.map((d) {
                    return Container();
                    // return ListTile(
                    //   title: Text(d.name),
                    //   subtitle: Text(d.id.toString()),
                    //   trailing: StreamBuilder<BluetoothDeviceState>(
                    //     stream: d.state,
                    //     initialData: BluetoothDeviceState.disconnected,
                    //     builder: (c, snapshot) {
                    //       if (snapshot.data == BluetoothDeviceState.connected) {
                    //         return RaisedButton(
                    //           child: Text('OPEN'),
                    //           onPressed: () => Navigator.of(context).push(
                    //               MaterialPageRoute(
                    //                   builder: (context) =>
                    //                       DeviceScreen(device: d))),
                    //         );
                    //       }
                    //       return Text(snapshot.data.toString());
                    //     },
                    //   ),
                    // );
                  }).toList(),
                ),
              ),
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!.map((r) {
                    bool showDevice = true;

                    if (deviceList.length > 0) {
                      showDevice = false;
                    }

                    for (var device in deviceList) {
                      print(device.deviceID);
                      if (device.deviceID.toString() ==
                          r.device.id.toString()) {
                        print("AA");
                        showDevice = true;
                      }
                    }

                    return showDevice
                        ? ScanResultTile(
                            result: r,
                            onTap: () {
                              print(r.device);

                              FirebaseFirestore.instance
                                  .collection("deviceCollection")
                                  .doc(r.device.id.toString())
                                  .set({
                                "deviceID": r.device.id.toString(),
                                "deviceName": r.device.name.toString(),
                                "createdDate": Timestamp.now(),
                                "isDeleted": false,
                                "uid": widget.userModel.uid
                              }).then((value) {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  r.device.connect();
                                  return DeviceScreen(device: r.device);
                                }));
                              });
                            })
                        : Container();
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: StreamBuilder<bool>(
      //   stream: FlutterBlue.instance.isScanning,
      //   initialData: false,
      //   builder: (c, snapshot) {
      //     if (snapshot.data!) {
      //       return FloatingActionButton(
      //         child: Icon(Icons.stop),
      //         onPressed: () => FlutterBlue.instance.stopScan(),
      //         backgroundColor: Colors.red,
      //       );
      //     } else {
      //       return FloatingActionButton(
      //           child: Icon(Icons.search),
      //           onPressed: () => FlutterBlue.instance
      //               .startScan(timeout: Duration(seconds: 4)));
      //     }
      //   },
      // ),
    );
  }
}

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  final BluetoothDevice device;

  List<int> _getRandomBytes() {
    final math = Random();
    return [
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255)
    ];
  }

  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    return services.map((s) {
      //0x180D, (Heart Rate)
      if ('0x${s.uuid.toString().toUpperCase().substring(4, 8)}' == '0x180D') {
        return ServiceTile(
          service: s,
          characteristicTiles: s.characteristics.map((c) {
            print(c);

            return CharacteristicTile(
              characteristic: c,
              onReadPressed: () => c.read(),
              onWritePressed: () async {
                await c.write(_getRandomBytes(), withoutResponse: true);
                await c.read();
              },
              onNotificationPressed: () async {
                await c.setNotifyValue(!c.isNotifying);
                await c.read();
              },
              descriptorTiles: c.descriptors
                  .map(
                    (d) => DescriptorTile(
                      descriptor: d,
                      onReadPressed: () => d.read(),
                      onWritePressed: () => d.write(_getRandomBytes()),
                    ),
                  )
                  .toList(),
            );
          }).toList(),
        );
      } else {
        return Container();
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback? onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () {
                    device.disconnect();
                    Navigator.pop(context);
                  };
                  text = 'Desconectar';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => device.connect();
                  text = 'Conectar';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return FlatButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .button
                        ?.copyWith(color: Colors.white),
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
                stream: device.state,
                initialData: BluetoothDeviceState.connecting,
                builder: (c, snapshot) {
                  return ListTile(
                    leading: (snapshot.data == BluetoothDeviceState.connected)
                        ? Icon(Icons.bluetooth_connected)
                        : Icon(Icons.bluetooth_disabled),
                    title: Text('Dispositivo ' +
                        (snapshot.data.toString().split('.')[1] ==
                                'disconnected'
                            ? 'desconectado'
                            : 'conectado')),
                    subtitle: Text('${device.id}'),
                    trailing: StreamBuilder<bool>(
                      stream: device.isDiscoveringServices,
                      initialData: false,
                      builder: (c, snapshot) => IndexedStack(
                        index: snapshot.data! ? 1 : 0,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () => device.discoverServices(),
                          ),
                          IconButton(
                            icon: SizedBox(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.grey),
                              ),
                              width: 18.0,
                              height: 18.0,
                            ),
                            onPressed: null,
                          )
                        ],
                      ),
                    ),
                  );
                }),
            // StreamBuilder<int>(
            //   stream: device.mtu,
            //   initialData: 0,
            //   builder: (c, snapshot) => ListTile(
            //     title: Text('MTU Size'),
            //     subtitle: Text('${snapshot.data} bytes'),
            //     trailing: IconButton(
            //       icon: Icon(Icons.edit),
            //       onPressed: () => device.requestMtu(223),
            //     ),
            //   ),
            // ),
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: [],
              builder: (c, snapshot) {
                return Column(
                  children: _buildServiceTiles(snapshot.data!),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
