import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/features/shared/presentation/widgets/animated.column.dart';
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
                  if(snapshot.hasData && snapshot.data != null) {
                    version = '(v${snapshot.data?.version})';
                  }
                  return Text(
                    '$kAppName$version',
                    style: context.theme.textTheme.headline4?.copyWith(
                      color: context.colorScheme.secondaryContainer,
                    ),
                  );
                }
              ),
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
