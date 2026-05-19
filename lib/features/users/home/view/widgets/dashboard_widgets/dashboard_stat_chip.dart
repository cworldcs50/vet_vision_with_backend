import 'package:flutter/material.dart';

import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../../../../core/theme/app_colors.dart';

class DashboardStatChip extends StatelessWidget {
  const DashboardStatChip({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final radius = AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14),
        vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16,
              ),
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 6),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

