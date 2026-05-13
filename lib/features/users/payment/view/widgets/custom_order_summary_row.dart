import 'package:flutter/material.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class CustomOrderSummaryRow extends StatelessWidget {
  const CustomOrderSummaryRow({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

