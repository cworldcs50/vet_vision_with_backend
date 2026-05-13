import 'package:flutter/material.dart';

import '../../../../../core/classes/adaptive_layout.dart';

class CustomInfoBox extends StatelessWidget {
  const CustomInfoBox({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16)),
      decoration: BoxDecoration(
        color: const Color(0xFF009689).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF009689),
            size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
          ),
          SizedBox(width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: const Color(0xFF009689),
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 13,
                ),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

