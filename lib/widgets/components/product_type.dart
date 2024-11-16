// import 'package:flutter/material.dart';
//
// import '../../config/device_size.dart';
//
// class ProductType extends StatelessWidget {
//   final String type;
//   final IconData icon;
//
//   // TODO :: handle type behavior
//   const ProductType({
//     this.type = "test",
//     this.icon = Icons.abc,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: const Alignment(0, 0),
//       height: DeviceSize.myHeight(30),
//       width: DeviceSize.myWidth(340),
//       decoration: const BoxDecoration(
//         color: Color(0xFFFFFFFF),
//         boxShadow: [
//           BoxShadow(
//               offset: Offset(0, 2), blurRadius: 2, color: Color(0xE6000000)),
//         ],
//       ),
//       child: Row(
//         children: [
//           Text(type),
//           Icon(icon),
//         ],
//       ),
//     );
//   }
// }
