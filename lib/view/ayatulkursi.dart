import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tasbih/globals.dart';

class AyatulKursi extends StatefulWidget {
  const AyatulKursi({super.key});

  @override
  State<AyatulKursi> createState() => _AyatulKursiState();
}

class _AyatulKursiState extends State<AyatulKursi> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool isPlaying = false;

  // Example audio URL
  final String audioUrl =
      "https://cdn.islamic.network/quran/audio/128/ar.alafasy/262.mp3";

  @override
  void initState() {
    super.initState();
    _initializeAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text(
            'আয়াতুল কুরসি',
            style: TextStyle(fontFamily: 'Kalpurush'),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              child: Column(
                children: [
                  Card(
                    color: Theme.of(context).colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 5, right: 15, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Play/Pause Button
                              StreamBuilder<PlayerState>(
                                stream: _audioPlayer.playerStateStream,
                                builder: (context, snapshot) {
                                  final playerState = snapshot.data;
                                  final isPlaying =
                                      playerState?.playing ?? false;
                                  final processingState =
                                      playerState?.processingState;

                                  if (processingState ==
                                          ProcessingState.loading ||
                                      processingState ==
                                          ProcessingState.buffering) {
                                    return const CircularProgressIndicator();
                                  } else if (isPlaying) {
                                    return IconButton(
                                      icon: const Icon(Icons.pause,
                                          size: 36, color: Colors.green),
                                      onPressed: _audioPlayer.pause,
                                    );
                                  } else {
                                    return IconButton(
                                      icon: const Icon(Icons.play_arrow,
                                          size: 36, color: Colors.green),
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
                                    final maxDuration =
                                        totalDuration.inSeconds > 0
                                            ? totalDuration.inSeconds.toDouble()
                                            : currentPosition.inSeconds
                                                .toDouble();

                                    return Stack(
                                      children: [
                                        // Buffered portion
                                        SliderTheme(
                                          data: const SliderThemeData(
                                            thumbShape: RoundSliderThumbShape(
                                                enabledThumbRadius:
                                                    0), // Hide thumb
                                            trackHeight:
                                                2, // Make the track a bit thicker
                                          ),
                                          child: Slider(
                                            value: bufferedPosition.inSeconds
                                                .toDouble(),
                                            max: maxDuration,
                                            activeColor: Colors
                                                .lightBlue, // Buffered portion color
                                            inactiveColor: Colors.grey
                                                .shade400, // Remaining portion color
                                            onChanged: null, // Non-draggable
                                          ),
                                        ),
                                        // Played portion
                                        Slider(
                                          value: currentPosition.inSeconds
                                              .toDouble(),
                                          max: maxDuration,
                                          activeColor: Colors
                                              .green, // Played portion color
                                          inactiveColor: Colors
                                              .transparent, // Transparent to show buffered color below
                                          onChanged: (value) async {
                                            await _audioPlayer.seek(Duration(
                                                seconds: value.toInt()));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),

                              // Time Display
                              SizedBox(
                                width: 70, // Width of the volume slider
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
                                      style: const TextStyle(fontSize: 13),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'اللّٰهُ لَاۤ اِلٰهَ اِلَّا هُوَ الۡحَـىُّ الۡقَيُّوۡمُۚ لَا تَاۡخُذُهٗ سِنَةٌ وَّلَا نَوۡمٌ​ؕ لَهٗ مَا فِى السَّمٰوٰتِ وَمَا فِى الۡاَرۡضِ​ؕ مَنۡ ذَا الَّذِىۡ يَشۡفَعُ عِنۡدَهٗۤ اِلَّا بِاِذۡنِهٖ​ؕ يَعۡلَمُ مَا بَيۡنَ اَيۡدِيۡهِمۡ وَمَا خَلۡفَهُمۡ​ۚ وَلَا يُحِيۡطُوۡنَ بِشَىۡءٍ مِّنۡ عِلۡمِهٖۤ اِلَّا بِمَا شَآءَ ۚ وَسِعَ كُرۡسِيُّهُ السَّمٰوٰتِ وَالۡاَرۡضَ​​ۚ وَلَا يَـــُٔوۡدُهٗ حِفۡظُهُمَا ​ۚ وَ هُوَ الۡعَلِىُّ الۡعَظِيۡمُ‏ ٢٥٥',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'আল্লাহ, তিনি ছাড়া সত্যিকারের কোন উপাস্য নেই, তিনি চিরঞ্জীব, সর্বদা রক্ষণাবেক্ষণকারী। তাঁকে তন্দ্রা ও নিদ্রা স্পর্শ করে না। আকাশমন্ডলে ও ভূমন্ডলে যা কিছু আছে, তাঁরই। কে সেই ব্যক্তি যে তাঁর অনুমতি ছাড়া তাঁর নিকট সুপারিশ করে? তিনি লোকদের সমুদয় প্রকাশ্য ও অপ্রকাশ্য অবস্থা জানেন। পক্ষান্তরে মানুষ তাঁর জ্ঞানের কোনকিছুই আয়ত্ত করতে সক্ষম নয়, তিনি যে পরিমাণ ইচ্ছে করেন সেটুকু ছাড়া। তাঁর কুরসী আকাশ ও পৃথিবী পরিবেষ্টন করে আছে এবং এ দু’য়ের রক্ষণাবেক্ষণ তাঁকে ক্লান্ত করে না, তিনি উচ্চ মর্যাদাশীল, মহান।',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Kalpurush',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _thisCard(title, subtitle, IconData iconname1, IconData iconname2) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        elevation: 1.5,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(fontSize: 15),
          ),
          leading: Icon(iconname1),
          trailing: Icon(iconname2),
          onTap: () {
            tasbihArabic = title;
            tasbihEnBn = subtitle;
            Navigator.pop(context);
          },
        ),
      ),
    );
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
}
