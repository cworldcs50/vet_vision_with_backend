import 'dart:developer';

import 'package:flutter/material.dart';

class AdaptiveLayout extends StatelessWidget {
  final WidgetBuilder mobileLayout;
  final WidgetBuilder tabletLayout;
  final WidgetBuilder desktopLayout;

  const AdaptiveLayout({
    super.key,
    required this.mobileLayout,
    required this.tabletLayout,
    required this.desktopLayout,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width <= 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width <= 840;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width > 840;

  static bool showAppBar(BuildContext context) => !isDesktop(context);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          log("mobile");
          return mobileLayout(context);
        } else if (constraints.maxWidth < 900) {
          log("tablet");
          return tabletLayout(context);
        } else {
          log("ibad");
          return desktopLayout(context);
        }
      },
    );
  }

  static double getResponsiveFontSize(
    BuildContext context, {
    required double fontSize,
  }) {
    double scaler = getScalerValue(context);

    double responsiveFontSize = fontSize * scaler;

    log("$responsiveFontSize");

    return responsiveFontSize.clamp(
      responsiveFontSize * 0.8,
      responsiveFontSize * 1.2,
    );
  }

  static double getScalerValue(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    if (width < 600) {
      return width / 400;
    } else if (width < 900) {
      return width / 700;
    } else {
      return width / 1000;
    }
  }
}
