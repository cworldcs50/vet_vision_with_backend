import 'package:flutter/material.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class CustomSection extends StatelessWidget {
  const CustomSection({super.key, required this.title, required this.items});

  final String title;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16,
              ),
              vertical: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }
}
