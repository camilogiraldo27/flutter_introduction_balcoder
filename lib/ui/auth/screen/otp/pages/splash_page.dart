import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/model/user_model.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/screen/otp/pages/login_page.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/screen/otp/stores/login_store.dart';
import 'package:flutter_balcoder_medicalapp/ui/auth/service/auth.service.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  SplashPage(
      {Key? key,
      required this.auth,
      required this.onSignedIn,
      required this.userModel})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedIn;
  UserModel userModel;
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<LoginStore>(context, listen: false)
        .isAlreadyAuthenticated()
        .then((result) {
      if (result) {
        Navigator.of(context).pushReplacementNamed('/RootHomeScreen');
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white);
  }
}
