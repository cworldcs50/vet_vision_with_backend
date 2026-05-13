import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/adaptive_layout.dart';
import '../../../core/constants/images_constants.dart';
import '../controller/logo_controller.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LogoController>(
        builder: (controller) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0XFF008091), Color(0XFF00A595)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    onEnd: controller.oEnd,
                    duration: controller.duration,
                    opacity: controller.isVisible ? 1.0 : 0.0,
                    child: Image.asset(
                      ImagesConstants.kLogo,
                      width: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 600,
                      ),
                      height: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 600,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
