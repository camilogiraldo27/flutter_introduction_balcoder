import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyEmailDialog extends StatefulWidget {
  @override
  _VerifyEmailDialogState createState() => _VerifyEmailDialogState();
}

class _VerifyEmailDialogState extends State<VerifyEmailDialog> {
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
              Image.asset("assets/images/verfy_email.png"),
            ],
          ),
        ),
      ),
    );
  }
}
