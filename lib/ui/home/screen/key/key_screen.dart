import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/model/user_model.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/screen/key/dialog/add_locker_dialog.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/screen/key/dialog/get_key_dialog.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/screen/key/key_edit_page.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/screen/key/model/key_model.dart';
import 'package:flutter_balcoder_medicalapp/utils/components/key_card.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class KeyScreen extends StatefulWidget {
  KeyScreen({required this.userModel});

  UserModel userModel;
  @override
  _KeyScreenState createState() => _KeyScreenState();
}

class _KeyScreenState extends State<KeyScreen> {
  final lockerCollection =
      FirebaseFirestore.instance.collection('lockerCollection');

  @override
  void initState() {
    super.initState();

    print("HOME SCREEN");
    print(widget.userModel.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kbackGroundLight,
      child: StreamBuilder(
        stream: lockerCollection
            .where("isDeleted", isEqualTo: false)
            .where("isPayment", isEqualTo: true)
            .where("uid", isEqualTo: widget.userModel.uid)
            // .orderBy("createdDate", descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          List<LockerModel> lockerList = [];
          List<Widget> children = [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  'Mis Dispositivos',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600, // light
                      color: kTextColor),
                ),
              ),
            ),
          ];
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: kbackGround,
                  ),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              );
            default:
              final DateFormat formatter = DateFormat('yyyy-MM-dd');

              snapshot.data!.docs.forEach((doc) {
                lockerList.add(
                    new LockerModel.fromSnapshot(data: doc.data(), id: doc.id));
              });

              var i = 0;

              children = children +
                  lockerList.map<Widget>((locker) {
                    i++;

                    final lastKey = locker.keyList!.last;

                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: KeyCard(
                          isEmpty: false,
                          nameKey: "${locker.keyList![0].keyName}",
                          createdDate: formatter
                              .format(locker.createdDate!.toDate())
                              .toString(),
                          descriptionKey: 'x' +
                              (lastKey.keyName != null
                                      ? locker.keyList!.length
                                      : locker.keyList!.length - 1)
                                  .toString() +
                              ((locker.keyList!.length - 1) == 1
                                  ? ' Dispositivo'
                                  : ' Dispositivos'),
                          position: i,
                          onTap: () {
                            print(locker.key);
                            showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (context) => GetKeyDialog(
                                      userModel: widget.userModel,
                                      lockerModel: locker,
                                    ));
                          }),
                      secondaryActions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 24.0, right: 24, bottom: 4),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconSlideAction(
                                caption: 'Editar',
                                color: Colors.transparent,
                                icon: Icons.more_horiz,
                                onTap: () async => await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => KeyEditPage(
                                            position: i,
                                            userModel: widget.userModel,
                                            lockerModel: locker))),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 24.0, right: 24, bottom: 4),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconSlideAction(
                                caption: 'Eliminar',
                                color: Colors.transparent,
                                icon: Icons.delete,
                                onTap: () {
                                  final popup = BeautifulPopup(
                                    context: context,
                                    template: TemplateFail,
                                  );

                                  popup.show(
                                    title: '¿Está seguro?',
                                    content:
                                        'Esta acción eliminará el registro para siempre, no lograremos encontrar nuevamente esta información para usted. ¿Desea eliminarlo?',
                                    actions: [
                                      popup.button(
                                        label: 'Eliminar',
                                        onPressed: () async {
                                          locker.isDeleted = true;

                                          await FirebaseFirestore.instance
                                              .collection('lockerCollection')
                                              .doc(locker.key)
                                              .update(locker.toJson())
                                              .then((result) async {
                                            print("GUARDO key");

                                            Navigator.of(context).pop();
                                          }).catchError((err) => print(err));
                                        },
                                      ),
                                    ],
                                    // bool barrierDismissible = false,
                                    // Widget close,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList();

              children.add(KeyCard(
                  isEmpty: true,
                  nameKey: '',
                  createdDate: '',
                  descriptionKey: '',
                  position: i + 1,
                  onTap: () {
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) => AddLockerDialog(
                            position: i + 1,
                            isFromMyKey: true,
                            lockerModel: new LockerModel(),
                            userModel: widget.userModel));
                  }));

              children.add(Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text(
                    'Dashboard',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600, // light
                        color: kTextColor),
                  ),
                ),
              ));

              children.add(Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Container(
                      height: 240,
                      color: Colors.grey,
                    )),
              ));

              return ListView(
                children: children,
              );
          }
        },
      ),
    );
  }
}
