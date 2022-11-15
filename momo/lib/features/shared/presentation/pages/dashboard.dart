// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/injector.dart';
import 'package:momo/core/modals.dart';
import 'package:momo/core/router/route.gr.dart';
import 'package:momo/features/shared/domain/entities/wallet/wallet.dart';
import 'package:momo/features/shared/presentation/widgets/animated.column.dart';
import 'package:momo/features/shared/presentation/widgets/animated.row.dart';
import 'package:momo/features/shared/presentation/widgets/loading.overlay.dart';
import 'package:momo/features/shared/presentation/widgets/wallet.card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var _loading = false, _showBalances = false;

  @override
  void initState() {
    super.initState();
    doAfterDelay(() async {
      try {
        var response = await getIt.get<Dio>().post('/auth/login',
            data: {'username': 'dennis', 'password': 'strong_password'});
        logger.i('returned => ${response.data}');
      } on DioError catch (e) {
        logger.e(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.colorScheme.primary,
        body: LoadingOverlay(
          isLoading: _loading,
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                /// background content
                /// shows actions & app details
                Positioned.fill(
                  child: Column(
                    children: [
                      /// logo & actions
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// left side
                            GestureDetector(
                              onTap: () => showAppDetailsSheet(context),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(kRadiusLarge),
                                  color: context.colorScheme.onPrimary,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: AnimatedRow(
                                  animateType: AnimateType.slideRight,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    LottieBuilder.asset(
                                      kAppLoadingAnimation,
                                      height: 40,
                                      width: 40,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(kAppName,
                                        style: context.theme.textTheme.subtitle1
                                            ?.copyWith(
                                                color: context
                                                    .colorScheme.primary)),
                                  ],
                                ),
                              ),
                            ),

                            /// right side
                            AnimatedRow(
                              animateType: AnimateType.slideLeft,
                              duration: kGridAnimationDuration.inMilliseconds,
                              children: [
                                IconButton(
                                  color: context.colorScheme.onPrimary,
                                  onPressed: () => setState(
                                      () => _showBalances = !_showBalances),
                                  icon: Icon(_showBalances
                                      ? TablerIcons.eye_off
                                      : TablerIcons.eye),
                                  tooltip: 'Show balances',
                                ),
                                IconButton(
                                  color: context.colorScheme.onPrimary,
                                  // todo => show notifications
                                  onPressed: () =>
                                      context.showSnackBar(kFeatureUnderDev),
                                  icon: const Icon(TablerIcons.bell),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      /// wallets
                      SizedBox(
                        width: context.width,
                        height: context.height * 0.3,
                        child: ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 24),
                          scrollDirection: Axis.horizontal,
                          children: AnimationConfiguration.toStaggeredList(
                            duration: kListAnimationDuration,
                            childAnimationBuilder: (child) => SlideAnimation(
                              horizontalOffset: kListSlideOffset,
                              child: FadeInAnimation(child: child),
                            ),
                            children: [
                              Center(
                                child: FloatingActionButton(
                                  onPressed: _addNewWallet,
                                  backgroundColor:
                                      context.colorScheme.onPrimary,
                                  foregroundColor: context.colorScheme.primary,
                                  child: const Icon(TablerIcons.plus),
                                ),
                              ),
                              const SizedBox(width: 24),
                              ...kSampleWallets.map(
                                (wallet) => WalletCard(
                                  key: ValueKey(wallet.id),
                                  accountNumber: _showBalances ? wallet.phone : wallet.hashedPhone,
                                  accountHolder: wallet.holder,
                                  accountProvider: wallet.provider,
                                  balance: _showBalances ? wallet.balance : null,
                                  background: context.colorScheme.surface,
                                  foreground: context.colorScheme.onSurface,
                                  marginEnd: 24,
                                  type: WalletType.compact,
                                  // todo => view wallet details
                                  onTap: () => context.router
                                      .push(WalletDetailsRoute(wallet: wallet)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// bottom section
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: AnimatedContainer(
                    duration: kListAnimationDuration,
                    height: context.height * 0.35,
                    width: context.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(kRadiusLarge),
                        topRight: Radius.circular(kRadiusLarge),
                      ),
                      color: context.colorScheme.surface,
                    ),
                    // todo => build child
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  /// add a new wallet
  void _addNewWallet() async {
    var successful = await context.router.push(const AddWalletRoute());
    if (successful is bool && successful) {
      // todo => reload wallets
      context.showSnackBar(kFeatureUnderDev);
    }
  }
}

/*
 SliverSafeArea(
              bottom: false,
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  width: context.width,
                  // height: context.height * 0.35,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                    child: WalletCard(
                      accountNumber: '+233554635701',
                      accountHolder: 'Dennis Q. Bilson',
                      accountProvider: 'MTN',
                      balance: 348.28,
                      background: context.colorScheme.primary,
                      foreground: context.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
* */
