import 'package:flutter/material.dart';
import 'package:tasbih/components/box.dart';
import 'package:tasbih/components/button.dart';
import 'package:tasbih/components/drawer.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  const MyHomePage({
    super.key,
    required this.title,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        switchdata: Switch(
          value: widget.isDarkMode,
          onChanged: (bool value) {
            widget.toggleTheme(value);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyButton(
              title: 'ক্লিক করুন',
              color: Theme.of(context).colorScheme.primary,
              onTap: () {
                print('ক্লিক!');
              },
            ),
            MyBox(
              color: Theme.of(context).colorScheme.secondary,
              child: MyButton(
                title: 'ক্লিক করুন',
                color: Theme.of(context).colorScheme.primary,
                onTap: () {
                  print('ক্লিক!');
                },
              ),
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
