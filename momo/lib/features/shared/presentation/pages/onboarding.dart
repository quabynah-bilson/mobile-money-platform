import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/router/route.gr.dart';
import 'package:momo/features/shared/presentation/widgets/animated.column.dart';
import 'package:momo/features/shared/presentation/widgets/animated.row.dart';
import 'package:momo/features/shared/presentation/widgets/rounded.button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    kUseDefaultOverlays(context);

    return Scaffold(
      body: AnimationLimiter(
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: AnimatedColumn(
                  animateType: AnimateType.slideUp,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedRow(
                      animateType: AnimateType.slideBottom,
                      duration: 350,
                      children: [
                        Text(kAppName,
                            style: context.theme.textTheme.headline3),
                      ],
                    ),
                    LottieBuilder.asset(
                      kAppLoadingAnimation,
                      height: context.height * 0.35,
                      width: context.width,
                    ),
                    Text(
                      kAppDesc,
                      style: context.theme.textTheme.subtitle1?.copyWith(
                        color: context.colorScheme.onBackground
                            .withOpacity(kEmphasisMedium),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    AppRoundedButton(
                      text: 'Get started',
                      onTap: () =>
                          context.router.push(const UserSetupRoute()),
                    ),
                  ],
                ),
              ),
            ),

            // Positioned(child: )
          ],
        ),
      ),
    );
  }
}
