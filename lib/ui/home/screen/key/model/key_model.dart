import 'package:cloud_firestore/cloud_firestore.dart';

class DeviceModel {
  String? key;
  String? uid;
  bool? isDeleted;
  String? deviceID;
  String? deviceName;
  Timestamp? createdDate;

  DeviceModel(
      {this.key,
      this.uid,
      this.deviceID,
      this.deviceName,
      this.createdDate,
      this.isDeleted});

  factory DeviceModel.fromSnapshot({data, id}) {
    return DeviceModel(
      key: id,
      uid: data["uid"],
      deviceID: data["deviceID"],
      deviceName: data["deviceName"],
      isDeleted: data["isDeleted"],
      createdDate: data["createdDate"],
    );
  }

  DeviceModel.fromJson(dynamic obj) {
    this.key = obj['key'];
    this.uid = obj['uid'];
    this.deviceID = obj['deviceID'];
    this.deviceName = obj['deviceName'];
    this.isDeleted = obj['isDeleted'];
    this.createdDate = obj['createdDate'];
  }

  toJson() {
    return {
      "uid": uid,
      "isDeleted": isDeleted,
      "deviceID": deviceID,
      "deviceName": deviceName,
      "createdDate": createdDate,
    };
  }
}

class KeyModel {
  String? keyDescription;
  String? keyName;
  bool? isDeleted;
  Timestamp? createdDate;

  KeyModel({this.keyDescription, this.keyName});

  KeyModel.fromJson(dynamic obj) {
    this.keyDescription = obj['keyDescription'];
    this.keyName = obj['keyName'];
    this.createdDate = obj['createdDate'];
    this.isDeleted = obj['isDeleted'];
  }

  toJson() {
    return {
      "keyDescription": keyDescription,
      "keyName": keyName,
      "createdDate": createdDate,
      "isDeleted": isDeleted,
    };
  }
}
