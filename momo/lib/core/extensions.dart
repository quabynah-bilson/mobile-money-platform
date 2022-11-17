import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// extensions on [BuildContext]
extension ContextX on BuildContext {
  double get height => mediaQuery.size.height;

  double get width => mediaQuery.size.width;

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  bool get isMobile => width < 650;

  bool get isTablet => width >= 650 && width < 1080;

  bool get isDesktop => width >= 1080;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  bool get isDarkMode => theme.brightness == Brightness.dark;

  Brightness get invertedThemeBrightness =>
      theme.brightness == Brightness.light ? Brightness.dark : Brightness.light;

  /// shows a [SnackBar]
  void showSnackBar(String message, [Color? background, Color? foreground]) {
    var messenger = ScaffoldMessenger.of(this);
    messenger
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: Theme.of(this).textTheme.bodyText2?.copyWith(
                  color: foreground ?? Theme.of(this).colorScheme.onSecondary,
                ),
          ),
          backgroundColor: background ?? Theme.of(this).colorScheme.secondary,
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Okay',
            textColor: foreground ?? Theme.of(this).colorScheme.onSecondary,
            onPressed: () => messenger.hideCurrentSnackBar(),
          ),
        ),
      );
  }
}

/// extensions on [String]
extension StringX on String? {
  String capitalize() {
    return isNullOrEmpty()
        ? ''
        : this!
            .split(' ')
            .map((str) =>
                '${str[0].toUpperCase()}${str.substring(1).toLowerCase()}')
            .join(' ');
  }

  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

/// called in initState
void doAfterDelay(Function() block, [int delayInMillis = 0]) =>
    Future.delayed(Duration(milliseconds: delayInMillis))
        .then((value) => block());

/// UI overlay
void kUseDefaultOverlays(
  BuildContext context, {
  Color? statusBarColor,
  Color? navigationBarColor,
  Brightness statusBarIconBrightness = Brightness.dark,
  Brightness statusBarBrightness = Brightness.dark,
  Brightness navigationBarIconBrightness = Brightness.dark,
}) =>
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? context.colorScheme.background,
        systemNavigationBarColor:
            navigationBarColor ?? context.colorScheme.background,
        statusBarIconBrightness: statusBarIconBrightness,
        systemNavigationBarDividerColor:
            navigationBarColor ?? context.colorScheme.background,
        systemNavigationBarIconBrightness: navigationBarIconBrightness,
        statusBarBrightness: statusBarBrightness,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarContrastEnforced: false,
      ),
    );
