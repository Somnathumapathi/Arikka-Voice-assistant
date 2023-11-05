import 'package:arikka/openai.dart';
import 'package:arikka/text_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import './const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final OpenAi openai = OpenAi();
  final speechToText = SpeechToText();
  String lastWords = '';
  @override
  void initState() {
    super.initState();
    initSpeechToText();
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

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      // print(lastWords);
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    final textBoxText = textbox;
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
                    color: Color.fromARGB(255, 22, 1, 26),
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
          TextBox(
            text: textBoxText[0],
            color: Colors.blue,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 15),
            child: Text(
              hereText,
              style: GoogleFonts.aBeeZee(
                  color: const Color.fromARGB(255, 227, 231, 244),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          TextBox(
            text: textBoxText[1],
            color: Colors.green,
          ),
          TextBox(
            text: textBoxText[2],
            color: Colors.yellow,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 15),
            child: Text(
              samPromptText,
              style: GoogleFonts.aBeeZee(
                  color: const Color.fromARGB(255, 227, 231, 244),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          TextBox(
            text: textBoxText[3],
            color: Colors.cyan,
          ),
          TextBox(
            text: textBoxText[4],
            color: Colors.cyan,
          ),
          const SizedBox(
            height: 30,
          )
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
