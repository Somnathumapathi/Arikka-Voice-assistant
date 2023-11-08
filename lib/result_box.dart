import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultImageBox extends StatelessWidget {
  const ResultImageBox({super.key, required this.contentUrl});
  final contentUrl;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 29, 1, 62),
      content: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(contentUrl),
            fit: BoxFit.cover,
          ),
        ),
        width: 400,
        height: 300,
      ),
    );
  }
}

class ResultTextBox extends StatelessWidget {
  const ResultTextBox({super.key, required this.contentText});
  final contentText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 38, 2, 79),
      content: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/Logo-1.png"),
            )),
            height: 70,
            width: 70,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8)
                  .copyWith(topLeft: const Radius.circular(0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                contentText,
                style: GoogleFonts.aBeeZee(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
