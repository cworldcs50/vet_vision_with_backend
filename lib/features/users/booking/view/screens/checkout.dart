import '../widgets/mobile_checkout.dart';
import '../widgets/desktop_checkout.dart';
import '../widgets/tablet_checkout.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: Text(
          "Book Appointment",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 15,
            ),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: AdaptiveLayout(
        mobileLayout: (context) => const MobileCheckout(),
        tabletLayout: (context) => const TabletCheckout(),
        desktopLayout: (context) => const DesktopCheckout(),
      ),
    );
  }
}
