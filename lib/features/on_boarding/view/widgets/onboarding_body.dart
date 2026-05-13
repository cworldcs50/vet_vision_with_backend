import '../../../../core/theme/app_spacing.dart';
import '../../../../core/classes/adaptive_layout.dart';
import 'custom_title.dart';
import 'custom_description_text.dart';
import 'custom_on_boarding_image.dart';
import 'package:flutter/material.dart';

class CustomOnBoardingBody extends StatelessWidget {
  const CustomOnBoardingBody({
    super.key,
    required this.next,
    required this.title,
    required this.imgPath,
    required this.description,
  });

  final void Function() next;
  final String title, description, imgPath;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomOnBoardingImage(imgPath: imgPath),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: AppSpacing.l,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: AppSpacing.l,
              ),
            ),
            child: Column(
              children: [
                CustomTitle(title: title),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: AppSpacing.m,
                  ),
                ),
                CustomDescription(description: description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
