import 'package:e_shop_flutter/core/res/colors/primary.colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class PrimaryTheme {
  static ThemeData buildTheme({required Brightness brightness}) {
    final baseTheme = ThemeData(
      brightness: brightness,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: PrimaryColors.accentColor,
      ),
    );

    return baseTheme.copyWith(
      dividerTheme: DividerThemeData(
        color: brightness == Brightness.dark ? Colors.white60 : Colors.black26,
        space: 16,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: PrimaryColors.accentColor,
      ),
      dividerColor:
          brightness == Brightness.dark ? Colors.white60 : Colors.black26,
      scaffoldBackgroundColor:
          brightness == Brightness.dark ? Colors.black : Colors.white,
      textTheme: GoogleFonts.robotoTextTheme(
        baseTheme.textTheme.copyWith(),
      ),
    );
  }
}
