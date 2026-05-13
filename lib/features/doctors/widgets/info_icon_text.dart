import 'package:flutter/material.dart';

import '../../../core/classes/adaptive_layout.dart';

class InfoIconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? textColor;

  const InfoIconText({
    required this.icon,
    required this.text,
    this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14),
          color: textColor ?? Colors.grey,
        ),
        SizedBox(
          width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 6),
        ),

        Text(
          text,
          style: TextStyle(
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 12,
            ),
            color: textColor ?? Colors.black54,
            fontWeight: textColor != null ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
