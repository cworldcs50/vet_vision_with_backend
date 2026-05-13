import 'package:flutter/material.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class CustomOnBoardingImage extends StatelessWidget {
  const CustomOnBoardingImage({required this.imgPath, super.key});

  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
      ),
      child: Image.asset(
        imgPath,
        fit: BoxFit.contain,
        width: MediaQuery.sizeOf(context).width * 0.8,
        height: MediaQuery.sizeOf(context).height * 0.35,
      ),
    );
  }
}


