import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class AppTheme {
  static const _primary = Color(0xFF41669B);
  static const _primaryVariant = Color(0xFF41669B);
  static const _secondary = Color(0xFF5C8FC2);
  static const _background = Color(0xFF292731);
  static const _surface = Color(0xFF304973);
  static const _error = Color(0xFFCF6679);

  static const _onPrimary = Color(0xFFA5CCEC);
  static const _onSecondary = Color(0xFF000000);
  static const _onBackground = Color(0xFFFFFFFF);
  static const _onSurface = Color(0xFFFFFFFF);
  static const _onError = Color(0xFF000000);

  static get brightness => SchedulerBinding.instance!.window.platformBrightness;

  // default text theme
  static get _textTheme => const TextTheme(
    bodyText1: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      letterSpacing: 0,
    ),
    headline1: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 34,
      letterSpacing: 0.3,
    ),
    headline2: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 28,
      letterSpacing: 0,
    ),
    headline3: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 18,
      letterSpacing: 0,
    ),
    caption: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      letterSpacing: 0,
    ),
    button: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      letterSpacing: 1.25,
    ),
    subtitle1: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      letterSpacing: 1.25,
    ),
    subtitle2: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      letterSpacing: 1.25,
    ),
  );

  // default theme for the elevated button
  static get _elevatedButtonTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        fixedSize: const Size(190, 26)),
  );

  // default theme for Cards
  static get _cardTheme => const CardTheme(
    elevation: 5,
    color: _secondary,
    shadowColor: Colors.black,
    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );

  static get _colorScheme => ColorScheme(
      primary: _primary,
      primaryVariant: _primaryVariant,
      secondary: _secondary,
      secondaryVariant: _secondary,
      surface: _surface,
      background: _background,
      error: _error,
      onPrimary: _onPrimary,
      onSecondary: _onSecondary,
      onSurface: _onSurface,
      onBackground: _onBackground,
      onError: _onError,
      brightness: brightness,
  );

  // application's default theme
  static final defaultTheme = ThemeData(
    fontFamily: 'Quicksand',
    colorScheme: _colorScheme,
    scaffoldBackgroundColor: _background,
    textTheme: _textTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
    cardTheme: _cardTheme,
  );
}
