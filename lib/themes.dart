import 'package:flutter/material.dart';

class Themes {
  final lightTheme = ThemeData(
    brightness: Brightness.light,
    canvasColor: Colors.white,
  );

  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    canvasColor: const Color.fromARGB(255, 17, 17, 17),
  );
}
