import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/service/auth.service.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/service/root_service.dart';
import 'package:flutter_balcoder_medicalapp/ui/blue/custom_blue.dart';
import 'package:flutter_balcoder_medicalapp/ui/boarding/model/onboard_page_item.dart';
import 'package:flutter_balcoder_medicalapp/ui/boarding/onboarding_screen.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/root_screen.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_balcoder_medicalapp/ui/notification/in_app_update.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';
import 'package:package_info/package_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static const MaterialColor kPrimaryTheme = MaterialColor(
    0xFF3d6d79,
    <int, Color>{
      50: kPrimaryColor,
      100: kPrimaryColor,
      200: kPrimaryColor,
      300: kPrimaryColor,
      400: kPrimaryColor,
      500: kPrimaryColor,
      600: kPrimaryColor,
      700: kPrimaryColor,
      800: kPrimaryColor,
      900: kPrimaryColor,
    },
  );

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PackageInfo? packageInfo;

  String? version;
  bool showInAppUpdater = true;

  getAppInfo() async {
    packageInfo = await PackageInfo.fromPlatform();

    version = packageInfo!.version;

    await FirebaseFirestore.instance
        .collection('versionCollection')
        .doc('AndroidApp')
        .get()
        .then((value) {
      showInAppUpdate(value.data());
    });

    print('PackageInfo: ' + version!);
  }

  showInAppUpdate(data) {
    if (data['version'] == version) {
      setState(() {
        showInAppUpdater = false;
      });
    } else {
      setState(() {
        showInAppUpdater = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAppInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedicalApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MyApp.kPrimaryTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: !showInAppUpdater
          ? SplashScreen()
          : MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'MedicalApp',
              theme: ThemeData(
                primaryColor: Colors.white,
                fontFamily: 'Nexa',
              ),
              // home: new RootPage(auth: new Auth())
              home: InAppUpdatePage(
                onboardPageItem: OnboardPageItem(
                  lottieAsset: 'assets/animations/404-not-found.json',
                  text:
                      'Necesitas estar actualizado,\ndescarga la ultima versión de la app.',
                ),
              ) // routes: routes,
              // initialRoute: '/',
              ),
      routes: <String, WidgetBuilder>{
        '/OnBoardingScreen': (BuildContext context) => new OnBoardingScreen(),
        '/RootService': (BuildContext context) =>
            new RootService(auth: new Auth()),
        '/RootHomeScreen': (BuildContext context) => new RootHomeScreen(
              auth: new Auth(),
            ),
      },
    );
  }
}
