import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SupportScreen extends StatefulWidget {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  bool showSVG = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1000)).then((_) {
      setState(() {
        showSVG = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
