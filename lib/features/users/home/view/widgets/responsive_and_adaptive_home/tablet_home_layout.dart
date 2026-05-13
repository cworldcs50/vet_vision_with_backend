import 'package:flutter/material.dart';

import 'mobile_home_layout.dart';

/// Tablet breakpoint uses the same layout as mobile until tailored.
class TabletHomeLayout extends StatelessWidget {
  const TabletHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const MobileHomeLayout();
  }
}
