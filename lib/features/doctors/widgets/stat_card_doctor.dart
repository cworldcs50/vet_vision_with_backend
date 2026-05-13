import 'package:flutter/material.dart';

import '../../../core/classes/adaptive_layout.dart';


class StatCardDoctor extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const StatCardDoctor({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16)),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
            offset: Offset(0, AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4)),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 6)),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8)),
            ),
            child: Icon(icon, color: iconColor, size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
                  color: Colors.black54,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
