import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/model/user_model.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/service/auth.service.dart';
import 'package:flutter_balcoder_medicalapp/ui/user/user_trip_page.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';

class UserTripListPage extends StatefulWidget {
  UserTripListPage(
      {required this.userModel, required this.auth, required this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  UserModel userModel;
  @override
  _UserTripListPageState createState() => _UserTripListPageState();
}

class _UserTripListPageState extends State<UserTripListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late PageController _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    print("isSubscribed");
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    print(_height);
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Container(
        width: _width * 0.6,
        decoration: BoxDecoration(
          color: kbackGround,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 75,
            ),
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: kPrimaryColor,
                      size: 28,
                    ),
                    Spacer(),
                    Text(
                      'Menú',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800, // light
                          color: kPrimaryColor),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  Spacer(),
                  Text(
                    'Perfil',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400, // light
                        color: kPrimaryColor),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Icon(
                    Icons.notification_important,
                    color: kPrimaryColor,
                  ),
                  Spacer(),
                  Text(
                    'Notificaciones',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400, // light
                        color: kPrimaryColor),
                  ),
                  Spacer(),
                ],
              ),
            ),
            GestureDetector(
              onTap: _onWillSingOut,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: kPrimaryColor,
                    ),
                    Spacer(),
                    Text(
                      'Salir',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400, // light
                          color: kPrimaryColor),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Spacer(),
                  Text(
                    'www.flutter-medicalapp.web.app',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800, // light
                        color: kPrimaryColor),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: _height * 0.4,
            decoration: BoxDecoration(
              color: kbackGround,
            ),
          ),
          Container(
            height: _height * 0.2,
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(120, 30),
                    bottomRight: Radius.elliptical(120, 30))),
          ),
          Column(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
                      child: Icon(
                        Icons.list_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            'Seguridad es mantenerse prevenido',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700, // light
                                color: kPrimaryColor),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Mantenga siempre su información médica\ncon nosotros y comparta los resultado\n con sus familiares o allegados.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400, // light
                                color: kTextColor),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  )),
              Container(
                height: _height * 0.624,
                child: UserTripPage(userModel: widget.userModel),
              ),
            ],
          )
        ],
      ),
    );
  }

  _onWillSingOut() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('¿Está seguro?'),
        content: new Text('¿Desea cerrar sesión?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () async {
              Navigator.of(context).pop(false);
              try {
                await widget.auth.signOut();
                widget.onSignedOut();
              } catch (e) {
                print(e);
              }
            },
            child: new Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
