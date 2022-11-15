import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';

/// loading indicator with some sort of animation
class LoadingOverlay extends StatefulWidget {
  final Color? color;
  final Color? foregroundColor;
  final bool isLoading;
  final bool showBackgroundOverlay;
  final Widget child;
  final String message;
  final String lottieAnimResource;

  const LoadingOverlay({
    Key? key,
    required this.child,
    this.color,
    this.foregroundColor,
    this.isLoading = false,
    this.showBackgroundOverlay = true,
    this.message = 'Please wait',
    this.lottieAnimResource = kAppLoadingAnimation,
  }) : super(key: key);

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay>
    with TickerProviderStateMixin {
  late var _overlayVisible = widget.isLoading;
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));
  late final Animation<double> _animation =
      Tween(begin: 0.0, end: 1.0).animate(_controller);

  @override
  void initState() {
    super.initState();
    doAfterDelay(() {
      _animation.addStatusListener((status) {
        status == AnimationStatus.forward
            ? setState(() => _overlayVisible = true)
            : null;
        status == AnimationStatus.dismissed
            ? setState(() => _overlayVisible = false)
            : null;
      });
      if (widget.isLoading) _controller.forward();
    });
  }

  @override
  void didUpdateWidget(LoadingOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isLoading && widget.isLoading) {
      _controller.forward();
    }

    if (oldWidget.isLoading && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    kUseDefaultOverlays(context,
        statusBarBrightness: widget.showBackgroundOverlay
            ? Brightness.light
            : context.theme.brightness);

    return Stack(
      children: [
        if (widget.showBackgroundOverlay) ...{
          /// top-right background design
          Positioned(
            top: -(context.height * 0.1),
            right: -context.width * 0.12,
            child: Transform.rotate(
              angle: -math.pi / -8.0,
              child: AnimatedContainer(
                duration: kListAnimationDuration,
                height: context.height * 0.35,
                width: context.height * 0.35,
                decoration: BoxDecoration(
                  color: widget.color ?? context.colorScheme.background
                      .withOpacity(kEmphasisLow),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(kRadiusLargest),
                    bottomRight: Radius.circular(kRadiusMedium),
                  ),
                ),
              ),
            ),
          ),

          /// bottom-left background design
          Positioned(
            bottom: -(context.height * 0.1),
            left: -context.width * 0.12,
            child: Transform.rotate(
              angle: -math.pi / -8.0,
              child: AnimatedContainer(
                duration: kListAnimationDuration,
                height: context.height * 0.4,
                width: context.height * 0.6,
                decoration: BoxDecoration(
                  color: widget.color ?? context.colorScheme.background.withOpacity(kEmphasisLow),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(kRadiusLargest),
                  ),
                ),
              ),
            ),
          ),
        },

        /// underlying UI
        Positioned.fill(child: widget.child),

        /// loading indicator semi-opaque background
        if (_overlayVisible) ...{
          FadeTransition(
            opacity: _animation,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Opacity(
                    opacity: kEmphasisHigh,
                    child: ModalBarrier(
                      dismissible: false,
                      color: context.colorScheme.surface
                          .withOpacity(kEmphasisMedium),
                    ),
                  ),
                ),

                /// loading indicator
                Positioned.fill(
                  child: Center(
                    child: LoadingIndicatorItem(
                      message: widget.message,
                      foregroundColor: widget.foregroundColor,
                      loadingAnimationUrl: widget.lottieAnimResource,
                    ),
                  ),
                ),
              ],
            ),
          ),
        },
      ],
    );
  }
}

class LoadingIndicatorItem extends StatelessWidget {
  final Color? foregroundColor;
  final String message;
  final String loadingAnimationUrl;

  const LoadingIndicatorItem({
    Key? key,
    required this.message,
    this.foregroundColor,
    this.loadingAnimationUrl = kAppLoadingAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: LottieBuilder.asset(
              loadingAnimationUrl,
              width: context.width,
              height: context.height * 0.25,
              animate: true,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            message,
            style: context.theme.textTheme.subtitle1?.copyWith(
              color: foregroundColor ?? context.colorScheme.onBackground,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
}
