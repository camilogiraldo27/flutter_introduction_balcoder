import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/service/auth.service.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/service/root_service.dart';
import 'package:flutter_balcoder_medicalapp/ui/blue/custom_blue.dart';
import 'package:flutter_balcoder_medicalapp/ui/boarding/onboarding_screen.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/root_screen.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedicalApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: kPrimaryTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
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
