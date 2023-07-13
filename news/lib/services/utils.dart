import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class Utils {
  BuildContext context;

  Utils(this.context);

  bool get getCurrentTheme =>
      Provider.of<ThemeProvider>(context).getIsDarkTheme;

  Color get getColorForCurrentTheme => Colors.black;

  static TextStyle get getMainTextStyle => GoogleFonts.lato(
        fontSize: 17.0,
        fontWeight: FontWeight.w600,
      );

  Color get baseShimmerColor => Colors.grey.shade200;

  Color get highlightShimmerColor => Colors.grey.shade400;

  Color get widgetShimmerColor =>
      getCurrentTheme ? Colors.grey.shade600 : Colors.grey.shade100;
}

extension StringExtension on String {
  String capitalizeFirst() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
