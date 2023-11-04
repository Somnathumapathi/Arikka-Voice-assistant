import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBox extends StatelessWidget {
  const TextBox({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 1.2),
            borderRadius: BorderRadius.circular(8)
                .copyWith(topLeft: const Radius.circular(0))),
        padding: const EdgeInsets.fromLTRB(20, 22, 27, 12),
        child: Text(
          text,
          style: GoogleFonts.roboto(
              fontSize: 17, color: color, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
