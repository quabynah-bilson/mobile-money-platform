import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  static const kOrange = Colors.orange,
      kWhite = Colors.white,
      kBlack = Colors.black,
      kAmber = Colors.amber,
      kGreen = Colors.green,
      kBlue = Color(0xff3883FB),
      kPurple = Color(0xff822FD3),
      kRed = Colors.red;

  static const _defaultFont = GoogleFonts.dmSans,
      _secondaryFont = GoogleFonts.dmSans,
      _tertiaryFont = GoogleFonts.dmMono;

  static TextTheme _kDefaultTextTheme(Color textColor) => TextTheme(
        headline1: _defaultFont(
            color: textColor, fontWeight: FontWeight.w300, letterSpacing: -1.5),
        headline2: _defaultFont(
            color: textColor, fontWeight: FontWeight.w400, letterSpacing: -0.5),
        headline3: _tertiaryFont(color: textColor, fontWeight: FontWeight.w600),
        headline4: _tertiaryFont(
            color: textColor, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        headline5: _tertiaryFont(color: textColor),
        headline6: _tertiaryFont(
            color: textColor, fontWeight: FontWeight.w500, letterSpacing: 0.15),
        subtitle1: _tertiaryFont(
            color: textColor, fontWeight: FontWeight.w700, letterSpacing: 0.15),
        subtitle2: _secondaryFont(
            color: textColor, fontWeight: FontWeight.w500, letterSpacing: 0.1),
        bodyText1: _secondaryFont(
            color: textColor, fontWeight: FontWeight.w500, letterSpacing: 0.5),
        bodyText2: _defaultFont(
            color: textColor, fontWeight: FontWeight.w500, letterSpacing: 0.25),
        button: _tertiaryFont(
            color: textColor, fontWeight: FontWeight.w700, letterSpacing: 1.25),
        caption: _tertiaryFont(
            color: textColor, fontWeight: FontWeight.w500, letterSpacing: 0.4),
        overline: _tertiaryFont(
            color: textColor, fontWeight: FontWeight.w500, letterSpacing: 1.5),
      );

  static ThemeData kLightThemeData(BuildContext context) =>
      ThemeData.light(useMaterial3: true).copyWith(
        textTheme: _kDefaultTextTheme(Colors.black),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xffF5CE5E),
          primaryContainer: Color(0xffF5CE5E),
          secondary: Color(0xff161616),
          secondaryContainer: Color(0xff161616),
          tertiary: Colors.white,
          tertiaryContainer: Color(0xffdddddd),
          error: Color(0xffFC4B19),
          background: Colors.white,
          surface: Color(0xffeeeeee),
          onBackground: Colors.black,
          onSurface: Colors.black,
          onPrimary: Colors.black,
          onPrimaryContainer: Colors.black,
          onSecondary: Colors.white,
          onSecondaryContainer: Colors.white,
          // onSecondary: Colors.white,
          onTertiary: Colors.black,
          onError: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xff4120E9),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 3,
          type: BottomNavigationBarType.fixed,
          enableFeedback: true,
          selectedIconTheme: const IconThemeData(color: Colors.black),
          unselectedIconTheme:
              IconThemeData(color: Colors.grey.withOpacity(0.65)),
          selectedLabelStyle: const TextStyle(color: Colors.black),
          unselectedLabelStyle: TextStyle(color: Colors.grey.withOpacity(0.65)),
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          actionsIconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        listTileTheme: const ListTileThemeData(textColor: Colors.black),
      );

  static ThemeData kDarkThemeData(BuildContext context) =>
      ThemeData.dark(useMaterial3: true).copyWith(
        textTheme: _kDefaultTextTheme(Colors.white),
        scaffoldBackgroundColor: const Color(0xff131313),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xffF5CE5E),
          primaryContainer: Color(0xffead196),
          secondary: Color(0xff161616),
          secondaryContainer: Color(0xff161616),
          tertiary: Color(0xff232323),
          tertiaryContainer: Color(0xff161616),
          background: Color(0xff131313),
          surface: Color(0xff232323),
          onPrimary: Colors.black,
          onPrimaryContainer: Colors.black,
          onSecondary: Colors.white,
          onSecondaryContainer: Colors.white,
          onTertiary: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xff232323),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xff161616),
          elevation: 3,
          type: BottomNavigationBarType.fixed,
          enableFeedback: true,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          unselectedIconTheme:
              IconThemeData(color: Colors.grey.withOpacity(0.65)),
          selectedLabelStyle: const TextStyle(color: Colors.white),
          unselectedLabelStyle: TextStyle(color: Colors.grey.withOpacity(0.65)),
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          actionsIconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        listTileTheme: const ListTileThemeData(textColor: Colors.white),
      );
}
