import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/classes/adaptive_layout.dart';
import '../../../core/theme/app_colors.dart';
import '../doctor_portal_controller.dart';

class ProfileImageHeader extends GetView<DoctorPortalController> {
  const ProfileImageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.accent,
                width: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 2,
                ),
              ),
            ),
            child: Obx(() {
              final url = controller.imageUrl.value;
              return GetBuilder<DoctorPortalController>(
                builder: (ctrl) {
                  return CircleAvatar(
                    radius: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 50,
                    ),
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: ctrl.profileImage != null
                        ? FileImage(File(ctrl.profileImage!.path))
                        : (url.isNotEmpty ? NetworkImage(url) : null) as ImageProvider?,
                    child: ctrl.profileImage == null && url.isEmpty
                        ? Icon(
                            Icons.person,
                            size: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 50,
                            ),
                            color: Colors.grey.shade400,
                          )
                        : null,
                  );
                },
              );
            }),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () async => await controller.pickImage(),
              child: Container(
                padding: EdgeInsets.all(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 6),
                ),
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
