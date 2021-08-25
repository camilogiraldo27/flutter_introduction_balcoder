// import 'package:flutter_balcoder_medicalapp/util/guide/widgets/custom_container_animated.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:simple_animations/simple_animations.dart';
// import 'package:supercharged/supercharged.dart';

// class Box extends StatelessWidget {
//   Box({this.text});

//   static final boxDecoration = BoxDecoration(
//       color: Colors.indigo[100],
//       borderRadius: BorderRadius.all(Radius.circular(10)),
//       boxShadow: [
//         BoxShadow(
//             color: Colors.black.withAlpha(60),
//             blurRadius: 5,
//             offset: Offset(0, 8),
//             spreadRadius: 2)
//       ]);
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return PlayAnimation<double>(
//       duration: 400.milliseconds,
//       tween: 0.0.tweenTo(80.0),
//       builder: (context, child, height) {
//         return PlayAnimation<double>(
//           duration: 600.milliseconds,
//           delay: 200.milliseconds,
//           tween: 2.0.tweenTo(300.0),
//           builder: (context, child, width) {
//             return Container(
//               decoration: boxDecoration,
//               child: TypewriterText(text),
//             );
//           },
//         );
//       },
//     );
//   }

//   bool isEnoughRoomForTypewriter(double width) => width > 20;
// }

// class TypewriterText extends StatelessWidget {
//   final String text;

//   TypewriterText(this.text);

//   @override
//   Widget build(BuildContext context) {
//     double c_width = MediaQuery.of(context).size.width * 0.8;

//     return PlayAnimation<int>(
//         duration: 800.milliseconds,
//         delay: 800.milliseconds,
//         tween: 0.tweenTo(text.length),
//         builder: (context, child, textLength) {
//           return Container(
//             padding: const EdgeInsets.all(16.0),
//             width: c_width,
//             child: new Column(
//               children: <Widget>[
//                 Text(text.substring(0, textLength),
//                     style: GoogleFonts.cabin(
//                       textStyle: TextStyle(
//                           fontSize: 18,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold),
//                     )),
//               ],
//             ),
//           );
//         });
//   }
// }

// class TypewriterBoxDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CustomContainerAnimated(
//       title: "Typewriter Box",
//       pathToFile: "typewriter_box.dart",
//       delayStartup: true,
//       builder: (context) => Center(child: Box()),
//     );
//   }
// }
