import 'package:arikka/const.dart';
import 'package:flutter/material.dart';
import 'package:arikka/text_box.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final textBoxText = textbox;
    return Column(
      children: [
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
        ),
      ],
    );
  }
}
