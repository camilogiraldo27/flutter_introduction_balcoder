import 'package:cloud_firestore/cloud_firestore.dart';

class LockerModel {
  String? key;
  String? uid;
  bool? isDeleted;
  bool? isPayment;
  List<KeyModel>? keyList;
  Timestamp? createdDate;

  LockerModel(
      {this.key,
      this.uid,
      this.isPayment,
      this.keyList,
      this.createdDate,
      this.isDeleted});

  factory LockerModel.fromSnapshot({data, id}) {
    List<KeyModel>? aux;

    if (aux == null) {
      aux = [];
    }
    data['keyList']
        .forEach((element) => aux!.add(new KeyModel.fromJson(element)));

    return LockerModel(
      key: id,
      uid: data["uid"],
      isPayment: data["isPayment"],
      isDeleted: data["isDeleted"],
      createdDate: data["createdDate"],
      keyList: aux,
    );
  }

  LockerModel.fromJson(dynamic obj) {
    List<KeyModel>? aux;

    if (aux == null) {
      aux = [];
    }

    print(obj);

    obj['keyList']
        .forEach((element) => aux!.add(new KeyModel.fromJson(element)));

    this.key = obj['key'];
    this.uid = obj['uid'];
    this.isPayment = obj['isPayment'];
    this.isDeleted = obj['isDeleted'];
    this.createdDate = obj['createdDate'];
    this.keyList = aux;
  }

  toJson() {
    List? aux;

    if (aux == null) {
      aux = [];
    }

    keyList!.forEach((element) => aux!.add(element.toJson()));

    return {
      "uid": uid,
      "keyList": aux,
      "isDeleted": isDeleted,
      "isPayment": isPayment,
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
