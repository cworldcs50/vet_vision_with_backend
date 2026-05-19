import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../classes/adaptive_layout.dart';
import '../theme/app_colors.dart';

/// Standard pull-to-refresh for **users** feature scroll views (liquid indicator).
///
/// Wrap a vertical [ScrollView] (e.g. [ListView], [CustomScrollView],
/// [SingleChildScrollView]). Use [AlwaysScrollableScrollPhysics] on the child
/// when content may be shorter than the viewport so pull-to-refresh still works.
class UsersLiquidPullToRefresh extends StatelessWidget {
  const UsersLiquidPullToRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: onRefresh,
      color: AppColors.primary,
      backgroundColor: AppColors.surface,
      height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 72),
      showChildOpacityTransition: false,
      child: child,
    );
  }
}
