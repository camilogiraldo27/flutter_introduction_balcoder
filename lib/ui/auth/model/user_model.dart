import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? key;
  String? email;
  String? name;
  String? lastName;
  String? phoneNumber;
  String? urlPhoto;
  String? userType;
  String? country;
  String? uid;
  Timestamp? lastLogin;
  Timestamp? createdDate;
  bool? emailVerified;
  bool? phoneVerified;
  bool? isNew;
  bool? isSubscribed;
  bool? isDeleted;

  UserModel({this.email, this.uid});

  UserModel.fromJson(dynamic obj) {
    key = obj['key'];
    email = obj['email'];
    name = obj['name'];
    lastName = obj['lastName'];
    phoneNumber = obj['phoneNumber'];
    urlPhoto = obj['urlPhoto'];
    userType = obj['userType'];
    country = obj['country'];
    lastLogin = obj['lastLogin'];
    createdDate = obj['createdDate'];
    emailVerified = obj['emailVerified'];
    phoneVerified = obj['phoneVerified'];
    isNew = obj['isNew'];
    isSubscribed = obj['isSubscribed'];
    isDeleted = obj['isDeleted'];
    uid = obj['uid'];
  }

  UserModel.fromSnapshot({data, id})
      : key = id,
        email = data["email"],
        name = data["name"],
        lastName = data["lastName"],
        phoneNumber = data["phoneNumber"],
        urlPhoto = data["urlPhoto"],
        userType = data["userType"],
        country = data["country"],
        // lastLogin = data["lastLogin"],
        // createdDate = data["createdDate"],
        emailVerified = data["emailVerified"],
        phoneVerified = data["phoneVerified"],
        isNew = data["isNew"],
        isSubscribed = data["isSubscribed"],
        isDeleted = data["isDeleted"],
        uid = data["uid"];

  toJson() {
    return {
      "email": email,
      "name": name,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "urlPhoto": urlPhoto,
      "userType": userType,
      "country": country,
      // "lastLogin": lastLogin,
      // "createdDate": createdDate,
      "emailVerified": emailVerified,
      "phoneVerified": phoneVerified,
      "isNew": isNew,
      "isSubscribed": isSubscribed,
      "isDeleted": isDeleted,
      "uid": uid,
    };
  }
}
