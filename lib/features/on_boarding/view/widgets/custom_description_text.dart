import 'package:flutter/material.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class CustomDescription extends StatelessWidget {
  const CustomDescription({required this.description, super.key});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            height: 1.5,
            fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
          ),
    );
  }
}


