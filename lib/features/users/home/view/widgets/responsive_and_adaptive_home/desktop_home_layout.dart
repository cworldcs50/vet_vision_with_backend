import 'package:flutter/material.dart';

import 'mobile_home_layout.dart';

/// Desktop breakpoint uses the same layout as mobile until tailored.
class DesktopHomeLayout extends StatelessWidget {
  const DesktopHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const MobileHomeLayout();
  }
}
