import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/router/route.gr.dart';
import 'package:momo/core/theme.dart';
import 'package:momo/core/user.session.dart';
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
    kUseDefaultOverlays(context,
        statusBarBrightness: context.invertedThemeBrightness);

    return Scaffold(
      body: AnimationLimiter(
        child: Stack(
          children: [
            /// top section
            Positioned(
              top: 16,
              right: 0,
              left: 0,
              child: SafeArea(
                bottom: false,
                child: Center(
                  child: AnimatedRow(
                    animateType: AnimateType.slideLeft,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LottieBuilder.asset(
                        kAppLoadingAnimation,
                        height: 56,
                        width: 56,
                      ),
                      const SizedBox(width: 8),
                      Text(kAppName, style: context.theme.textTheme.headline6),
                    ],
                  ),
                ),
              ),
            ),

            /// content on page
            Positioned.fill(
              top: 40,
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
                          left: -context.width * 0.4,
                          child: AnimatedOpacity(
                            duration: kContentAnimationDuration,
                            opacity: _showCards ? 1 : 0,
                            child: Center(
                              child: Transform.rotate(
                                angle: -pi / 35,
                                child: const WalletCard(
                                  accountNumber: '+233***951',
                                  accountHolder: 'Eva Jackson',
                                  accountProvider: 'Telco',
                                  balance: 4570.85,
                                  background: ThemeConfig.kRed,
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
                                child: WalletCard(
                                  accountNumber: '233***123',
                                  accountHolder: 'John Doe',
                                  accountProvider: 'Telco',
                                  balance: 19807.34,
                                  background: context.colorScheme.primary,
                                  foreground: context.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                      child: AnimatedColumn(
                        duration: kGridAnimationDuration.inMilliseconds,
                        animateType: AnimateType.slideRight,
                        children: [
                          Text(kAppDesc,
                              style: context.theme.textTheme.subtitle1),
                          const SizedBox(height: 24),
                          AppRoundedButton(
                            text: 'Get started',
                            onTap: () => context.router.pushAndPopUntil(
                                UserSessionHandler.kIsLoggedIn
                                    ? const DashboardRoute()
                                    : const UserSetupRoute(),
                                // const DashboardRoute(),
                                predicate: (_) => false),
                            buttonType: AppButtonType.swipeable,
                            backgroundColor: context.colorScheme.primary,
                            textColor: context.colorScheme.onPrimary,
                          ),
                        ],
                      ),
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
