import 'package:flutter/material.dart';
import 'package:news/consts/global_colors.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: lightScaffoldColor,
      primaryColor: lightCardColor,
      hintColor: Colors.grey.shade700,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionColor: Colors.blue,
      ),
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
          ),
      cardColor: lightCardColor,
    );
  }
}
