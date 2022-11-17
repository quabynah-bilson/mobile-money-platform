// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/modals.dart';
import 'package:momo/core/router/route.gr.dart';
import 'package:momo/features/shared/domain/entities/wallet/wallet.dart';
import 'package:momo/features/shared/presentation/manager/bloc.state.dart';
import 'package:momo/features/shared/presentation/manager/wallet_cubit.dart';
import 'package:momo/features/shared/presentation/widgets/animated.column.dart';
import 'package:momo/features/shared/presentation/widgets/animated.row.dart';
import 'package:momo/features/shared/presentation/widgets/dashboard.tile.dart';
import 'package:momo/features/shared/presentation/widgets/empty.content.placeholder.dart';
import 'package:momo/features/shared/presentation/widgets/loading.overlay.dart';
import 'package:momo/features/shared/presentation/widgets/page.indicator.dart';
import 'package:momo/features/shared/presentation/widgets/wallet.card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var _loading = false,
      _showBalances = false,
      _wallets = List<Wallet>.empty(growable: true);
  Wallet? _currentWallet;
  final _walletCubit = WalletCubit();

  @override
  void initState() {
    super.initState();
    doAfterDelay(() async {
      _walletCubit.wallets();
      if (_wallets.isNotEmpty) setState(() => _currentWallet = _wallets.first);
    });
  }

  @override
  Widget build(BuildContext context) => MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: _walletCubit,
            listener: (context, state) {
              if (!mounted) return;

              setState(() => _loading = state is LoadingState);

              if (state is ErrorState<String>) {
                context.showSnackBar(
                    state.failure,
                    context.colorScheme.errorContainer,
                    context.colorScheme.onErrorContainer);
              }

              if (state is SuccessState<List<Wallet>>) {
                setState(() => _wallets = state.data.reversed.toList());
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: context.colorScheme.primary,
          extendBody: true,
          extendBodyBehindAppBar: true,

          /// logo & actions
          appBar: AppBar(
            centerTitle: false,
            backgroundColor:
                context.colorScheme.primary.withOpacity(kEmphasisNone),
            title: GestureDetector(
              onTap: () async {
                var signedOut = await showProfileSheetWithOptions(context);
                if (signedOut is bool && signedOut) {
                  context.router.pushAndPopUntil(const OnboardingRoute(),
                      predicate: (_) => false);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRadiusLarge),
                  color: context.colorScheme.onPrimary,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: AnimatedRow(
                  animateType: AnimateType.slideRight,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(TablerIcons.user_circle,
                        color: context.colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(kAppName,
                        style: context.theme.textTheme.subtitle1
                            ?.copyWith(color: context.colorScheme.primary)),
                  ],
                ),
              ),
            ),
            actions: [
              if (_wallets.isNotEmpty) ...{
                IconButton(
                  color: context.colorScheme.onPrimary,
                  onPressed: () =>
                      setState(() => _showBalances = !_showBalances),
                  icon: Icon(
                      _showBalances ? TablerIcons.eye_off : TablerIcons.eye),
                  tooltip: 'Toggle balances',
                  enableFeedback: true,
                ),
                IconButton(
                  color: context.colorScheme.onPrimary,
                  // todo => show approvals
                  onPressed: () => context.showSnackBar(kFeatureUnderDev),
                  icon: const Icon(TablerIcons.checklist),
                  tooltip: 'Approvals',
                  enableFeedback: true,
                ),
              },
            ],
          ),
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
                      mainAxisAlignment: _wallets.isEmpty
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      children: [
                        /// wallets
                        if (_wallets.isNotEmpty) ...{
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: CarouselSlider.builder(
                              itemCount: _wallets.length,
                              itemBuilder: (context, index, _) {
                                var wallet = _wallets[index];
                                return WalletCard(
                                  key: ValueKey(wallet.id),
                                  accountNumber: _showBalances
                                      ? wallet.phone
                                      : wallet.hashedPhone,
                                  accountHolder: wallet.holder,
                                  accountProvider: wallet.provider,
                                  balance:
                                      _showBalances ? wallet.balance : null,
                                  background: context.colorScheme.surface,
                                  foreground: context.colorScheme.onSurface,
                                  onTap: () => context.router
                                      .push(WalletDetailsRoute(wallet: wallet)),
                                );
                              },
                              options: CarouselOptions(
                                aspectRatio: 2,
                                viewportFraction: 0.8,
                                initialPage: _currentWallet == null
                                    ? 0
                                    : _wallets.indexOf(_currentWallet!),
                                enableInfiniteScroll: false,
                                reverse: false,
                                autoPlay: false,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                onPageChanged: (page, _) => setState(
                                    () => _currentWallet = _wallets[page]),
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ),

                          /// indicator
                          if (_currentWallet != null) ...{
                            PageIndicator(
                              current: _wallets.indexOf(_currentWallet!),
                              count: _wallets.length,
                              indicatorColor: context.colorScheme.onPrimary,
                            ),
                          },

                          /// add new wallet
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: FloatingActionButton.extended(
                              onPressed: _addNewWallet,
                              backgroundColor: context.colorScheme.onPrimary,
                              foregroundColor: context.colorScheme.primary,
                              icon: const Icon(TablerIcons.wallet),
                              label: const Text('Add wallet'),
                            ),
                          ),

                          /// actions
                          /// todo => add actions for transactions
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildActionButton(
                                  label: 'Top up',
                                  icon: TablerIcons.phone_call,
                                  onTap: () => context.router
                                      .push(const BundlePurchaseRoute()),
                                ),
                                _buildActionButton(
                                  label: 'Send',
                                  icon: TablerIcons.send,
                                ),
                                _buildActionButton(
                                  label: 'Withdraw',
                                  icon: TablerIcons.arrow_down,
                                ),
                                _buildActionButton(
                                  label: 'MomoPay',
                                  icon: TablerIcons.qrcode,
                                ),
                              ],
                            ),
                          ),
                        } else ...{
                          const EmptyContentPlaceholder(
                            icon: TablerIcons.wallet_off,
                            title: 'No wallets',
                            subtitle:
                                'Add a wallet to get started with your mobile money transactions',
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: FloatingActionButton.extended(
                              onPressed: _addNewWallet,
                              backgroundColor: context.colorScheme.onPrimary,
                              foregroundColor: context.colorScheme.primary,
                              icon: const Icon(TablerIcons.wallet),
                              label: const Text('Add wallet'),
                            ),
                          ),
                        }
                      ],
                    ),
                  ),

                  /// bottom section
                  AnimatedPositioned(
                    duration: kScrollAnimationDuration,
                    bottom: _wallets.isNotEmpty ? 0 : -context.height * 0.5,
                    right: 0,
                    left: 0,
                    child: AnimatedContainer(
                      duration: kListAnimationDuration,
                      height: context.height * 0.38,
                      width: context.width,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(kRadiusLarge),
                          topRight: Radius.circular(kRadiusLarge),
                        ),
                        color: context.colorScheme.background,
                      ),
                      padding: const EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('More from $kAppName',
                              style: context.theme.textTheme.subtitle1),
                          const SizedBox(height: 12),
                          Expanded(
                            child: SafeArea(
                              top: false,
                              child: GridView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 16,
                                ),
                                children:
                                    AnimationConfiguration.toStaggeredList(
                                  duration: kGridAnimationDuration,
                                  childAnimationBuilder: (child) =>
                                      SlideAnimation(
                                    verticalOffset: kListSlideOffset,
                                    child: FadeInAnimation(child: child),
                                  ),
                                  // todo => add tap actions
                                  children: [
                                    const DashboardActionTile(
                                      label: 'Bills',
                                      icon: TablerIcons.receipt,
                                    ),
                                    DashboardActionTile(
                                      label: 'Bundles',
                                      icon: TablerIcons.wifi,
                                      onTap: () => context.router
                                          .push(const BundlePurchaseRoute()),
                                    ),
                                    const DashboardActionTile(
                                      label: 'Bank Services',
                                      icon: TablerIcons.building_bank,
                                    ),
                                    const DashboardActionTile(
                                      label: 'Schedule',
                                      icon: TablerIcons.calendar_event,
                                    ),
                                    const DashboardActionTile(
                                      label: 'Offers',
                                      icon: TablerIcons.discount_2,
                                    ),
                                    DashboardActionTile(
                                      label: 'More',
                                      icon: TablerIcons.dots_circle_horizontal,
                                      onTap: () => context.router
                                          .push(const DashboardOptionsRoute()),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  /// action tile below wallets
  Widget _buildActionButton({
    required String label,
    required IconData icon,
    void Function()? onTap,
  }) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton(
            elevation: 0,
            heroTag: label.toLowerCase().replaceAll(' ', '-'),
            backgroundColor: context.colorScheme.surface,
            foregroundColor: context.colorScheme.onSurface,
            onPressed: onTap ?? () => context.showSnackBar(kFeatureUnderDev),
            child: Icon(icon),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: context.theme.textTheme.button
                ?.copyWith(color: context.colorScheme.onPrimary),
          ),
        ],
      );

  /// add a new wallet
  void _addNewWallet() async {
    var successful = await context.router.push(const AddWalletRoute());
    if (successful is bool && successful) {
      _walletCubit.wallets();
    }
  }
}
