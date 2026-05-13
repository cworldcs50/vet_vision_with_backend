import 'package:flutter/material.dart';

import '../../../core/classes/adaptive_layout.dart';

class HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const HeaderIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white24,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
          size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

