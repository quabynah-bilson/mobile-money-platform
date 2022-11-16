import 'package:flutter/material.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';

import 'animated.column.dart';

class EmptyContentPlaceholder extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;

  const EmptyContentPlaceholder(
      {Key? key, required this.title, required this.subtitle, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: AnimatedColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...{
                Icon(icon, size: 48, color: context.colorScheme.secondary),
                const SizedBox(height: 16),
              },
              Text(
                title,
                style: context.theme.textTheme.headline6?.copyWith(
                  color: context.colorScheme.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: context.theme.textTheme.subtitle1?.copyWith(
                  color: context.colorScheme.onBackground
                      .withOpacity(kEmphasisMedium),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
}
