import 'package:flutter/material.dart';

import '../../../../../core/classes/adaptive_layout.dart';
import 'responsive_and_adaptive_home/desktop_home_layout.dart';
import 'responsive_and_adaptive_home/mobile_home_layout.dart';
import 'responsive_and_adaptive_home/tablet_home_layout.dart';

class CustomHomeBody extends StatelessWidget {
  const CustomHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => const MobileHomeLayout(),
      tabletLayout: (context) => const TabletHomeLayout(),
      desktopLayout: (context) => const DesktopHomeLayout(),
    );
  }
}
