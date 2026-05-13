import 'package:flutter/material.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class CustomHomeHeader extends StatelessWidget {
  const CustomHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good morning ☀️",
              style: TextStyle(
                color: Colors.white70,
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 5,
              ),
            ),
            Text(
              "Find Your Vet",
              style: TextStyle(
                color: Colors.white,
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 18,
                ),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none,
                size: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 20,
                ),
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
            ),
            CircleAvatar(
              radius: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 20,
              ),
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: const Color(0xFF009689),
                size: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
