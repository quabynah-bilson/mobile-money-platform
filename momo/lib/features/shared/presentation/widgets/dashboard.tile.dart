import 'package:flutter/material.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';

/// action tile for main dashboard
class DashboardActionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final void Function()? onTap;

  const DashboardActionTile({
    Key? key,
    required this.label,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap ?? () => context.showSnackBar(kFeatureUnderDev),
        child: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surface.withOpacity(kEmphasisMedium),
            borderRadius: BorderRadius.circular(kRadiusMedium),
            border: Border.all(
              color: context.theme.disabledColor.withOpacity(kEmphasisLow),
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: context.colorScheme.secondary, size: 40),
              const SizedBox(height: 12),
              Text(
                label,
                style: context.theme.textTheme.subtitle2
                    ?.copyWith(color: context.colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
}
