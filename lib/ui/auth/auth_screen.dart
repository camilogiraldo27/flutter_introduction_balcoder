import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/screen/login_screen.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/screen/signup_screen.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/service/auth.service.dart';
import 'package:flutter_balcoder_medicalapp/utils/components/default_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key, required this.auth, required this.onSignedIn})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Center(
              child: SvgPicture.asset(
                'assets/images/Okeyyy_auth.svg',
                height: 186,
              ),
            ),
            Spacer(),
            Text(
              '¡Qué bueno \nconocerte!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w700, // light
                  color: kPrimaryColor),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 45.0, right: 45.0),
              child: Text(
                'MedicalApp es el más grande servicio de almacenamiento en la nube de información médica en Latinoamérica.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600, // light
                    color: kTextColor),
              ),
            ),
            Spacer(),
            Text(
              '¿Ya tienes una cuenta?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600, // light
                  color: kTextColor),
            ),
            SizedBox(
              height: 10,
            ),
            DefaultButton(
              color: kPrimaryColor,
              text: "Iniciar sesión",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => LoginScreen(
                              auth: widget.auth,
                              onSignedIn: widget.onSignedIn,
                            )));
              },
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              '¿Nuevo en MedicalApp?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600, // light
                  color: kTextColor),
            ),
            SizedBox(
              height: 10,
            ),
            DefaultButton(
              color: kPrimaryColor,
              text: "Crear cuenta",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SignupScreen(
                              auth: widget.auth,
                              onSignedIn: widget.onSignedIn,
                            )));
              },
            ),
            Spacer(),
            // Padding(
            //   padding: EdgeInsets.only(bottom: 30.0),
            //   child: SvgPicture.asset(
            //     "assets/images/term_cond.svg",
            //     height: 20.0,
            //     width: 149.0,
            //     fit: BoxFit.scaleDown,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
