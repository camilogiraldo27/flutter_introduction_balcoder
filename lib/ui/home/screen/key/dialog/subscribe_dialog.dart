import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/model/user_model.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/screen/key/model/key_model.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class SubscribeDialog extends StatefulWidget {
  SubscribeDialog({required this.userModel, required this.deviceModel});

  UserModel userModel;
  DeviceModel deviceModel;
  @override
  _SubscribeDialogState createState() => _SubscribeDialogState();
}

class _SubscribeDialogState extends State<SubscribeDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController keyDescriptionController = TextEditingController();
  bool isLoading = false;
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    keyDescriptionController.text = "";
    print(widget.userModel.uid);
  }

  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      print('Form is valid');

      setState(() {
        isLoading = true;
      });

      // await FirebaseFirestore.instance.collection('tripCollection').add({
      //   "keyModel": widget.keyModel.toJson(),
      //   "isNew": true,
      //   "userModel": widget.userModel.toJson()
      // }).then((result) async {
      //   print("GUARDO trip");
      //   Navigator.of(context).pop();
      // }).catchError((err) => print(err));
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kDialogBackGround,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 340,
        width: 335,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  SvgPicture.asset("assets/images/subscribe_dialog.svg"),
                  Padding(
                    padding: const EdgeInsets.only(top: 250.0),
                    child: Container(
                      child: Row(
                        children: [
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              // await Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (_) => PaymentKeyPage(
                              //             userModel: widget.userModel,
                              //             deviceModel: widget.deviceModel)));
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 50,
                              width: 284,
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
