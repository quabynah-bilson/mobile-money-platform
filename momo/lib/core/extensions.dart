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

  /*Future<void> showCustomDialog({
    required String headerIconAsset,
    required String message,
    List<DialogAction> actions = const <DialogAction>[],
    bool showDismissButton = true,
    String negativeButtonText = 'Okay',
    double iconSize = 56,
  }) async =>
      await showSlidingBottomSheet(this, builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 16,
          color: colorScheme.surface,
          duration: kSidebarFooterDuration,
          dismissOnBackdropTap: false,
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.4, 0.7, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          headerBuilder: (context, _) => Material(
            color: colorScheme.surface,
            child: headerIconAsset
                .asAssetImage(size: iconSize, fit: BoxFit.fitHeight)
                .vertical(8),
          ).fillMaxWidth(context),
          builder: (context, state) {
            return Material(
              color: colorScheme.surface,
              child: SafeArea(
                top: false,
                child: AnimatedColumn(
                  animateType: AnimateType.slideUp,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    message
                        .subtitle1(
                      context,
                      alignment: TextAlign.center,
                      color: colorScheme.onSurface,
                    )
                        .centered(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize:
                      actions.isEmpty ? MainAxisSize.min : MainAxisSize.max,
                      children: [
                        if (showDismissButton) ...{
                          Expanded(
                            child: AppRoundedButton(
                              text: negativeButtonText,
                              onTap: () => Navigator.pop(this),
                              outlined: true,
                            ).right(actions.isEmpty ? 0 : 12),
                          ),
                        },
                        ...actions
                            .map(
                              (e) => AppRoundedButton(
                              onTap: () {
                                Navigator.pop(this);
                                if (e.onTap != null) e.onTap!();
                              },
                              text: e.label).horizontal(8)
                              .centered(),
                        )
                            .toList(),
                      ],
                    ).centered().top(16),
                  ],
                ).horizontal(24).vertical(12),
              ),
            );
          },
        );
      });*/

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
