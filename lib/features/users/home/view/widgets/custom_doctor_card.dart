import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controller/home_controller.dart';
import '../../../booking/model/doctor_model.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class CustomDoctorCard extends GetView<HomeController> {
  final DoctorModel doctor;

  const CustomDoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.goToDoctorProfile(doctor),
      child: Container(
        padding: EdgeInsets.all(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 5),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
              ),
              child: Image.network(
                doctor.imageUrl,
                width: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 80,
                ),
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 80,
                ),
                fit: BoxFit.cover,
                errorBuilder: (_, error, _) {
                  log(error.toString());
                  return Icon(
                    Icons.person,
                    size: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 80,
                    ),
                    color: Colors.grey,
                  );
                },
              ),
            ),
            // AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12)orizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          doctor.name,
                          style: TextStyle(
                            fontSize: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 16,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.favorite_border,
                        size: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 16,
                        ),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 4,
                    ),
                  ),
                  Text(
                    doctor.specialization,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 8,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        doctor.ratingDisplay,
                        style: TextStyle(
                          fontSize: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 12,
                          ),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.location_on,
                        color: Colors.grey.shade400,
                        size: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        doctor.distanceKm != null
                            ? '${doctor.distanceKm!.toStringAsFixed(1)} km'
                            : '—',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
