import 'package:flutter/material.dart';

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

pageAppBar(String appbarname, BuildContext context) {
  return AppBar(
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          appbarname,
          style: const TextStyle(
            // fontFamily: 'HindSiliguri',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    flexibleSpace: appBarStyle(),
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: true,
    iconTheme: const IconThemeData(color: Colors.white),
  );
}
