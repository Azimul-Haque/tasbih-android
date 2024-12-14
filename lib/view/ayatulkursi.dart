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
          title: const Text('আয়াতুল কুরসি'),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              child: Card(
                margin: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primary,
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
                            final isPlaying = playerState?.playing ?? false;
                            final processingState =
                                playerState?.processingState;

                            if (processingState == ProcessingState.loading ||
                                processingState == ProcessingState.buffering) {
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
                                          2, // Make the track a bit thicker
                                    ),
                                    child: Slider(
                                      value:
                                          bufferedPosition.inSeconds.toDouble(),
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
                                    value: currentPosition.inSeconds.toDouble(),
                                    max: maxDuration,
                                    activeColor:
                                        Colors.green, // Played portion color
                                    inactiveColor: Colors
                                        .transparent, // Transparent to show buffered color below
                                    onChanged: (value) async {
                                      await _audioPlayer.seek(
                                          Duration(seconds: value.toInt()));
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                        // Time Display
                        SizedBox(
                          width: 65, // Width of the volume slider
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
                                style: TextStyle(fontSize: 13),
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
            ),
            _thisCard('أَسْتَغْفِرُ ٱللَّٰهَ',
                'Astaghfirullah - আসতাগফিরুল্লাহ', Icons.label, Icons.check),
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
