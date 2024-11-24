import 'package:flutter/material.dart';
import 'package:tasbih/components/box.dart';
import 'package:tasbih/components/button.dart';
import 'package:tasbih/components/drawer.dart';
import 'package:tasbih/globals.dart';

class TasbihList extends StatefulWidget {
  final String title;
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  const TasbihList({
    super.key,
    required this.title,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<TasbihList> createState() => _TasbihListState();
}

class _TasbihListState extends State<TasbihList> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: MyDrawer(
        color: Theme.of(context).colorScheme.secondary,
        // switchdata: Switch(
        //   value: widget.isDarkMode,
        //   onChanged: (bool value) {
        //     widget.toggleTheme(value);
        //   },
        // ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyBox(
              height: 150,
              widht: 150,
              color: Theme.of(context).colorScheme.secondary,
              child: MyButton(
                title: convertToBanglaNumber('$_counter'),
                titlesize: 50,
                color: Theme.of(context).colorScheme.primary,
                ontapfunction: _incrementCounter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
