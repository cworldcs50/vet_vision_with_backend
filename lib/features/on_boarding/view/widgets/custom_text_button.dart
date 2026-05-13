import 'package:flutter/material.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.onPressed,
    required this.btnTitle,
    super.key,
  });

  final String btnTitle;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        btnTitle,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
          fontWeight: FontWeight.bold,
          fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        ),
      ),
    );
  }
}

