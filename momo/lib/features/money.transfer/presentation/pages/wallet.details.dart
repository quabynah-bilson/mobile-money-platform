import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/features/shared/domain/entities/wallet/wallet.dart';
import 'package:momo/features/shared/presentation/widgets/loading.overlay.dart';

/// wallet details page
///
/// todo => build UI
class WalletDetailsPage extends StatefulWidget {
  final Wallet wallet;

  const WalletDetailsPage({Key? key, required this.wallet}) : super(key: key);

  @override
  State<WalletDetailsPage> createState() => _WalletDetailsPageState();
}

class _WalletDetailsPageState extends State<WalletDetailsPage> {
  var _loading = false, _showBalances = false, _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        color: context.colorScheme.surface,
        isLoading: _loading,
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
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
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
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
                            style: context.theme.textTheme.subtitle1?.copyWith(
                                color: context.colorScheme.onSecondary
                                    .withOpacity(kEmphasisLow)),
                          ),
                          Text(
                            widget.wallet.holder.toUpperCase(),
                            style: context.theme.textTheme.headline6?.copyWith(
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
                            style: context.theme.textTheme.headline3?.copyWith(
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
                                      color: context.colorScheme.onSecondary),
                            ),
                          ),
                          FloatingActionButton(
                            heroTag: 'send-money',
                            onPressed: () =>
                                context.showSnackBar(kFeatureUnderDev),
                            backgroundColor: context.colorScheme.onSecondary,
                            foregroundColor: context.colorScheme.secondary,
                            child: const Icon(TablerIcons.send),
                          ),
                          const SizedBox(width: 16),
                          FloatingActionButton(
                            heroTag: 'show-statement',
                            onPressed: () =>
                                context.showSnackBar(kFeatureUnderDev),
                            backgroundColor: context.colorScheme.onSecondary,
                            foregroundColor: context.colorScheme.secondary,
                            child: const Icon(TablerIcons.notes),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: kHomeFabTag,
        // todo
        onPressed: () => context.showSnackBar(kFeatureUnderDev),
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.onPrimary,
        child: const Icon(TablerIcons.notes),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          _selectedIndex == 0 ? TablerIcons.home_eco : TablerIcons.home_x,
          _selectedIndex == 1
              ? Icons.interests_sharp
              : Icons.interests_outlined,
        ],
        activeIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        backgroundColor: context.colorScheme.secondary,
        activeColor: context.colorScheme.onSecondary,
        inactiveColor:
            context.colorScheme.onSecondary.withOpacity(kEmphasisLow),
      ),
    );
  }
}
