import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/model/user_model.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/screen/key/model/key_model.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';
import 'package:intl/intl.dart';

class GetKeyDialog extends StatefulWidget {
  GetKeyDialog({required this.userModel, required this.deviceModel});

  UserModel userModel;
  DeviceModel deviceModel;
  @override
  _GetKeyDialogState createState() => _GetKeyDialogState();
}

class _GetKeyDialogState extends State<GetKeyDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController keyDescriptionController = TextEditingController();
  bool isLoading = false;
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  int _groupValue = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    keyDescriptionController.text = "";
    print(widget.userModel.uid);
    print(widget.deviceModel.key);
  }

  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      print('Form is valid');

      setState(() {
        isLoading = true;
      });

      // TripModel _tripModel = new TripModel();
      // _tripModel.deviceModel = widget.deviceModel;
      // _tripModel.isNew = true;
      // _tripModel.status = 'inTracking';
      // _tripModel.observation = keyDescriptionController.text.toString();
      // _tripModel.tripType = _groupValue == -1
      //     ? null
      //     : _groupValue == 0
      //         ? 'Dardo'
      //         : 'Boomerang';
      // _tripModel.isDeleted = false;
      // _tripModel.createdBy = widget.userModel;

      // await FirebaseFirestore.instance
      //     .collection('tripCollection')
      //     .add(_tripModel.toJson())
      //     .then((result) async {
      //   print("GUARDO trip");
      //   Navigator.of(context).pop();

      //   _tripModel.key = result.id;

      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (_) => MapPage(tripModel: _tripModel)));
      // }).catchError((err) => print(err));
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kDialogBackGround,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 355,
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
                  // SvgPicture.asset("assets/images/get_key_dialog.svg"),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Row(
                        //   children: [
                        //     Padding(
                        //       padding:
                        //           const EdgeInsets.only(top: 18.0, left: 25.0),
                        //       child: Text(
                        //         widget.deviceModel.keyList[0].keyName,
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(
                        //             fontSize: 17,
                        //             fontWeight: FontWeight.w600, // light
                        //             color: kTextColor),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Padding(
                        //       padding:
                        //           const EdgeInsets.only(top: 8.0, left: 25.0),
                        //       child: Text(
                        //         'Agregada el ' +
                        //             formatter
                        //                 .format(widget.deviceModel.createdDate
                        //                     .toDate())
                        //                 .toString() +
                        //             ' \n',
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(
                        //             fontSize: 12,
                        //             fontWeight: FontWeight.w600, // light
                        //             color: kTextColor),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Text(
                                  'Tipo de Lectura',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700, // light
                                      color: kPrimaryColor),
                                ),
                              ),
                              Divider(),
                              SizedBox(
                                height: 20,
                              ),
                              _myRadioButton(
                                title: "Presión",
                                subtitle: "El dispositivo obtiene X Data",
                                value: 0,
                                onChanged: (newValue) =>
                                    setState(() => _groupValue = newValue),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              _myRadioButton(
                                title: "Oxigenación",
                                subtitle: "El dispositivo obtiene Y Data",
                                value: 1,
                                onChanged: (newValue) =>
                                    setState(() => _groupValue = newValue),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 35.0, right: 55, top: 12, bottom: 4),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: new TextFormField(
                                controller: keyDescriptionController,
                                decoration: new InputDecoration(
                                  hintText: "Escribe una observación... ",
                                  // labelText: "Drescripción",
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
                                //     return "Campos obligatorios";
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
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Spacer(),
                          GestureDetector(
                            onTap: validateAndSave,
                            child: Container(
                              height: 35,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: kbackGroundDark,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  'Leer',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400, // light
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 35,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: kSecondaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  'Cancelar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400, // light
                                      color: Colors.white),
                                ),
                              ),
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

  Widget _myRadioButton(
      {required String title,
      required String subtitle,
      required int value,
      required onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
