// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

String tasbihArabic = '';
String tasbihEnBn = '';

String convertToBanglaNumber(String englishNumber) {
  const englishToBanglaDigits = {
    '0': '০',
    '1': '১',
    '2': '২',
    '3': '৩',
    '4': '৪',
    '5': '৫',
    '6': '৬',
    '7': '৭',
    '8': '৮',
    '9': '৯',
  };

  return englishNumber.split('').map((char) {
    return englishToBanglaDigits[char] ?? char;
  }).join('');
}

// pageAppBar(String appbarname, BuildContext context) {
//   return AppBar(
//     title: Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           appbarname,
//           style: const TextStyle(
//             // fontFamily: 'HindSiliguri',
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     ),
//     flexibleSpace: appBarStyle(),
//     backgroundColor: Colors.transparent,
//     automaticallyImplyLeading: true,
//     iconTheme: const IconThemeData(color: Colors.white),
//   );
// }

// appBarStyle() {
//   return Container(
//     decoration: const BoxDecoration(
//       gradient: LinearGradient(
//         colors: [
//           Color.fromARGB(255, 23, 124, 117),
//           Color.fromARGB(255, 26, 148, 140),
//         ],
//         begin: FractionalOffset(0.0, 0.0),
//         end: FractionalOffset(1.0, 0.0),
//         stops: [0.0, 1.0],
//         tileMode: TileMode.clamp,
//       ),
//     ),
//   );
// }

showSnackBar(context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3), // Snackbar will disappear in 3 seconds
    ),
  );
}
