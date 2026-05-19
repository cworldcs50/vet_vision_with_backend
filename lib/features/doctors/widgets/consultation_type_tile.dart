import 'package:flutter/material.dart';

import '../../../core/classes/adaptive_layout.dart';
import '../../../core/theme/app_colors.dart';

class ConsultationTypeTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const ConsultationTypeTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: value ? const Color(0xFF009689) : Colors.grey.shade200,
        ),
        borderRadius: BorderRadius.circular(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
        ),
        color: value ? Colors.white : Colors.transparent,
      ),
      child: CheckboxListTile(
        side: BorderSide(
          color: value ? AppColors.accent : Colors.white,
          width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 2),
        ),
        value: value,
        onChanged: onChanged,
        title: Text(
          title,
          style: TextStyle(
            color: value ? AppColors.accent : Colors.white,
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 14,
            ),
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: value ? AppColors.accent : Colors.white,
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 12,
            ),
          ),
        ),
        activeColor: AppColors.accent,
        checkboxShape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white,
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 2),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
