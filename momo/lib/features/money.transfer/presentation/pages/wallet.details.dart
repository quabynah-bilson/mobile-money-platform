import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/modals.dart';
import 'package:momo/features/money.transfer/domain/entities/transaction/transaction.dart';
import 'package:momo/features/money.transfer/presentation/widgets/transaction.tile.dart';
import 'package:momo/features/shared/domain/entities/wallet/wallet.dart';
import 'package:momo/features/shared/presentation/widgets/empty.content.placeholder.dart';
import 'package:momo/features/shared/presentation/widgets/loading.overlay.dart';

/// wallet details page
class WalletDetailsPage extends StatefulWidget {
  final Wallet wallet;

  const WalletDetailsPage({Key? key, required this.wallet}) : super(key: key);

  @override
  State<WalletDetailsPage> createState() => _WalletDetailsPageState();
}

class _WalletDetailsPageState extends State<WalletDetailsPage> {
  var _loading = true,
      _showBalances = false,
      _selectedIndex = 0,
      _transactions = List<Transaction>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    doAfterDelay(() async {
      await Future.delayed(kSampleDelay);
      setState(() {
        _transactions = kSampleTransactions;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor:
              context.colorScheme.secondary.withOpacity(kEmphasisNone),
          leading: IconButton(
            onPressed: context.router.pop,
            icon: const Icon(TablerIcons.arrow_back),
            color: context.colorScheme.onSecondary,
          ),
          actions: [
            IconButton(
              onPressed: () => setState(() => _showBalances = !_showBalances),
              icon: Icon(_showBalances ? TablerIcons.eye_off : TablerIcons.eye),
              color: context.colorScheme.onSecondary,
              tooltip: 'Toggle balances',
            ),
          ],
        ),
        body: LoadingOverlay(
          showBackgroundOverlay: false,
          isLoading: _loading,
          child: AnimationLimiter(
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                /// wallet info
                SliverToBoxAdapter(
                  child: Container(
                    height: context.height * 0.4,
                    width: context.width,
                    decoration: BoxDecoration(
                      color: context.colorScheme.secondary,
                      border: Border.all(
                        color: context.theme.disabledColor
                            .withOpacity(kEmphasisLowest),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 16, 8, 20),
                    child: SafeArea(
                      bottom: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.wallet.provider.toUpperCase(),
                                style: context.theme.textTheme.subtitle1
                                    ?.copyWith(
                                        color: context.colorScheme.onSecondary
                                            .withOpacity(kEmphasisLow)),
                              ),
                              Text(
                                widget.wallet.holder.toUpperCase(),
                                style: context.theme.textTheme.headline6
                                    ?.copyWith(
                                        color: context.colorScheme.onSecondary),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _showBalances
                                    ? formatAmount(widget.wallet.balance)
                                    : '***',
                                style: context.theme.textTheme.headline3
                                    ?.copyWith(
                                        color: context.colorScheme.onSecondary),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  _showBalances
                                      ? widget.wallet.phone
                                          .replaceAll('-', ' ')
                                          .replaceAll('+', '')
                                          .trim()
                                      : widget.wallet.hashedPhone,
                                  style: context.theme.textTheme.headline6
                                      ?.copyWith(
                                          letterSpacing: 2.5,
                                          color:
                                              context.colorScheme.onSecondary),
                                ),
                              ),
                              FloatingActionButton.extended(
                                heroTag: 'show-statement',
                                onPressed: () => showStatementsSheet(context),
                                backgroundColor:
                                    context.colorScheme.onSecondary,
                                foregroundColor: context.colorScheme.secondary,
                                icon: const Icon(TablerIcons.notes),
                                label: const Text('Statements'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// header
                SliverPadding(
                  padding: const EdgeInsets.only(
                      top: 24, right: 24, left: 24, bottom: 16),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      _selectedIndex == 0
                          ? 'Your recent transactions'
                          : 'Airtime reversals',
                      style: context.theme.textTheme.subtitle1,
                    ),
                  ),
                ),

                if (_selectedIndex == 0) ...{
                  if (_transactions.isEmpty) ...{
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: context.height * 0.35,
                        child: const EmptyContentPlaceholder(
                          icon: TablerIcons.receipt,
                          title: 'No recent transactions',
                          subtitle:
                              'Your recent transactions on this wallet will appear here',
                        ),
                      ),
                    ),
                  } else ...{
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          AnimationConfiguration.toStaggeredList(
                            duration: kListAnimationDuration,
                            childAnimationBuilder: (child) => SlideAnimation(
                              horizontalOffset: kListSlideOffset,
                              child: FadeInAnimation(child: child),
                            ),
                            children: _transactions
                                .map(
                                  (transaction) =>
                                      TransactionTile(transaction: transaction),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Center(
                        child: FloatingActionButton.extended(
                          heroTag: 'show-all-transactions',
                          onPressed: () =>
                              context.showSnackBar(kFeatureUnderDev),
                          backgroundColor: context.colorScheme.onSurface,
                          foregroundColor: context.colorScheme.surface,
                          icon: const Icon(TablerIcons.receipt),
                          label: const Text('See all'),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: SizedBox(height: context.height * 0.1)),
                  }
                } else ...{
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: context.height * 0.35,
                      child: EmptyContentPlaceholder(
                        icon: TablerIcons.receipt,
                        title: 'No airtime reversals',
                        subtitle: kAirtimeReversalErrorMessage,
                      ),
                    ),
                  ),
                },

                // spacing
                SliverToBoxAdapter(
                    child: SizedBox(height: context.height * 0.1)),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          heroTag: 'send-money',
          // todo
          onPressed: () => context.showSnackBar(kFeatureUnderDev),
          backgroundColor: context.colorScheme.secondary,
          foregroundColor: context.colorScheme.onSecondary,
          child: const Icon(TablerIcons.send),
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: const [TablerIcons.receipt, TablerIcons.arrow_back],
          activeIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.smoothEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          backgroundColor: context.colorScheme.background,
          activeColor: context.colorScheme.onBackground,
          inactiveColor: context.theme.disabledColor.withOpacity(kEmphasisLow),
        ),
      );
}
