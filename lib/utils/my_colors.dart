import 'package:flutter/material.dart';

Color primaryColor = const Color(0xFFF6F6F6);
Color accentColor = const Color(0xFF614d9e);
Color bgDarkWhite = const Color(0xFFFFFFFF);
Color borderColor = const Color(0xFFDFDFDF);
Color subTextColor = const Color(0xFFB3B3B3);
Color textColor = Colors.black;
Color descriptionColor = const Color(0xFF525252);
Color containerShadow = "#33ACB6B5".toColor();

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}