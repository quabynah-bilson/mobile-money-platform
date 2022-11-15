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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: LoadingOverlay(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  kFeatureUnderDev,
                  textAlign: TextAlign.center,
                  style: context.theme.textTheme.headline6
                      ?.copyWith(color: context.colorScheme.onPrimary),
                ),
                const SizedBox(height: 24),
                FloatingActionButton.extended(
                  onPressed: context.router.pop,
                  icon: const Icon(TablerIcons.arrow_back_up),
                  backgroundColor: context.colorScheme.onPrimary,
                  foregroundColor: context.colorScheme.primary,
                  label: const Text('Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
