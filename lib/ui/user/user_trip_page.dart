import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/model/user_model.dart';
import 'package:flutter_balcoder_medicalapp/utils/components/trip_card.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';

class UserTripPage extends StatefulWidget {
  UserTripPage({required this.userModel});

  final UserModel userModel;

  @override
  _UserTripPageState createState() => _UserTripPageState();
}

class _UserTripPageState extends State<UserTripPage> {
  final tripCollection =
      FirebaseFirestore.instance.collection('tripCollection');

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: tripCollection
              .where('isDeleted', isEqualTo: false)
              .where('createdBy.uid', isEqualTo: widget.userModel.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            List<Widget> children = [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  'Historial',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600, // light
                      color: kTextColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  'Interprete rápidamente sus datos',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300, // light
                      color: kTextColor),
                ),
              ),
            ];

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Center(
                  child: new CircularProgressIndicator(),
                );

                break;
              default:
                children.add(Padding(
                  padding: const EdgeInsets.only(top: 24, left: 24.0),
                  child: Text(
                    'En esta sección se cargará sus futuras mediciones.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400, // light
                        color: kTextColor),
                  ),
                ));

                children.add(
                  Divider(
                    color: kbackGroundLight,
                  ),
                );

                // children.add(
                //   Padding(
                //     padding: const EdgeInsets.only(left: 24.0),
                //     child: Text(
                //       'Historial',
                //       textAlign: TextAlign.left,
                //       style: TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.w600, // light
                //           color: kTextColor),
                //     ),
                //   ),
                // );

                // children.add(
                //   Padding(
                //     padding: const EdgeInsets.only(left: 24.0),
                //     child: Text(
                //       'Viajes realizados',
                //       textAlign: TextAlign.left,
                //       style: TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w300, // light
                //           color: kTextColor),
                //     ),
                //   ),
                // );
                // Padding(
                //   padding: const EdgeInsets.only(top: 24, left: 24.0),
                //   child: Text(
                //     'En esta sección se cargará sus futuros viajes.',
                //     textAlign: TextAlign.left,
                //     style: TextStyle(
                //         fontSize: 14,
                //         fontWeight: FontWeight.w400, // light
                //         color: kTextColor),
                //   ),
                // );

                return ListView(
                  children: children,
                );
            }
          },
        ),
      ),
    );
  }
}
