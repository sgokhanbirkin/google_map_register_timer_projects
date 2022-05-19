import 'package:flutter/material.dart';

class CustomTheme {
  late ThemeData theme;
  final _colors = _Colors();

  CustomTheme() {
    theme = ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: _colors.blueMenia,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        centerTitle: true,
      ),
      scaffoldBackgroundColor: _colors.whiteSmoke,
      buttonTheme: ButtonThemeData(
        colorScheme: ColorScheme.light(
          onPrimary: _colors.pink,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: _colors.blueMenia,
          onPrimary: _colors.blackSmoke,
        ),
      ),
    );
  }
}

class _Colors {
  final Color blueMenia = const Color.fromARGB(166, 155, 164, 128);
  final Color pink = const Color.fromARGB(255, 244, 0, 216);
  final Color whiteSmoke = Colors.white54.withOpacity(0.8);
  final Color blackSmoke = const Color.fromARGB(135, 0, 0, 0).withOpacity(0.8);
}
