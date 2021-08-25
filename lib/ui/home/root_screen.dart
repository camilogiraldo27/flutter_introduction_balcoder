import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/model/user_model.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/service/auth.service.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/screen/home_screen.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/screen/key/key_screen.dart';
import 'package:flutter_balcoder_medicalapp/ui/support/support_screen.dart';
import 'package:flutter_balcoder_medicalapp/ui/user/user_trip_list_page.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';
import 'package:flutter_balcoder_medicalapp/main.dart';
import 'package:flutter_balcoder_medicalapp/utils/guide/widgets/bubble_indication_painter.dart';

class RootHomeScreen extends StatefulWidget {
  RootHomeScreen(
      {Key? key, required this.auth, this.userModel, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback? onSignedOut;
  UserModel? userModel;
  @override
  _RootHomeScreenState createState() => _RootHomeScreenState();
}

class _RootHomeScreenState extends State<RootHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  PageController _pageController = PageController(initialPage: 0);

  bool isColorBlack = true;

  bool isAdmin = true;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isColorBlack = true;

    _pageController = PageController(initialPage: 0);
    print("isSubscribed");

    if (widget.userModel != null) {
      widget.userModel!.isSubscribed =
          widget.userModel!.isSubscribed != null ? true : false;

      print(widget.userModel!.isSubscribed);
    } else {
      getCurrentUserLogged();
    }
  }

  getCurrentUserLogged() async {
    await widget.auth.getUser().then((value) => setState(() {
          widget.userModel = value;
        }));
  }

  Widget callPage(int current, _height, _width) {
    switch (current) {
      case 0:
        return new Scaffold(
            key: _scaffoldKey,
            endDrawer: Container(
              width: _width * 0.6,
              decoration: BoxDecoration(
                color: kbackGround,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
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
                  // Padding(
                  //   padding: const EdgeInsets.all(24.0),
                  //   child: Row(
                  //     children: [
                  //       Icon(
                  //         Icons.notification_important,
                  //         color: kPrimaryColor,
                  //       ),
                  //       Spacer(),
                  //       Text(
                  //         'Notificaciones',
                  //         textAlign: TextAlign.left,
                  //         style: TextStyle(
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.w400, // light
                  //             color: kPrimaryColor),
                  //       ),
                  //       Spacer(),
                  //     ],
                  //   ),
                  // ),
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
                  height: _height * 0.45,
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
                ListView(
                  children: [
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Row(
                        children: [
                          Spacer(),
                          GestureDetector(
                            onTap: () =>
                                _scaffoldKey.currentState!.openEndDrawer(),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: (_height > 640 ? _height * 0.5 : _height * 0.43),
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (i) {
                          setState(() {
                            isColorBlack = !isColorBlack;
                          });
                        },
                        children: <Widget>[
                          new ConstrainedBox(
                              constraints: const BoxConstraints.expand(),
                              child: KeyScreen(
                                userModel: widget.userModel!,
                              )),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ));
        break;
      case 1:
        setState(() {
          isColorBlack = true;
        });
        return new UserTripListPage(
          userModel: widget.userModel!,
          auth: widget.auth,
          onSignedOut: widget.onSignedOut!,
        );
        break;
      case 2:
        setState(() {
          isColorBlack = true;
        });
        return SupportScreen();
        break;

      default:
        return new Container();
    }
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
                widget.onSignedOut!();
              } catch (e) {
                print(e);
                Navigator.of(context).pop();
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MyApp()));
              }
            },
            child: new Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: kPrimaryColor,
      // appBar: AppBar(
      //   backgroundColor: kPrimaryColor,
      //   shadowColor: Colors.transparent,
      //   leading: GestureDetector(
      //     onTap: () async {
      //       _onWillSingOut();
      //     },
      //     child: Icon(Icons.arrow_back_ios),
      //   ),
      // ),
      body: callPage(_currentIndex, _height, _width),
      bottomNavigationBar: widget.userModel!.userType == "Usuario"
          ? BottomNavyBar(
              selectedIndex: _currentIndex,
              showElevation: true,
              itemCornerRadius: 24,
              curve: Curves.easeIn,
              onItemSelected: (index) {
                if (_currentIndex != index) {
                  setState(() => _currentIndex = index);
                }
              },
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Inicio'),
                  activeColor: kPrimaryColor,
                  textAlign: TextAlign.center,
                ),
                // BottomNavyBarItem(
                //   icon: Icon(Icons.map),
                //   title: Text('Mapa'),
                //   activeColor: kPrimaryColor,
                //   textAlign: TextAlign.center,
                // ),
                BottomNavyBarItem(
                  icon: Icon(Icons.history),
                  title: Text(
                    'Historial',
                  ),
                  activeColor: kPrimaryColor,
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.phone),
                  title: Text('Soporte'),
                  activeColor: kPrimaryColor,
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : null,
    );
  }
}
