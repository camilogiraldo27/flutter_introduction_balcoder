import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FailedLoginDialog extends StatefulWidget {
  @override
  _FailedLoginDialogState createState() => _FailedLoginDialogState();
}

class _FailedLoginDialogState extends State<FailedLoginDialog> {
  TextEditingController keyNameController = TextEditingController();
  TextEditingController keyDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kPrimaryLightColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          height: 340,
          width: 340,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Stack(
            children: [
              Image.asset("assets/images/failed_login.png"),

              // Positioned(
              //     height: 79,
              //     width: 50,
              //     right: 24,
              //     child: Container(
              //       child: Padding(
              //         padding: const EdgeInsets.only(top: 42.0, bottom: 11),
              //         child: Icon(
              //           Icons.cases,
              //           color: Colors.white,
              //         ),
              //       ),
              //       decoration: BoxDecoration(
              //           color: kPrimaryColor,
              //           borderRadius: BorderRadius.only(
              //             bottomLeft: Radius.circular(40),
              //             bottomRight: Radius.circular(40),
              //           )),
              //     )),
              Container(
                child: Column(
                  children: [
                    // new Padding(padding: EdgeInsets.only(top: 50.0)),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: new TextFormField(
                    //     decoration: new InputDecoration(
                    //       labelText: "Nombre de la llave",
                    //       fillColor: Colors.white,
                    //       border: new OutlineInputBorder(
                    //         borderRadius: new BorderRadius.circular(25.0),
                    //         borderSide: new BorderSide(),
                    //       ),
                    //       //fillColor: Colors.green
                    //     ),
                    //     validator: (val) {
                    //       if (val.length == 0) {
                    //         return "Cannot be empty";
                    //       } else {
                    //         return null;
                    //       }
                    //     },
                    //     keyboardType: TextInputType.emailAddress,
                    //     style: new TextStyle(
                    //         // fontFamily: "Poppins",
                    //         ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: new TextFormField(
                    //     decoration: new InputDecoration(
                    //       hintText: "Esta llave es para...",
                    //       labelText: "Drescripción",
                    //       fillColor: Colors.white,
                    //       border: new OutlineInputBorder(
                    //         borderRadius: new BorderRadius.circular(25.0),
                    //         borderSide: new BorderSide(),
                    //       ),
                    //       //fillColor: Colors.green
                    //     ),
                    //     validator: (val) {
                    //       if (val.length == 0) {
                    //         return "Cannot be empty";
                    //       } else {
                    //         return null;
                    //       }
                    //     },
                    //     keyboardType: TextInputType.emailAddress,
                    //     style: new TextStyle(
                    //         // fontFamily: "Poppins",
                    //         ),
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
