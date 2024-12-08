import 'package:flutter/material.dart';
import 'package:tasbih/components/box.dart';
import 'package:tasbih/components/button.dart';
import 'package:tasbih/components/drawer.dart';
import 'package:tasbih/globals.dart';
import 'package:tasbih/view/tasbihlist.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // For HTTP requests

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
  String ayah = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    getAnAyah();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.rotate_right),
            onPressed: () {
              setState(() {
                _counter = 0;
                tasbihArabic = '';
                tasbihEnBn = '';
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Action for Settings
            },
          ),
        ],
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.topCenter,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                tasbihArabic,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ]),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.topCenter,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                tasbihEnBn,
                style: const TextStyle(fontSize: 18),
              ),
            ]),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: MyBox(
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
            ),
          ),
          // const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'আজকের আয়াত \n' + ayah,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TasbihList(
                      title: 'Tasbih List - তসবি তালিকা',
                    )),
          );
          setState(() {
            // Trigger rebuild to show updated tasbihEnBn value
          });
        },
        tooltip: 'তসবিহ নির্বাচন করুন',
        child: const Icon(Icons.lightbulb),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // _onBackPressed() {}
  Future<void> getAnAyah() async {
    try {
      // Sending GET request to the API
      String apiUrl = 'https://api.alquran.cloud/v1/ayah/262';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // If server returns a 200 OK response, parse the data
        Map<String, dynamic> data =
            json.decode(response.body); // Decoding the JSON response
        print(data['data']['text']); // Print the data for debugging
        setState(() {
          ayah = data['data']['text'];
        });

        // Handle the data as needed (e.g., store in state, show in UI)
      } else {
        // If server returns an error, throw an exception
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e'); // Handle any errors
    }
  }
}
