
import 'package:flutter/material.dart';

import 'app_fonts.dart';

//? AppThemeLight.instance.<method_name> 
class AppThemeLight{

  static AppThemeLight? _instance =  AppThemeLight._init();
  static AppThemeLight get instance {
    _instance ??= AppThemeLight._init();
    return _instance!;
  }

  AppThemeLight._init();

  // uygulamada kullanilacak renkler bu sekilde belirtilmistirç
  //? AppThemeLight.instance.theme.ColorScheme.<attribute_name>
  ThemeData get theme => ThemeData(
    canvasColor: Colors.white,
    primaryColorLight: const Color.fromARGB(255, 230, 230, 230),
    dividerColor: const Color.fromRGBO(236, 236, 236, 1),
    colorScheme:  ColorScheme(
      brightness: Brightness.light,
      primary:  Color.fromARGB(255, 9, 55, 220),
      onPrimary: Colors.white, 
      secondary: const Color.fromRGBO(218, 218, 218, 1), 
      onSecondary: Colors.white,
      tertiary: const Color.fromRGBO(250, 152, 24, 1),
      error: const Color.fromRGBO(235, 86, 89, 1), 
      onError: Colors.black, 
      scrim: const Color.fromRGBO(248, 248, 248, 1),
      background: const Color.fromRGBO(234, 236, 235, 1),
      onBackground: Colors.black, 
      surface: Colors.lightGreen,
      onSurface: Colors.grey.shade900,
    ),
    scrollbarTheme: ScrollbarThemeData(
      interactive: true,
      thickness: MaterialStateProperty.all(4),
      thumbVisibility: MaterialStateProperty.all(true),
      thumbColor: MaterialStateProperty.all(const Color.fromRGBO(217, 217, 217, 1)),
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: AppFonts.appbarTitleStyle,
      elevation: .1,
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: Colors.white
      ),
      color:   Color.fromARGB(255, 9, 55, 220),
      shadowColor: const Color.fromRGBO(236, 236, 236, 1),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      )
    ),
  );
}

