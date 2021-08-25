import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/model/user_model.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/screen/otp/pages/login_page.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/service/auth.service.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/service/root_service.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/root_screen.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // String actualCode;
  late String actualPhoneNumber;

  @observable
  bool isLoginLoading = false;
  @observable
  bool isOtpLoading = false;

  @observable
  GlobalKey<ScaffoldState> loginScaffoldKey = GlobalKey<ScaffoldState>();
  @observable
  GlobalKey<ScaffoldState> otpScaffoldKey = GlobalKey<ScaffoldState>();

  @observable
  late User firebaseUser;

  @action
  Future<bool> isAlreadyAuthenticated() async {
    firebaseUser = _auth.currentUser!;
    if (firebaseUser != null) {
      if (firebaseUser.phoneNumber != null && firebaseUser.phoneNumber != '') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @action
  Future<void> getCodeWithPhoneNumber(
      BuildContext context, String phoneNumber) async {
    actualPhoneNumber = phoneNumber;
    isLoginLoading = true;
    firebaseUser = _auth.currentUser!;

    isLoginLoading = false;
    FirebaseFirestore.instance
        .collection('userCollection')
        .doc(firebaseUser.uid)
        .update({
      "phoneKey": firebaseUser.uid,
      "phoneVerified": true,
      "phoneNumber": actualPhoneNumber
    }).then((result) async {
      print("GUARDO user");

      await FirebaseFirestore.instance
          .collection('userCollection')
          .doc(firebaseUser.uid)
          .get()
          .then((doc) async {
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (_) => RootHomeScreen(
                    auth: new Auth(),
                    userModel: new UserModel.fromSnapshot(
                        data: doc.data(), id: doc.id))),
            (Route<dynamic> route) => false);
      }).catchError((err) => print(err));
    }).catchError((err) => print(err));

    // await _auth.verifyPhoneNumber(
    //     phoneNumber: phoneNumber,
    //     timeout: const Duration(seconds: 60),
    //     verificationCompleted: (AuthCredential auth) async {
    //       await _auth.signInWithCredential(auth).then((value) {
    //         if (value != null && value.user != null) {
    //           print('Authentication successful');
    //           onAuthenticationSuccessful(context, value, firebaseUser.uid);
    //         } else {
    //           loginScaffoldKey.currentState.showSnackBar(SnackBar(
    //             behavior: SnackBarBehavior.floating,
    //             backgroundColor: Colors.red,
    //             content: Text(
    //               'Código no válido / autenticación no válida',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //           ));
    //         }
    //       }).catchError((error) {
    //         loginScaffoldKey.currentState.showSnackBar(SnackBar(
    //           behavior: SnackBarBehavior.floating,
    //           backgroundColor: Colors.red,
    //           content: Text(
    //             'Algo salió mal, inténtalo más tarde',
    //             style: TextStyle(color: Colors.white),
    //           ),
    //         ));
    //       });
    //     },
    //     verificationFailed: (authException) {
    //       print('Error message: ' + authException.message);
    //       // loginScaffoldKey.currentState.showSnackBar(SnackBar(
    //       //   behavior: SnackBarBehavior.floating,
    //       //   backgroundColor: Colors.green,
    //       //   content: Text(
    //       //     'El formato del número de teléfono es incorrecto. Introduzca su número en formato E.164. [+] [código de país] [número]',
    //       //     style: TextStyle(color: Colors.white),
    //       //   ),
    //       // ));
    //       isLoginLoading = false;
    //       FirebaseFirestore.instance
    //           .collection('userCollection')
    //           .doc(firebaseUser.uid)
    //           .update({
    //         "phoneKey": firebaseUser.uid,
    //         "phoneVerified": true,
    //         "phoneNumber": actualPhoneNumber
    //       }).then((result) async {
    //         print("GUARDO user");

    //         await FirebaseFirestore.instance
    //             .collection('userCollection')
    //             .doc(firebaseUser.uid)
    //             .get()
    //             .then((doc) async {
    //           Navigator.of(context).pop();
    //           Navigator.of(context).pushAndRemoveUntil(
    //               MaterialPageRoute(
    //                   builder: (_) => RootHomeScreen(
    //                         auth: new Auth(),
    //                         userModel: new UserModel.fromSnapshot(doc),
    //                       )),
    //               (Route<dynamic> route) => false);
    //         }).catchError((err) => print(err));
    //       }).catchError((err) => print(err));
    //     },
    //     codeSent: (String verificationId, [int forceResendingToken]) async {
    //       actualCode = verificationId;
    //       isLoginLoading = false;
    //       firebaseUser = _auth.currentUser;

    //       await Navigator.of(context).push(MaterialPageRoute(
    //           builder: (_) => OtpPage(uid: firebaseUser.uid)));
    //     },
    //     codeAutoRetrievalTimeout: (String verificationId) {
    //       actualCode = verificationId;
    //     });
  }

  @action
  Future<void> validateOtpAndLogin(
      BuildContext context, String smsCode, String uid) async {
    isOtpLoading = true;

    await FirebaseFirestore.instance
        .collection('userCollection')
        .doc(uid)
        .update({
      "phoneKey": firebaseUser.uid,
      "phoneVerified": true,
      "phoneNumber": actualPhoneNumber
    }).then((result) async {
      print("GUARDO user");

      await FirebaseFirestore.instance
          .collection('userCollection')
          .doc(uid)
          .get()
          .then((doc) async {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/RootService');
      }).catchError((err) => print(err));
    }).catchError((err) => print(err));

    // try {
    //   final AuthCredential _authCredential = PhoneAuthProvider.credential(
    //       verificationId: actualCode, smsCode: smsCode);

    //   await _auth.signInWithCredential(_authCredential).catchError((error) {
    //     isOtpLoading = false;
    //     otpScaffoldKey.currentState.showSnackBar(SnackBar(
    //       behavior: SnackBarBehavior.floating,
    //       backgroundColor: Colors.red,
    //       content: Text(
    //         'Codigo erroneo ! Introduzca el último código recibido.',
    //         style: TextStyle(color: Colors.white),
    //       ),
    //     ));
    //   }).then((authResult) {
    //     if (authResult != null && authResult.user != null) {
    //       print('Authentication successful');
    //       onAuthenticationSuccessful(context, authResult, uid);
    //     }
    //   });
    // } catch (e) {
    //   print("Error: $e");

    // }
  }

  Future<void> onAuthenticationSuccessful(
      BuildContext context, result, String uid) async {
    isLoginLoading = true;
    isOtpLoading = true;

    print(result);

    firebaseUser = result.user;

    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (_) => HomeScreen()),
    //     (Route<dynamic> route) => false);

    print("NEED NAVIGATOR");
    print("EL DE EMAIL:" + uid);
    print("EL DE PHONE:" + firebaseUser.uid);

    await FirebaseFirestore.instance
        .collection('userCollection')
        .doc(uid)
        .update({
      "phoneKey": firebaseUser.uid,
      "phoneVerified": true,
      "phoneNumber": firebaseUser.phoneNumber
    }).then((result) async {
      print("GUARDO user");

      await FirebaseFirestore.instance
          .collection('userCollection')
          .doc(uid)
          .get()
          .then((doc) async {
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (_) => RootHomeScreen(
                      auth: new Auth(),
                      userModel: new UserModel.fromSnapshot(
                          data: doc.data(), id: doc.id),
                    )),
            (Route<dynamic> route) => false);
      }).catchError((err) => print(err));
    }).catchError((err) => print(err));

    isLoginLoading = false;
    isOtpLoading = false;
  }

  @action
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (Route<dynamic> route) => false);
    firebaseUser = null as User;
  }
}
