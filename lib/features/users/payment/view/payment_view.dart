import 'widgets/mobile_payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/classes/adaptive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../controller/payment_controller.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PaymentController());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Payment",
          style: TextStyle(
            color: Colors.black,
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 18,
            ),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: AdaptiveLayout(
        mobileLayout: (context) => const MobilePayment(),
        tabletLayout: (context) => const MobilePayment(),
        desktopLayout: (context) => const MobilePayment(),
      ),
    );
  }
}
