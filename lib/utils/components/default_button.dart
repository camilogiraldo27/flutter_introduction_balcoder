import 'package:flutter/material.dart';

import '../constant.dart';

class DefaultButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback press;
  const DefaultButton({
    Key? key,
    required this.color,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 284,
      child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: press,
          color: color,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }
}
