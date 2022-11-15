import 'package:flutter/material.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';

/// page indicator
class PageIndicator extends StatelessWidget {
  final int count;
  final int current;
  final Color? indicatorColor;

  const PageIndicator({
    Key? key,
    required this.count,
    required this.current,
    this.indicatorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: context.width,
        height: 8,
        child: Center(
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>
                _buildIndicator(context, index == current),
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemCount: count,
          ),
        ),
      );

  Widget _buildIndicator(BuildContext context, bool active) =>
      AnimatedContainer(
        duration: kScrollAnimationDuration,
        width: active ? 48 : 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadiusLarge),
          color: active
              ? (indicatorColor ?? context.colorScheme.onBackground)
              : (indicatorColor ?? context.colorScheme.onBackground)
                  .withOpacity(kEmphasisLow),
        ),
      );
}
