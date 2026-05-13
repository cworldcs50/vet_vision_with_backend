import 'package:flutter/material.dart';

import '../../../core/classes/adaptive_layout.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.child,
    required this.onPressed,
    required this.backgroundColor,
    this.isOutlined = false,
  });

  final Widget child;
  final bool isOutlined;
  final Color backgroundColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: isOutlined ? 0 : 2,
        side:
            isOutlined ? const BorderSide(color: Colors.grey) : BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14)),
        ),
      ),
      child: child,
    );
  }
}