import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TTSPage(),
    );
  }
}

class TTSPage extends StatefulWidget {
  @override
  _TTSPageState createState() => _TTSPageState();
}

class _TTSPageState extends State<TTSPage> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textController = TextEditingController();

  double volume = 1.0;
  double pitch = 1.0;
  double rate = 0.5;

  @override
  void initState() {
    super.initState();
    initTts();
  }

  /// INITIALIZE TTS WITH ONLY ONE VOICE
  void initTts() async {
    await flutterTts.setLanguage("en-IN");

    await flutterTts.setVoice({
      "name": "Rishi",
      "locale": "en-IN",
    });

    await flutterTts.setPitch(pitch);
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
  }

  Future<void> speak() async {
    if (textController.text.trim().isEmpty) return;

    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(rate);

    await flutterTts.speak(textController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101820),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1F26),
        title: const Text("Text to Speech", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1F26),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: textController,
                  maxLines: 5,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type something...",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),

              const SizedBox(height: 25),
              const Text("Volume", style: TextStyle(color: Colors.white, fontSize: 16)),
              Slider(
                value: volume,
                min: 0,
                max: 1,
                divisions: 10,
                activeColor: Colors.blueAccent,
                onChanged: (value) {
                  setState(() => volume = value);
                },
              ),

              const Text("Pitch", style: TextStyle(color: Colors.white, fontSize: 16)),
              Slider(
                value: pitch,
                min: 0.5,
                max: 2.0,
                divisions: 15,
                activeColor: Colors.pinkAccent,
                onChanged: (value) {
                  setState(() => pitch = value);
                },
              ),

              const Text("Speed", style: TextStyle(color: Colors.white, fontSize: 16)),
              Slider(
                value: rate,
                min: 0.3,
                max: 1.0,
                activeColor: Colors.greenAccent,
                divisions: 10,
                onChanged: (value) {
                  setState(() => rate = value);
                },
              ),

              const SizedBox(height: 25),

              Center(
                child: GestureDetector(
                  onTap: speak,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlue],
                      ),
                    ),
                    child: const Text(
                      "Speak",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}