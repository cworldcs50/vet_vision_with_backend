import 'package:flutter/material.dart';

import '../../../core/classes/adaptive_layout.dart';

class StepTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const StepTitle({required this.title, required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black87,
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 18,
            ),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4),
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.black54,
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

