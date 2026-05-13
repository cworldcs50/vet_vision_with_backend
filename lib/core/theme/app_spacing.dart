import 'package:flutter/material.dart';

class AppSpacing {
  // Padding & Margin
  static const double xxs = 4.0;
  static const double xs = 8.0;
  static const double s = 12.0;
  static const double m = 16.0;
  static const double l = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  // Border Radius
  static const double radiusXs = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 999.0;

  // Icon Sizes
  static const double iconXs = 16.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXl = 48.0;

  // Helpers for common EdgeInsets
  static const EdgeInsets edgeInsetsAllNone = EdgeInsets.zero;
  static const EdgeInsets edgeInsetsAllXs = EdgeInsets.all(xs);
  static const EdgeInsets edgeInsetsAllS = EdgeInsets.all(s);
  static const EdgeInsets edgeInsetsAllM = EdgeInsets.all(m);
  static const EdgeInsets edgeInsetsAllL = EdgeInsets.all(l);

  static const EdgeInsets edgeInsetsHorizontalMVerticalS = EdgeInsets.symmetric(horizontal: m, vertical: s);
  static const EdgeInsets edgeInsetsHorizontalLVerticalM = EdgeInsets.symmetric(horizontal: l, vertical: m);
}
