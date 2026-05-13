import 'package:flutter/material.dart';

import '../../../core/classes/adaptive_layout.dart';

class ProfileImageHeader extends StatelessWidget {
  const ProfileImageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF009689), width: 2),
            ),
            child: CircleAvatar(
              radius: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 50,
              ),
              backgroundColor: Colors.grey.shade200,
              backgroundImage: const NetworkImage(
                "https://raw.githubusercontent.com/flutter/website/master/examples/layout/lakes/step5/images/lake.jpg", // Placeholder
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 6),
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF009689),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

