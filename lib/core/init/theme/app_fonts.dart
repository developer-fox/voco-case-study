
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "../../extension/themedata_extension.dart";

/// Fonts specially produced by the developer are defined in this class. 
/// Thanks to [AppFontsExtension] extension overwritten [ThemeData], it can be accessed by this class and its contents.
class AppFonts{
  static Color get textStyleBlackColor => const Color.fromRGBO(58, 58, 65, 1);
  static Color get textStyleGreyColor2 => const Color.fromRGBO(97, 98, 113, 1);
  static Color get textStyleGreyColor3 => const Color.fromRGBO(179, 179, 188, 1);
  static Color get textStyleRedColor => const Color.fromRGBO(235, 86, 89, 1);

  static TextStyle font = GoogleFonts.poppins();

  static TextStyle appbarTitleStyle = AppFonts.font.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 1,
    color: Colors.white,
  );



}