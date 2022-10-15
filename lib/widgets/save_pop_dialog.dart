import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void savePopDialog(BuildContext context, String text, bool remove) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: GoogleFonts.roboto(fontSize: 18),
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 1),
      backgroundColor: remove ? Colors.red : Colors.blueAccent,
    ),
  );
}
