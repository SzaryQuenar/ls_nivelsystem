import 'package:flutter/material.dart';

final themeModeNotifier =
    ValueNotifier<ThemeMode>(
  ThemeMode.system,
);

class AppTheme {
  static final ThemeData light =
      ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.blue,
    brightness: Brightness.light,
  );

  static final ThemeData dark =
      ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.blue,
    brightness: Brightness.dark,

    scaffoldBackgroundColor:
        const Color(0xFF121212),

    cardTheme: const CardThemeData(
      color: Color(0xFF1E1E1E),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor:
          Color(0xFF1B1B1B),
    ),

    inputDecorationTheme:
        const InputDecorationTheme(
      border: UnderlineInputBorder(),
    ),
  );
}