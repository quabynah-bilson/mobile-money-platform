import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
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
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.colorScheme.primary,
        body: LoadingOverlay(
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              const SliverAppBar(
                title: Text('More options'),
                backgroundColor: Colors.transparent,
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                sliver: SliverGrid(
                  delegate: SliverChildListDelegate(
                    [
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
                    ],
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
      );
}
