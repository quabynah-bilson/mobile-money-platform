import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/modals.dart';
import 'package:momo/features/shared/presentation/widgets/dashboard.tile.dart';
import 'package:momo/features/shared/presentation/widgets/loading.overlay.dart';

/// shows options for dashboard
/// todo => add actions for dashboard tiles
class DashboardOptionsPage extends StatefulWidget {
  const DashboardOptionsPage({Key? key}) : super(key: key);

  @override
  State<DashboardOptionsPage> createState() => _DashboardOptionsPageState();
}

class _DashboardOptionsPageState extends State<DashboardOptionsPage> {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Scaffold(
        backgroundColor: context.colorScheme.primary,
        body: LoadingOverlay(
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverAppBar(
                  title: const Text('More options'),
                  backgroundColor:
                      context.colorScheme.primary.withOpacity(kEmphasisNone)),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                sliver: SliverGrid(
                  delegate: SliverChildListDelegate(
                    AnimationConfiguration.toStaggeredList(
                      duration: kGridAnimationDuration,
                      childAnimationBuilder: (child) => SlideAnimation(
                        verticalOffset: kListSlideOffset,
                        child: FadeInAnimation(child: child),
                      ),
                      children: [
                        const DashboardActionTile(
                          label: 'Favorites',
                          icon: TablerIcons.heart_plus,
                        ),
                        const DashboardActionTile(
                          label: 'Airtime reversals',
                          icon: TablerIcons.arrow_back,
                        ),
                        const DashboardActionTile(
                          label: 'Statements',
                          icon: TablerIcons.notes,
                        ),
                        const DashboardActionTile(
                          label: 'Change PIN',
                          icon: TablerIcons.lock_access,
                        ),
                        const DashboardActionTile(
                          label: 'Report Fraud',
                          icon: TablerIcons.speakerphone,
                        ),
                        const DashboardActionTile(
                          label: 'Agent Locator',
                          icon: Icons.supervisor_account_outlined,
                        ),
                        const DashboardActionTile(
                          label: 'Customer care',
                          icon: Icons.support_agent_outlined,
                          onTap: callCustomerCare,
                        ),
                        const DashboardActionTile(
                          label: 'MTN Services',
                          icon: Icons.sim_card_outlined,
                        ),
                        DashboardActionTile(
                          label: 'About us',
                          icon: TablerIcons.info_circle,
                          onTap: () => showAppDetailsSheet(context),
                        ),
                      ],
                    ),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
