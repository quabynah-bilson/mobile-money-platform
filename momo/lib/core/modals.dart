import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/user.session.dart';
import 'package:momo/features/shared/presentation/widgets/animated.column.dart';
import 'package:momo/features/shared/presentation/widgets/animated.list.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'constants.dart';

/// app details
Future<void> showAppDetailsSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    clipBehavior: Clip.hardEdge,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(kRadiusLarge),
        topLeft: Radius.circular(kRadiusLarge),
      ),
    ),
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AnimatedColumn(
            animateType: AnimateType.slideUp,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: kAppLoadingAnimation,
                child: LottieBuilder.asset(
                  kAppLoadingAnimation,
                  height: context.height * 0.2,
                  repeat: false,
                ),
              ),
              FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    var version = '';
                    if (snapshot.hasData && snapshot.data != null) {
                      version = '(v${snapshot.data?.version})';
                    }
                    return Text(
                      '$kAppName$version',
                      style: context.theme.textTheme.headline4?.copyWith(
                        color: context.colorScheme.secondaryContainer,
                      ),
                    );
                  }),
              const SizedBox(height: 12),
              Text(
                kAppDesc,
                style: context.theme.textTheme.subtitle2?.copyWith(
                  color: context.colorScheme.onSurface
                      .withOpacity(kEmphasisMedium),
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Text(
                  kAppDevTeam,
                  style: context.theme.textTheme.caption?.copyWith(
                    color:
                        context.colorScheme.onSurface.withOpacity(kEmphasisLow),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              FloatingActionButton.extended(
                heroTag: kHomeFabTag,
                onPressed: context.router.pop,
                label: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text('Dismiss'),
                ),
                backgroundColor: context.colorScheme.secondary,
                foregroundColor: context.colorScheme.onSecondary,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// show profile sheet with more options
Future<void> showProfileSheetWithOptions(BuildContext context) async {
  /// tile
  Widget buildTileAction(BuildContext context, String title, IconData icon,
          [void Function()? onTap]) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadiusSmall),
          border: Border.all(
            color: context.theme.disabledColor.withOpacity(kEmphasisLowest),
          ),
          color: context.colorScheme.surface,
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          onTap: () {
            if (onTap != null) onTap();
            context.router.pop();
          },
          trailing: Icon(
            Icons.arrow_right_alt_outlined,
            color: context.colorScheme.onSurface.withOpacity(kEmphasisLow),
          ),
        ),
      );

  await showModalBottomSheet(
    context: context,
    clipBehavior: Clip.hardEdge,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(kRadiusLarge),
        topLeft: Radius.circular(kRadiusLarge),
      ),
    ),
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => Stack(
        children: [
          /// content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AnimatedListView(
              animateType: AnimateType.slideUp,
              children: [
                /// logo
                Hero(
                  tag: kAppLoadingAnimation,
                  child: LottieBuilder.asset(
                    kAppLoadingAnimation,
                    height: context.height * 0.2,
                    repeat: false,
                  ),
                ),

                /// username
                Text(
                  '${UserSessionHandler.kUsername}',
                  style: context.theme.textTheme.headline4?.copyWith(
                    color: context.colorScheme.secondaryContainer,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                /// description
                Text(
                  kAppDesc,
                  style: context.theme.textTheme.subtitle2?.copyWith(
                    color: context.colorScheme.onSurface
                        .withOpacity(kEmphasisMedium),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                /// options
                /// todo => build actions for tiles
                buildTileAction(
                  context,
                  'Contact customer care',
                  Icons.support_agent_outlined,
                  callCustomerCare,
                ),
                buildTileAction(context, 'Agent Locator',
                    Icons.supervisor_account_outlined),
                buildTileAction(
                    context, 'Share application', TablerIcons.share),
                buildTileAction(context, 'Change PIN', TablerIcons.lock_access),
                buildTileAction(
                    context, 'Report Fraud', TablerIcons.speakerphone),

                /// team
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    kAppDevTeam,
                    style: context.theme.textTheme.caption?.copyWith(
                      color: context.colorScheme.onSurface
                          .withOpacity(kEmphasisLow),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                SafeArea(
                  top: false,
                  child: FloatingActionButton.extended(
                    heroTag: kHomeFabTag,
                    onPressed: () {
                      UserSessionHandler.kUsername = null;
                      context.router.pop();
                    },
                    label: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text('Sign out'),
                    ),
                    icon: const Icon(TablerIcons.logout),
                    backgroundColor: context.colorScheme.error,
                    foregroundColor: context.colorScheme.onErrorContainer,
                    enableFeedback: true,
                  ),
                ),
              ],
            ),
          ),

          /// close
          AnimatedPositioned(
            duration: kScrollAnimationDuration,
            top: 24,
            right: 24,
            child: SafeArea(
              bottom: false,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colorScheme.secondary,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: context.router.pop,
                  icon: const Icon(TablerIcons.x),
                  color: context.colorScheme.onSecondary,
                  iconSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
