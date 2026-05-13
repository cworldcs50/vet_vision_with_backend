import 'package:flutter/material.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.buttonTitle,
    required this.onPressed,
    super.key,
  });

  final String buttonTitle;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        fixedSize: Size(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 200), AdaptiveLayout.getResponsiveFontSize(context, fontSize: 40)),
        minimumSize: Size(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 50), AdaptiveLayout.getResponsiveFontSize(context, fontSize: 30)),
        maximumSize: Size(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 200), AdaptiveLayout.getResponsiveFontSize(context, fontSize: 40)),
        foregroundColor: const Color(0XFFFFFFFF),
        backgroundColor: const Color(0XFF00BBA7),
      ),
      child: Text(
        buttonTitle,
        style: TextStyle(
          fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        ),
      ),
    );
  }
}