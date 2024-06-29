// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // NOT USING IT
// // NOT USING IT
// // NOT USING IT
// // NOT USING IT
// class UiProvider extends ChangeNotifier {
//   bool _isDark = false;
//   bool get isDark => _isDark;

//   late SharedPreferences storage;
//   //Dark mode toggle action
//   changeTheme() {
//     _isDark = !isDark;

//     //Save the value to secure storage
//     storage.setBool("isDark", _isDark);
//     notifyListeners();
//   }

//   //Init method of provider
//   init() async {
//     //After we re run the app
//     storage = await SharedPreferences.getInstance();
//     _isDark = storage.getBool("isDark") ?? false;
//     notifyListeners();
//   }
// }
