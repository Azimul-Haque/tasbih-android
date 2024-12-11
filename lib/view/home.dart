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
import 'package:http/http.dart' as http; // For HTTP requests
import 'package:just_audio/just_audio.dart';

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

  final AudioPlayer _audioPlayer = AudioPlayer();

  bool isPlaying = false;

  // Example audio URL
  final String audioUrl =
      "https://cdn.islamic.network/quran/audio/128/ar.alafasy/262.mp3";

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
    _initializeAudio();
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
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
// Row for play/pause, slider, and volume control
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Play/Pause Button
                    StreamBuilder<PlayerState>(
                      stream: _audioPlayer.playerStateStream,
                      builder: (context, snapshot) {
                        final playerState = snapshot.data;
                        final isPlaying = playerState?.playing ?? false;
                        final processingState = playerState?.processingState;

                        if (processingState == ProcessingState.loading ||
                            processingState == ProcessingState.buffering) {
                          return CircularProgressIndicator();
                        } else if (isPlaying) {
                          return IconButton(
                            icon:
                                Icon(Icons.pause, size: 36, color: Colors.blue),
                            onPressed: _audioPlayer.pause,
                          );
                        } else {
                          return IconButton(
                            icon: Icon(Icons.play_arrow,
                                size: 36, color: Colors.blue),
                            onPressed: _audioPlayer.play,
                          );
                        }
                      },
                    ),

                    // Progress Slider
                    Expanded(
                      child: // Slider for Played, Buffered, and Remaining Portions
                          StreamBuilder<Duration>(
                        stream: _audioPlayer.positionStream,
                        builder: (context, snapshot) {
                          final currentPosition =
                              snapshot.data ?? Duration.zero;
                          final bufferedPosition = _audioPlayer
                              .bufferedPosition; // Buffered position
                          final totalDuration =
                              _audioPlayer.duration ?? Duration.zero;
                          // If totalDuration is null (audio is finished), use currentPosition
                          final maxDuration = totalDuration.inSeconds > 0
                              ? totalDuration.inSeconds.toDouble()
                              : currentPosition.inSeconds.toDouble();

                          return Stack(
                            children: [
                              // Buffered portion
                              SliderTheme(
                                data: const SliderThemeData(
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 0), // Hide thumb
                                  trackHeight:
                                      3, // Make the track a bit thicker
                                ),
                                child: Slider(
                                  value: bufferedPosition.inSeconds.toDouble(),
                                  max: maxDuration,
                                  activeColor: Colors
                                      .lightBlue, // Buffered portion color
                                  inactiveColor: Colors
                                      .grey.shade400, // Remaining portion color
                                  onChanged: null, // Non-draggable
                                ),
                              ),
                              // Played portion
                              Slider(
                                value: currentPosition.inSeconds.toDouble(),
                                max: maxDuration,
                                activeColor:
                                    Colors.green, // Played portion color
                                inactiveColor: Colors
                                    .transparent, // Transparent to show buffered color below
                                onChanged: (value) async {
                                  await _audioPlayer
                                      .seek(Duration(seconds: value.toInt()));
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    // Time Display
                    SizedBox(
                      width: 100, // Width of the volume slider
                      child: // Time Display
                          StreamBuilder<Duration>(
                        stream: _audioPlayer.positionStream,
                        builder: (context, snapshot) {
                          final currentPosition =
                              snapshot.data ?? Duration.zero;
                          final totalDuration =
                              _audioPlayer.duration ?? Duration.zero;

                          return Text(
                            "${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')} / "
                            "${totalDuration.inMinutes}:${(totalDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                            style: TextStyle(fontSize: 16),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'আজকের আয়াত: [$surah:$ayahnumber] \n$ayah ($ahayinbn)',
              style: const TextStyle(fontSize: 18),
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
                    )),
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

  Future<void> _initializeAudio() async {
    try {
      await _audioPlayer.setUrl(audioUrl); // Load the audio file from URL
    } catch (e) {
      print("Error loading audio: $e");
    }

    // Listen for when the audio finishes
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        // When audio finishes, reset the slider to 0 and stop
        _audioPlayer.seek(Duration.zero);
        setState(() {
          // Ensure the play button is visible and audio remains paused
          _audioPlayer.pause();
        });
      }
    });
  }

  void _playAudio() async {
    await _audioPlayer.play();
    setState(() {
      isPlaying = true;
    });
  }

  void _pauseAudio() async {
    await _audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  void _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Release resources
    super.dispose();
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
