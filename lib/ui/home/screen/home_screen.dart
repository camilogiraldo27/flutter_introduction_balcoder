// import 'package:flutter/material.dart';
// import 'package:flutter_balcoder_medicalapp/ui/auth/model/user_model.dart';
// import 'package:flutter_balcoder_medicalapp/ui/home/screen/key/dialog/subscribe_dialog.dart';
// import 'package:flutter_balcoder_medicalapp/utils/constant.dart';

// class HomeScreen extends StatefulWidget {
//   HomeScreen({required this.userModel});

//   UserModel userModel;
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     print("HOME SCREEN");

//     // Future.delayed(Duration(milliseconds: 100)).then((_) {
//     //   if (widget.userModel.isSubscribed == false) {
//     //     print("SHW DIALOG");
//     //     showDialog(
//     //         barrierDismissible: false,
//     //         context: context,
//     //         builder: (context) => SubscribeDialog(
//     //               userModel: widget.userModel,
//     //             ));
//     //   }
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double _height = MediaQuery.of(context).size.height;
//     return Container(
//       color: kbackGroundLight,
//       child: Column(
//         children: [
//           Spacer(),
//           CircleAvatar(
//             radius: 30.0,
//             backgroundImage: AssetImage(
//               "assets/images/Okeyyy_icon.png",
//             ),
//             backgroundColor: Colors.transparent,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 12.0, bottom: 25),
//             child: Text(
//               widget.userModel.name!,
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w300, // light
//                   color: kTextColor),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 25.0, bottom: 15),
//             child: Text(
//               'En este momento su cuenta se encuentra activa; a continuación  encontrará una lista de los productos MedicalApp adquiridos:',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600, // light
//                   color: Colors.black54),
//             ),
//           ),
//           Spacer(),
//           Container(
//             height: 100,
//             decoration: BoxDecoration(
//                 color: kbackGround,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(35),
//                   topRight: Radius.circular(35),
//                 )),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 12, left: 24, right: 24),
//                   child: Row(
//                     children: [
//                       Spacer(),
//                       Container(
//                         decoration: BoxDecoration(
//                             color: kPrimaryColor,
//                             borderRadius: BorderRadius.circular(4)),
//                         child: Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: Icon(
//                             Icons.vpn_key_sharp,
//                             color: Colors.white,
//                             size: 24,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Text(
//                         'Almacenamiento de llaves',
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w400, // light
//                             color: kPrimaryColor),
//                       ),
//                       Spacer(),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 12, left: 24, right: 24),
//                   child: Row(
//                     children: [
//                       Spacer(),
//                       Container(
//                         decoration: BoxDecoration(
//                             color: kPrimaryColor,
//                             borderRadius: BorderRadius.circular(4)),
//                         child: Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: Icon(
//                             Icons.fact_check_rounded,
//                             color: Colors.white,
//                             size: 24,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 24,
//                       ),
//                       Text(
//                         'Pedido de llaves 24 horas',
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w400, // light
//                             color: kPrimaryColor),
//                       ),
//                       Spacer(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
