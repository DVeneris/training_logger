// import 'package:flutter/material.dart';

// class ClockialogSmall extends StatefulWidget {
//   const ClockialogSmall({super.key});

//   @override
//   State<ClockialogSmall> createState() => _ClockialogSmallState();
// }

// class _ClockialogSmallState extends State<ClockialogSmall> {
//   @override
//   Widget build(BuildContext context) {
//     return showGeneralDialog(
//       barrierLabel: "Label",
//       barrierDismissible: true,
//       barrierColor: Colors.black.withOpacity(0.5),
//       transitionDuration: Duration(milliseconds: 700),
//       context: context,
//       pageBuilder: (context, anim1, anim2) {
//         return Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             height: 300,
//             child: SizedBox.expand(child: FlutterLogo()),
//             margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(40),
//             ),
//           ),
//         );
//       },
//       transitionBuilder: (context, anim1, anim2, child) {
//         return SlideTransition(
//           position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
//           child: child,
//         );
//       },
//   }
// }