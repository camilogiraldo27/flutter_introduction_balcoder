import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/model/user_model.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/screen/key/dialog/subscribe_dialog.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/screen/key/model/key_model.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddLockerDialog extends StatefulWidget {
  AddLockerDialog(
      {this.position,
      required this.userModel,
      required this.deviceModel,
      required this.isFromMyKey});

  int? position;
  UserModel userModel;
  DeviceModel deviceModel;
  bool isFromMyKey;
  @override
  _AddLockerDialogState createState() => _AddLockerDialogState();
}

class _AddLockerDialogState extends State<AddLockerDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController keyNameController = TextEditingController();
  TextEditingController keyDescriptionController = TextEditingController();
  KeyModel keyModel = new KeyModel();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    keyNameController.text = "";
    keyDescriptionController.text = "";
    print(widget.userModel.uid);
    print(widget.position);
  }

  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      print('Form is valid');

      setState(() {
        isLoading = true;
      });

      if (widget.deviceModel.key == null) {
        print(widget.userModel.uid);
        widget.deviceModel.uid = widget.userModel.uid!;
        widget.deviceModel.isDeleted = false;
        widget.deviceModel.deviceName = '';
        widget.deviceModel.deviceID = '';

        widget.deviceModel.createdDate = Timestamp.now();

        keyModel.keyName = keyNameController.text;
        keyModel.keyDescription = keyDescriptionController.text;
        keyModel.createdDate = Timestamp.now();
        keyModel.isDeleted = false;

        await FirebaseFirestore.instance
            .collection('lockerCollection')
            .add(widget.deviceModel.toJson())
            .then((result) async {
          print(result);
          print("GUARDO key");
          widget.deviceModel.key = result.id;

          Navigator.of(context).pop();
          if (widget.isFromMyKey) {
            print(!widget.userModel.isSubscribed!);
            if (widget.userModel.isSubscribed == true) {
              print(widget.position);
              // await Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => PaymentKeyPage(
              //             position: widget.position,
              //             userModel: widget.userModel,
              //             deviceModel: widget.deviceModel)));
            } else {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => SubscribeDialog(
                        userModel: widget.userModel,
                        deviceModel: widget.deviceModel,
                      ));
            }
          }
        }).catchError((err) => print(err));
      } else {
        keyModel.keyName = keyNameController.text;
        keyModel.keyDescription = keyDescriptionController.text;
        keyModel.createdDate = Timestamp.now();
        keyModel.isDeleted = false;

        await FirebaseFirestore.instance
            .collection('lockerCollection')
            .doc(widget.deviceModel.key)
            .update(widget.deviceModel.toJson())
            .then((result) async {
          print("GUARDO key");

          Navigator.of(context).pop();
        }).catchError((err) => print(err));
      }
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Dialog(
      backgroundColor: kDialogBackGround,
      insetPadding: EdgeInsets.zero,

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 365,
        width: 335,
        decoration: BoxDecoration(
          color: kDialogBackGround,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Image.asset("assets/images/add_key_dialog.png"),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        new Padding(padding: EdgeInsets.only(top: 90.0)),
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0, right: 55),
                          child: new TextFormField(
                            controller: keyNameController,
                            decoration: new InputDecoration(
                              // labelText: "Nombre de la llave",
                              fillColor: Colors.white,
                              border: InputBorder.none,

                              // border: new OutlineInputBorder(
                              //   borderRadius: new BorderRadius.circular(25.0),
                              //   borderSide: new BorderSide(),
                              // ),
                              //fillColor: Colors.green
                            ),
                            // validator: (val) {
                            //   if (val.length == 0) {
                            //     return "Cannot be empty";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                                // fontFamily: "Poppins",
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 35.0, right: 55, top: 40),
                          child: new TextFormField(
                            controller: keyDescriptionController,
                            decoration: new InputDecoration(
                              hintText: "Este Dispositivo es para...",
                              // labelText: "Drescripción",
                              fillColor: Colors.white,
                              border: InputBorder.none,

                              // border: new OutlineInputBorder(
                              //   borderRadius: new BorderRadius.circular(25.0),
                              //   borderSide: new BorderSide(),
                              // ),
                              //fillColor: Colors.green
                            ),
                            validator: (val) {
                              if (val!.length == 0) {
                                return "Campos obligatorios";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                                // fontFamily: "Poppins",
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 302.0),
                    child: Container(
                      child: Row(
                        children: [
                          Spacer(),
                          GestureDetector(
                            onTap: validateAndSave,
                            child: Container(
                              height: 35,
                              width: 135,
                              color: Colors.transparent,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 35,
                              width: 135,
                              color: Colors.transparent,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
