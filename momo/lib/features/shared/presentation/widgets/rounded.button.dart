import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';

enum AppButtonType { primary, secondary, swipeable }

enum LayoutSize { matchParent, wrapContent, standard }

class AppRoundedButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final AppButtonType buttonType;
  final Color? backgroundColor;
  final Color? textColor;
  final double elevation;
  final LayoutSize layoutSize;
  final bool enabled;
  final bool outlined;
  final IconData? icon;

  const AppRoundedButton({
    Key? key,
    this.elevation = 5,
    required this.text,
    required this.onTap,
    this.buttonType = AppButtonType.primary,
    this.backgroundColor,
    this.textColor,
    this.layoutSize = LayoutSize.standard,
    this.enabled = true,
    this.outlined = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double? buttonWidth;
    if (layoutSize == LayoutSize.wrapContent) {
      buttonWidth = null;
    } else if (layoutSize == LayoutSize.matchParent) {
      buttonWidth = double.infinity;
    } else if (layoutSize == LayoutSize.standard) {
      buttonWidth = size.width / 1.8;
    }

    return buttonType == AppButtonType.swipeable
        ? SwipeButton(
            trackPadding: const EdgeInsets.all(8),
            activeTrackColor:
                backgroundColor ?? context.colorScheme.onSecondary,
            activeThumbColor: textColor ?? context.colorScheme.secondary,
            height: kToolbarHeight * 1.2,
            onSwipe: onTap,
            thumb: Icon(icon ?? TablerIcons.arrow_move_right,
                color: backgroundColor ?? context.colorScheme.onSecondary),
            child: Text(
              text,
              style: context.theme.textTheme.button
                  ?.copyWith(color: textColor ?? context.colorScheme.secondary),
            ),
          )
        : SizedBox(
            width: buttonWidth,
            child: outlined
                ? GestureDetector(
                    onTap: enabled ? onTap : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: enabled
                              ? backgroundColor ??
                                  (buttonType == AppButtonType.primary
                                      ? context.colorScheme.primary
                                      : context.colorScheme.secondary)
                              : context.theme.disabledColor,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (icon != null) ...{
                            Icon(
                              icon,
                              color: enabled
                                  ? backgroundColor ??
                                      (buttonType == AppButtonType.primary
                                          ? context.colorScheme.primary
                                          : context.colorScheme.secondary)
                                  : context.theme.disabledColor,
                            ),
                          },
                          Expanded(
                            child: Text(
                              text,
                              style: context.theme.textTheme.button?.copyWith(
                                color: (enabled
                                        ? backgroundColor ??
                                            (buttonType == AppButtonType.primary
                                                ? context.colorScheme.primary
                                                : context.colorScheme.secondary)
                                        : context.theme.disabledColor)
                                    .withOpacity(
                                        enabled ? 1.0 : kEmphasisMedium),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: enabled ? onTap : null,
                    style: ButtonStyle(
                      padding:
                          MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                              (states) => const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      elevation: MaterialStateProperty.resolveWith<double>(
                          (states) => enabled ? elevation : 0),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (backgroundColor != null) {
                            return backgroundColor!;
                          }

                          if (states.contains(MaterialState.pressed)) {
                            return enabled
                                ? buttonType == AppButtonType.primary
                                    ? context.colorScheme.primaryContainer
                                    : context.colorScheme.secondaryContainer
                                : context.theme.disabledColor;
                          }

                          return enabled
                              ? buttonType == AppButtonType.primary
                                  ? context.colorScheme.primary
                                  : context.colorScheme.secondary
                              : context.theme.disabledColor;
                        },
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...{
                          Icon(
                            icon,
                            color: enabled
                                ? textColor ?? context.colorScheme.onPrimary
                                : context.colorScheme.background
                                    .withOpacity(kEmphasisMedium),
                          ),
                        },
                        Expanded(
                          child: Text(
                            text,
                            style: context.theme.textTheme.button?.copyWith(
                              color: (enabled
                                      ? textColor ??
                                          context.colorScheme.onPrimary
                                      : context.colorScheme.background)
                                  .withOpacity(enabled ? 1.0 : kEmphasisMedium),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
          );
  }
}
