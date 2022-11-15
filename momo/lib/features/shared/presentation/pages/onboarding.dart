import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/router/route.gr.dart';
import 'package:momo/core/theme.dart';
import 'package:momo/features/shared/presentation/widgets/animated.column.dart';
import 'package:momo/features/shared/presentation/widgets/animated.row.dart';
import 'package:momo/features/shared/presentation/widgets/rounded.button.dart';
import 'package:momo/features/shared/presentation/widgets/wallet.card.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  var _showCards = false;

  @override
  void initState() {
    super.initState();
    doAfterDelay(
      () async {
        await Future.delayed(kListAnimationDuration);
        setState(() => _showCards = true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    kUseDefaultOverlays(context);

    return Scaffold(
      body: AnimationLimiter(
        child: Stack(
          children: [
            /// top section
            Positioned(
              top: 16,
              left: 24,
              child: SafeArea(
                bottom: false,
                child: AnimatedRow(
                  animateType: AnimateType.slideRight,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                      kAppLoadingAnimation,
                      height: 56,
                      width: 56,
                    ),
                    const SizedBox(width: 8),
                    Text(kAppName, style: context.theme.textTheme.headline4),
                  ],
                ),
              ),
            ),

            /// content on page
            Positioned.fill(
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  Expanded(
                    flex: 3,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        /// first card
                        Positioned.fill(
                          left: -context.width * 0.5,
                          child: AnimatedOpacity(
                            duration: kContentAnimationDuration,
                            opacity: _showCards ? 1 : 0,
                            child: Center(
                              child: Transform.rotate(
                                angle: -pi / 35,
                                child: const WalletCard(
                                  accountNumber: '5294-2436-4780-2468',
                                  accountHolder: 'Quabynah Bilson Jr.',
                                  accountProvider: 'Calbank',
                                  balance: 4570.85,
                                  background: ThemeConfig.kPurple,
                                ),
                              ),
                            ),
                          ),
                        ),

                        /// second card
                        Positioned.fill(
                          right: -context.width * 0.5,
                          bottom: context.height * 0.1,
                          child: AnimatedOpacity(
                            duration: kGridAnimationDuration,
                            opacity: _showCards ? 1 : 0,
                            child: Center(
                              child: Transform.rotate(
                                angle: pi / 10,
                                child: const WalletCard(
                                  accountNumber: '233554635701',
                                  accountHolder: 'Dennis Bilson',
                                  accountProvider: 'MTN',
                                  balance: 12837.34,
                                  background: ThemeConfig.kBlue,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    flex: 3,
                    child: AnimatedColumn(
                      duration: kGridAnimationDuration.inMilliseconds,
                      animateType: AnimateType.slideLeft,
                      children: [
                        Text(kAppDesc,
                            style: context.theme.textTheme.subtitle1),
                        const SizedBox(height: 24),
                        AppRoundedButton(
                            text: 'Get started',
                            onTap: () => context.router.pushAndPopUntil(
                                const UserSetupRoute(),
                                predicate: (_) => false)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// dev team
            Positioned(
              bottom: 16,
              left: 24,
              right: 24,
              child: SafeArea(
                top: false,
                child: Text(
                  kAppDevTeam,
                  textAlign: TextAlign.center,
                  style: context.theme.textTheme.caption?.copyWith(
                    color: context.colorScheme.onBackground
                        .withOpacity(kEmphasisLow),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
Center(
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
                      onTap: () => context.router.push(const UserSetupRoute()),
                    ),
                  ],
                ),
              ),
* */
