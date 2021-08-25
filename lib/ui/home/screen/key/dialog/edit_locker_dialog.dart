import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/model/user_model.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/screen/key/dialog/subscribe_dialog.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/screen/key/model/key_model.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditLockerDialog extends StatefulWidget {
  EditLockerDialog({required this.keyModel});

  KeyModel keyModel;
  @override
  _EditLockerDialogState createState() => _EditLockerDialogState();
}

class _EditLockerDialogState extends State<EditLockerDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController keyNameController = TextEditingController();
  TextEditingController keyDescriptionController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    keyNameController.text = widget.keyModel.keyName!;
    keyDescriptionController.text = widget.keyModel.keyDescription!;
    print(widget.keyModel.toJson());
  }

  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      print('Form is valid');

      setState(() {
        isLoading = true;

        widget.keyModel.keyName = keyNameController.text;
        widget.keyModel.keyDescription = keyDescriptionController.text;

        isLoading = false;

        Navigator.of(context).pop();
      });
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
                  SvgPicture.asset("assets/images/add_key_dialog.svg"),
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
