import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class FilterSectionHeader extends StatelessWidget {
  final String title;

  const FilterSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
        bottom: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
