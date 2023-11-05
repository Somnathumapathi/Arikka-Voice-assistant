import 'package:arikka/homescreen_body.dart';
import 'package:arikka/openai.dart';
import 'package:arikka/result_box.dart';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final OpenAi openai = OpenAi();
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = '';
  String? generatedContent;
  String? generatedImageUrl;
  bool isContentGenerated = false;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  Future<void> showDialoge(String result) async {
    return showDialog(
      context: context,
      builder: (context) {
        if (result.contains("https")) {
          return ResultImageBox(
            contentUrl: result,
          );
        } else {
          return ResultTextBox(contentText: result);
        }
      },
    );
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      // print(lastWords);
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    // final heretext = hereText;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arikka Voice Assistant AI'),
        leading: const Icon(Icons.mic),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 16, 1, 62),
                    image: DecorationImage(
                      image: AssetImage("assets/images/Logo-1.png"),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          const HomeScreenBody()
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (await speechToText.hasPermission &&
                speechToText.isNotListening) {
              await startListening();
              print('started listening');
            } else if (speechToText.isListening) {
              final result = await openai.isImagePrompt(lastWords);
              if (result.contains("https")) {
                generatedImageUrl = result;
                generatedContent = null;
                isContentGenerated = true;
              } else {
                generatedImageUrl = null;
                generatedContent = result;
                await systemSpeak(result);
                isContentGenerated = true;
              }

              if (isContentGenerated) {
                showDialoge(result);
              }

              print(result);
              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          child: const Icon(Icons.mic)),
    );
  }
}
