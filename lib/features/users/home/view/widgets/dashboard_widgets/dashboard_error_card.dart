import 'package:flutter/material.dart';

import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../../../../core/theme/app_colors.dart';

class DashboardErrorCard extends StatelessWidget {
  const DashboardErrorCard({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(
        AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              message ?? 'Dashboard unavailable',
              style: TextStyle(
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 13,
                ),
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 10,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: onRetry,
                child: Text(
                  'Retry',
                  style: TextStyle(
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 14,
                    ),
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
