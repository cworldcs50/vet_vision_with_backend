import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class CustomCheckoutDoctorCard extends StatelessWidget {
  const CustomCheckoutDoctorCard({
    super.key,
    required this.price,
    required this.imgPath,
    required this.specialty,
    required this.doctorName,
  });

  final double price;
  final String imgPath, specialty, doctorName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
          backgroundImage: imgPath.startsWith('http')
              ? NetworkImage(imgPath) as ImageProvider
              : AssetImage(imgPath),
        ),
        SizedBox(
          width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctorName,
                style: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 15,
                  ),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 2,
                ),
              ),
              Text(
                specialty,
                style: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 12,
                  ),
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 2,
                ),
              ),
              Text(
                "\$${price.toStringAsFixed(0)} per session",
                style: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 11,
                  ),
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
