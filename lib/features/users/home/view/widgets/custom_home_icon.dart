import 'package:flutter/material.dart';

class CustomHomeIcon extends StatelessWidget {
  const CustomHomeIcon({
    super.key,
    required this.icon,
    required this.iconSize,
    required this.iconColor,
    required this.backgroundHeight,
    required this.backgroundWidth,
  });

  final IconData icon;
  final Color iconColor;
  final double backgroundWidth, backgroundHeight, iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: backgroundWidth,
      height: backgroundHeight,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0XFF40D9C8),
      ),
      child: Icon(size: iconSize, color: iconColor, icon),
    );
  }
}
