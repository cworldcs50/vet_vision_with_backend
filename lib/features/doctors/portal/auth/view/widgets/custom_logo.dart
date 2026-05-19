import 'package:flutter/material.dart';
import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../../../../core/constants/images_constants.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AdaptiveLayout.getResponsiveFontSize(
        context,
        fontSize: 100,
      ),
      height: AdaptiveLayout.getResponsiveFontSize(
        context,
        fontSize: 100,
      ),
      padding: EdgeInsets.all(
        AdaptiveLayout.getResponsiveFontSize(context, fontSize: 15),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 20,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Image.asset(
        ImagesConstants.kLogo,
        fit: BoxFit.contain,
      ),
    );
  }
}
