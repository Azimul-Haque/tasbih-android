import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      int? themeModeIndex = prefs.getInt('themeMode');
      _themeMode = ThemeMode.values[themeModeIndex ?? 2]; // default to system
    });
  }

  _saveThemeMode(ThemeMode themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeMode', themeMode.index);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: HomeScreen(
        onThemeChanged: (themeMode) {
          setState(() {
            _themeMode = themeMode;
            _saveThemeMode(themeMode);
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Function(ThemeMode) onThemeChanged;

  const HomeScreen({required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Mode Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => onThemeChanged(ThemeMode.light),
              child: Text('Light Mode'),
            ),
            ElevatedButton(
              onPressed: () => onThemeChanged(ThemeMode.dark),
              child: Text('Dark Mode'),
            ),
            ElevatedButton(
              onPressed: () => onThemeChanged(ThemeMode.system),
              child: Text('Auto Mode'),
            ),
          ],
        ),
      ),
    );
  }
}
