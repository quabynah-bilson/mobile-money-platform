import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'animated.column.dart';

class AnimatedRow extends StatelessWidget {
  final List<Widget> children;
  final AnimateType animateType;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final int duration;

  const AnimatedRow({
    Key? key,
    required this.children,
    this.animateType = AnimateType.slideLeft,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.duration = 500,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (animateType == AnimateType.slideUp) {
      return AnimationLimiter(
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          children: AnimationConfiguration.toStaggeredList(
            duration: Duration(milliseconds: duration),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 50.0,
              child: SlideAnimation(child: widget),
            ),
            children: children,
          ),
        ),
      );
    } else {
      return AnimationLimiter(
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          children: AnimationConfiguration.toStaggeredList(
            duration: Duration(milliseconds: duration),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: animateType == AnimateType.slideLeft ? 50.0 : -50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: children,
          ),
        ),
      );
    }
  }
}
