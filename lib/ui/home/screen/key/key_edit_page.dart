import 'package:flutter_balcoder_medicalapp/ui/auth/model/user_model.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/screen/key/dialog/add_locker_dialog.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/screen/key/dialog/edit_locker_dialog.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/screen/key/model/key_model.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KeyEditPage extends StatefulWidget {
  KeyEditPage(
      {required this.position,
      required this.userModel,
      required this.lockerModel});

  int position;
  UserModel userModel;
  LockerModel lockerModel;

  @override
  _KeyEditPageState createState() => _KeyEditPageState();
}

class _KeyEditPageState extends State<KeyEditPage> {
  bool isLoading = false;
  int quantityTotal = 0;
  int initKeyQuantity = 0;
  // List<KeyModel> keyList = [];

  final lockerCollection =
      FirebaseFirestore.instance.collection('lockerCollection');

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  initState() {
    quantityTotal = 0;

    if (widget.lockerModel.keyList!.length < 5) {
      widget.lockerModel.keyList!.add(new KeyModel());
    }
    final lastKey = widget.lockerModel.keyList!.last;

    if (lastKey.keyName == null) {
      initKeyQuantity = widget.lockerModel.keyList!.length - 1;
    } else {
      initKeyQuantity = widget.lockerModel.keyList!.length;
    }

    super.initState();
  }

  saveLocker() async {
    await FirebaseFirestore.instance
        .collection('lockerCollection')
        .doc(widget.lockerModel.key)
        .update(widget.lockerModel.toJson())
        .then((result) async {
      print("GUARDO key");
      Navigator.pop(context);
    }).catchError((err) => print(err));
  }

