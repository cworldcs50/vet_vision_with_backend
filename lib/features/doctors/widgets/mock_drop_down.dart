import 'package:flutter/material.dart';

import '../../../core/classes/adaptive_layout.dart';

class MockDropdown extends StatelessWidget {
  final String label;
  final String value;

  const MockDropdown({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 11,
            ),
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 12,
            ),
            vertical: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 10,
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 13,
                  ),
                  color: Colors.black87,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                size: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
