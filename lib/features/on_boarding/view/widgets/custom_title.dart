import 'package:flutter/material.dart';
import '../../../../core/classes/adaptive_layout.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: const Color(0xFF009689),
        fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 25),
      ),
    );
  }
}