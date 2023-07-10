import 'package:flashcard_desktop_app/src/custom/style/minimal_theme.dart';
import 'package:flutter/material.dart';

class FlashcardAppThemes {

  static ThemeData defaultTheme = MinimalTheme.theme;

  static ThemeData flashcardBaseTheme = ThemeData(
    scaffoldBackgroundColor: Colors.red // Color.fromARGB(255, 0, 0, 0)
  );
}