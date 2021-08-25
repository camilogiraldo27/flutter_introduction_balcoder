import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/service/auth.service.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/service/root_service.dart';
import 'package:flutter_balcoder_medicalapp/ui/boarding/onboarding_screen.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/root_screen.dart';
import 'package:flutter_balcoder_medicalapp/ui/home/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const MaterialColor kPrimaryTheme = MaterialColor(
    0xFF7966ff,
    <int, Color>{
      50: Color(0xFF7966ff),
      100: Color(0xFF7966ff),
      200: Color(0xFF7966ff),
      300: Color(0xFF7966ff),
      400: Color(0xFF7966ff),
      500: Color(0xFF7966ff),
      600: Color(0xFF7966ff),
      700: Color(0xFF7966ff),
      800: Color(0xFF7966ff),
      900: Color(0xFF7966ff),
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
