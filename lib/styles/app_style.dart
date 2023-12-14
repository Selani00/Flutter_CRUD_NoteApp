import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyColors {
  static Color bgColor = Colors.grey;
  static Color mainColor = Color.fromARGB(255, 1, 11, 64);
  static Color accentColor = Color.fromARGB(255, 75, 82, 216);

  static List<Color> cardsColors = [
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.cyan,
    Colors.amber,
    Colors.lime,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.indigo,
    Colors.brown,
    Colors.grey,
    Colors.white,
  ];

  static TextStyle mainTitle =
      GoogleFonts.roboto(fontSize: 18.0, fontWeight: FontWeight.bold);

    static TextStyle mainContent =
      GoogleFonts.nunito(fontSize: 16.0, fontWeight: FontWeight.normal);

      static TextStyle dateTitle =
      GoogleFonts.roboto(fontSize: 13.0, fontWeight: FontWeight.w500);

}
