
import 'package:flutter/material.dart';

class MinimalTheme {

  static Color offWhite = Color.fromARGB(255, 207, 207, 207);

  static ThemeData theme = ThemeData(
    colorScheme: ColorScheme.light(
      
      background: offWhite,
      primary: Color.fromARGB(255, 207, 207, 207)));


/*     static ColorScheme appColorScheme = ColorScheme(
      background: Color.fromARGB(255, 207, 207, 207), 
      brightness: null, 
      error: null, 
      onBackground: null, 
      onError: null, 
      onPrimary: null, 
      onSecondary: null, 
      onSurface: null,
       primary: null,
        secondary: null, 
        surface: null) */
}