  void mercadoPagoERROR(error) {
    print("error $error");
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return isLoading
        ? Container(
            color: kbackGround,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : new WillPopScope(
            onWillPop: _onWillPop,
            child: new Scaffold(
              key: _scaffoldKey,
              body: SafeArea(
                child: Column(
                  children: [
                    Spacer(),
                    Text(
                      'Conectar un\nDispositivo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w700, // light
                          color: kPrimaryColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 55.0, right: 55.0, top: 37),
                      child: Text(
                        'Seleccione su dispositivo a continuación y establesca una conexión.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500, // light
                            color: kTextColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20.0),
                          height: 200.0,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 77),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.lockerModel.keyList!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 28),
                                      child: widget.lockerModel.keyList![index]
                                                  .keyName ==
                                              null
                                          ? GestureDetector(
                                              onTap: () async {
                                                widget.lockerModel.isPayment!
                                                    ? await showDialog(
                                                        barrierDismissible:
                                                            true,
                                                        context: context,
                                                        builder: (context) =>
                                                            EditLockerDialog(
                                                                keyModel: widget
                                                                        .lockerModel
                                                                        .keyList![
                                                                    index]))
                                                    : await showDialog(
                                                        barrierDismissible:
                                                            true,
                                                        context: context,
                                                        builder: (context) =>
                                                            AddLockerDialog(
                                                                isFromMyKey:
                                                                    false,
                                                                lockerModel: widget
                                                                    .lockerModel,
                                                                userModel: widget
                                                                    .userModel));

                                                if (widget
                                                    .lockerModel.isPayment!) {
                                                  print(
                                                      "YA AGREGO PERO EDITANDO");
                                                  if (widget.lockerModel
                                                          .keyList!.length <
                                                      5) {
                                                    widget.lockerModel.keyList!
                                                        .add(new KeyModel());
                                                  }
                                                }
                                              },
                                              child: Container(
                                                height: 200.0,
                                                width: 180.0,
                                                decoration: BoxDecoration(
                                                    color: kPrimaryGray,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 32.0,
                                                              bottom: 24),
                                                      child: Container(
                                                        height: 30.0,
                                                        width: 140,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        child: Center(
                                                          child: Text(
                                                            "Agregar Dispositivo",
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600, // light
                                                                color:
                                                                    kSecondaryColor),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 50.0,
                                                              bottom: 24),
                                                      child: Container(
                                                        height: 40.0,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                kbackGroundDark,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            40))),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 32,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                if (!widget
                                                    .lockerModel.isPayment!) {
                                                  if (index > 0 && index < 4) {
                                                    setState(() {
                                                      widget
                                                          .lockerModel.keyList!
                                                          .removeAt(index);
                                                    });
                                                  } else {
                                                    if (index == 4) {
                                                      setState(() {
                                                        widget.lockerModel
                                                                    .keyList![
                                                                index] =
                                                            new KeyModel();
                                                      });
                                                    }
                                                  }

                                                  final lastKey = widget
                                                      .lockerModel
                                                      .keyList!
                                                      .last;

                                                  setState(() {
                                                    if (widget
                                                                .lockerModel
                                                                .keyList!
                                                                .length ==
                                                            4 &&
                                                        lastKey.keyName !=
                                                            null) {
                                                      widget
                                                          .lockerModel.keyList!
                                                          .add(new KeyModel());
                                                    }
                                                  });
                                                } else {
                                                  if (initKeyQuantity <=
                                                      index) {
                                                    setState(() {
                                                      widget
                                                          .lockerModel.keyList!
                                                          .removeAt(index);
                                                    });
                                                  } else {
                                                    _scaffoldKey.currentState!
                                                        .showSnackBar(SnackBar(
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Colors.red,
                                                      content: Text(
                                                        "Dispositivos no pueden ser eliminadas.",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ));
                                                  }
                                                }
                                              },
                                              child: Container(
                                                child: Stack(
                                                  children: [
                                                    SvgPicture.asset(
                                                      widget.position == 1
                                                          ? index == 0
                                                              ? "assets/images/key_25000.svg"
                                                              : "assets/images/key_5000.svg"
                                                          : "assets/images/key_5000.svg",
                                                      height: 200.0,
                                                      width: 180.0,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 60.0),
                                                      child: Container(
                                                        height: 70.0,
                                                        width: 180,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                kPrimaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12.0),
                                                            child: Text(
                                                              widget
                                                                  .lockerModel
                                                                  .keyList![
                                                                      index]
                                                                  .keyDescription!,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300, // light
                                                                  color:
                                                                      kDialogBackGround),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned.fill(
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 35),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {
                                                              await showDialog(
                                                                  barrierDismissible:
                                                                      true,
                                                                  context:
                                                                      context,
                                                                  builder: (context) => EditLockerDialog(
                                                                      keyModel: widget
                                                                          .lockerModel
                                                                          .keyList![index]));

                                                              if (widget
                                                                  .lockerModel
                                                                  .isPayment!) {
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'lockerCollection')
                                                                    .doc(widget
                                                                        .lockerModel
                                                                        .key)
                                                                    .update(widget
                                                                        .lockerModel
                                                                        .toJson())
                                                                    .then(
                                                                        (result) async {
                                                                  print(
                                                                      "GUARDO key");
                                                                }).catchError(
                                                                        (err) =>
                                                                            print(err));
                                                              }
                                                            },
                                                            child: Text(
                                                              widget
                                                                  .lockerModel
                                                                  .keyList![
                                                                      index]
                                                                  .keyName!,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600, // light
                                                                  color:
                                                                      kTextColor),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                    );
                                  })
                              // child: ListView.builder(
                              //     scrollDirection: Axis.horizontal,
                              //     itemCount: 5,
                              //     itemBuilder: (BuildContext context, int index) {
                              //       return Padding(
                              //         padding: const EdgeInsets.only(right: 28),
                              //         child: GestureDetector(
                              //           onTap: () {
                              //             return showDialog(
                              //                 barrierDismissible: true,
                              //                 context: context,
                              //                 builder: (context) => AddLockerDialog(
                              //                     userModel: widget.userModel));
                              //           },
                              //           child: Container(
                              //             width: 180.0,
                              //             color: Colors.red,
                              //           ),
                              //         ),
                              //       );
                              //     }),
                              )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        'Almacenamiento de Dispositivos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600, // light
                            color: kTextColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 32.0, top: 12),
                      child: Text(
                        'Los Dispositivos seleccionados serán conectados y se generará una alerta conjunto al correo electrónico suministrado.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500, // light
                            color: kTextColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, left: 24.0, right: 24.0, bottom: 12.0),
                      child: Container(
                        height: 35,
                        child: Row(
                          children: [
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isLoading = true;
                                });
                                if (widget.lockerModel.isPayment!) {
                                  final lastKey =
                                      widget.lockerModel.keyList!.last;
                                  int diffQuantity = 0;

                                  diffQuantity =
                                      widget.lockerModel.keyList!.length -
                                          initKeyQuantity;

                                  if (lastKey.keyName == null) {
                                    diffQuantity = diffQuantity - 1;
                                  }

                                  print(diffQuantity);

                                  if (diffQuantity == 0) {
                                    Navigator.of(context).pop();
                                  } else {
                                    saveLocker();
                                  }
                                } else {
                                  if (widget.position == 1) {
                                    final lastKey =
                                        widget.lockerModel.keyList!.last;

                                    if (lastKey.keyName == null) {
                                      saveLocker();
                                    } else {
                                      saveLocker();
                                    }
                                  } else {
                                    if (widget.lockerModel.keyList!.length ==
                                        5) {
                                      final lastKey =
                                          widget.lockerModel.keyList!.last;

                                      if (lastKey.keyName == null) {
                                        saveLocker();
                                      }
                                    } else {
                                      saveLocker();
                                    }
                                  }
                                }
                              },
                              child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  color: kbackGroundDark,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Center(
                                  child: Text("Aceptar"),
                                ),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {
                                widget.lockerModel.isDeleted = true;

                                if (!widget.lockerModel.isPayment!) {
                                  await FirebaseFirestore.instance
                                      .collection('lockerCollection')
                                      .doc(widget.lockerModel.key)
                                      .update(widget.lockerModel.toJson())
                                      .then((result) async {
                                    print("GUARDO key");

                                    Navigator.of(context).pop();
                                  }).catchError((err) => print(err));
                                } else {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  color: kDialogBackGround,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Center(
                                  child: Text("Volver"),
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ),
            ));
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('¿Está seguro?'),
            content: new Text('Desea cancelar el proceso'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () async {
                  widget.lockerModel.isDeleted = true;

                  await FirebaseFirestore.instance
                      .collection('lockerCollection')
                      .doc(widget.lockerModel.key)
                      .update(widget.lockerModel.toJson())
                      .then((result) async {
                    print("GUARDO key");

                    Navigator.of(context).pop(true);
                  }).catchError((err) => print(err));
                },
                child: new Text('Cancelar'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
