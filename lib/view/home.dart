import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasbih/components/box.dart';
import 'package:tasbih/components/button.dart';
import 'package:tasbih/components/drawer.dart';
import 'package:tasbih/globals.dart';
import 'package:tasbih/view/tasbihlist.dart';
import 'dart:convert';
// ignore: library_prefixes
import 'package:flutter/services.dart' as rootBundle;
import 'package:http/http.dart' as http;

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
  List<AyahModel> bnayahs = [];
  int _counter = 0;
  String ayahid = '';
  String ayah = '';
  String surah = '';
  String ayahnumber = '';
  String ahayinbn = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    getAnAyah();
    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontFamily: 'HindSiliguri'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.rotate_right),
            onPressed: () {
              showConfirmationDialog();
            },
            tooltip: 'মুছে দিন',
          ),
          // IconButton(
          //   icon: const Icon(Icons.settings),
          //   onPressed: () {
          //     // Action for Settings
          //   },
          //   tooltip: 'সেটিংস',
          // ),
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
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
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
          const SizedBox(height: 50),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  MyBox(
                    height: 150,
                    widht: 150,
                    color: Theme.of(context).colorScheme.secondary,
                    child: MyButton(
                        title: convertToBanglaNumber('$_counter'),
                        titlesize: 50,
                        color: Theme.of(context).colorScheme.primary,
                        ontapfunction: _incrementCounter,
                        fontfamily: 'Kalpurush'),
                  ),
                  Text(
                    'উপরের বক্সে ট্যাপ করুন',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Kalpurush',
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'আজকের আয়াত: [$surah:$ayahnumber]\n$ayah\n($ahayinbn)',
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Kalpurush',
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TasbihList(
                title: 'Tasbih List - তসবি তালিকা',
              ),
            ),
          );
          setState(() {
            // Trigger rebuild to show updated tasbihEnBn value
          });
        },
        tooltip: 'তসবিহ নির্বাচন করুন',
        child: const Icon(Icons.lightbulb),
      ),
    );
  }

  // _onBackPressed() {}
  Future<void> getAnAyah() async {
    var rng = Random();
    int randomNumber = rng.nextInt(6236) + 1;
    try {
      // Sending GET request to the API
      String apiUrl = 'https://api.alquran.cloud/v1/ayah/$randomNumber';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // If server returns a 200 OK response, parse the data
        Map<String, dynamic> data =
            json.decode(response.body); // Decoding the JSON response
        // print(data['data']); // Print the data for debugging
        setState(() {
          ayahid = data['data']['number'].toString();
          ayah = data['data']['text'];
          surah = data['data']['surah']['englishName'];
          ayahnumber = data['data']['numberInSurah'].toString();
        });
        ahayinbn = getAyahById(ayahid)!.text.toString();

        // Handle the data as needed (e.g., store in state, show in UI)
      } else {
        // If server returns an error, throw an exception
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // print('Error: $e'); // Handle any errors
    }
  }

  Future<void> loadJsonData() async {
    // Load the JSON file
    final String response =
        await rootBundle.rootBundle.loadString('assets/data/ayats_bn.json');
    final List<dynamic> data = json.decode(response);

    // Convert the JSON data to a list of AyahModel objects
    setState(() {
      bnayahs = data.map((item) => AyahModel.fromJson(item)).toList();
    });
  }

  AyahModel? getAyahById(String ayahnumber) {
    return bnayahs.firstWhere((ayah) => ayah.id == ayahnumber,
        orElse: () =>
            AyahModel(id: '0', sura: '0', aya: '0', text: 'Not Found'));
  }

  // Reusable confirmation dialog method
  Future<bool?> showConfirmationDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'নিশ্চিতকরণ',
            style: TextStyle(fontFamily: 'Kalpurush'),
          ),
          content: const Text(
            'আপনি কি নিশ্চিতভাবে কাউন্টারটি শূন্য করতে চান?',
            style: TextStyle(fontFamily: 'Kalpurush'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false
              },
              child: Text(
                'ফিরে যান',
                style: TextStyle(
                  fontFamily: 'Kalpurush',
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _counter = 0;
                  tasbihArabic = '';
                  tasbihEnBn = '';
                });
                Navigator.of(context).pop(true);
              },
              child: Text(
                'নিশ্চিত',
                style: TextStyle(
                  fontFamily: 'Kalpurush',
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class AyahModel {
  final String id;
  final String sura;
  final String aya;
  final String text;

  AyahModel(
      {required this.id,
      required this.sura,
      required this.aya,
      required this.text});

  // Method to create AyahModel from JSON
  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      id: json['id'],
      sura: json['sura'],
      aya: json['aya'],
      text: json['text'],
    );
  }
}
