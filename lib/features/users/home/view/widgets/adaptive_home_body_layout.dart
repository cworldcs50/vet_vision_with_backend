import 'package:flutter/material.dart';

class AdaptiveLayout extends StatelessWidget {
  final Widget mobileAndTabletLayout;
  final Widget desktopLayout;

  const AdaptiveLayout({
    super.key,
    required this.desktopLayout,
    required this.mobileAndTabletLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobileAndTabletLayout;
        } else if (constraints.maxWidth < 840) {
          return mobileAndTabletLayout;
        } else {
          return desktopLayout;
        }
      },
    );
  }
}
