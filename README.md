# flutter_balcoder_medicalapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


0x180f -> Battery level

Generic ATTribute Profile

(GATT Database)

With BLE, all of the interaction between devices happens through the GATT database. The database is comprised of Services and Characteristics. Services just act as groups of related characteristics. Characteristics can be read and written to, and manipulated (depending on the permissions you give).

Service
Characteristic
Service
Characteristic
Characteristic
All functions are divided up into services and characteristics. Each service and characteristic has its own UUID. Standard services and characteristics have their own predefined 16-bit UUID's. These can be found in the GATT Specifications. Vendor specific services and characteristics (like what we will use) use uniquely generated 128-bit UUID's (I used the CLI uuidgen program to make mine).

Heart Rate Monitor Example (Hypothetical)

Key: UUID, [value], (Human Readable Description)

0x1800, (Generic Access Service)
0x2A00, "MyHeart Monitor", (Device Name)
0x2A01, 0x0200, (Appearance)
0x180A, (Device Information Service)
0x2A29, "Rocketmade", (Manufacturer Name String)
0x2A24, "0.1", (Model Number String)
0x2A27, "0.1", (Hardware Revision String)
0x2A26, "0.1", (Firmware Revision String)
0x180D, (Heart Rate)
0x2A37, [variable], (Heart Rate Measurement)
0x2A38, 0x0002, (Body Sensor Location)