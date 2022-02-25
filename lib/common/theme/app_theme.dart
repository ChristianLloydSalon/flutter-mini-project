import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppTheme {
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
    shadowColor: Colors.grey,
    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );

  // application's default theme
  static final defaultTheme = ThemeData(
    fontFamily: 'Quicksand',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    textTheme: _textTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
    cardTheme: _cardTheme,
  );
}
