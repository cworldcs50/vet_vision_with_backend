import 'package:flutter/material.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class CustomHomeHeader extends StatelessWidget {
  const CustomHomeHeader({super.key, this.userDisplayName});

  final String? userDisplayName;

  String _timeGreeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final greeting = _timeGreeting();
    final trimmed = userDisplayName?.split(" ");

    final line1 = (trimmed != null && trimmed.isNotEmpty)
        ? '$greeting, ${trimmed.first} ${trimmed.last} ☀️'
        : '$greeting ☀️';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              line1,
              style: TextStyle(
                color: Colors.white70,
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 5,
              ),
            ),
            Text(
              'Find Your Vet',
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
