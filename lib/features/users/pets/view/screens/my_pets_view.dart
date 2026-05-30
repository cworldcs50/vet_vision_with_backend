import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/network/request_status.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../features/doctors/portal/appointments/data/models/animal_model.dart';
import '../../controller/my_pets_controller.dart';

class MyPetsView extends GetView<MyPetsController> {
  const MyPetsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'My Pets',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.openAddForm,
        backgroundColor: AppColors.primaryColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add Pet',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Obx(() {
        if (controller.status.value == RequestStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }
        if (controller.status.value == RequestStatus.failure) {
          return _buildError(context);
        }
        if (controller.pets.isEmpty) {
          return _buildEmpty(context);
        }
        return RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: controller.fetchPets,
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 100),
            ),
            itemCount: controller.pets.length,
            itemBuilder: (_, i) =>
                _PetCard(pet: controller.pets[i], controller: controller),
          ),
        );
      }),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 100),
            height: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 100,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.pets,
              size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 52),
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
          ),
          Text(
            'No pets yet',
            style: TextStyle(
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 20,
              ),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
          ),
          Text(
            'Add your first pet to get started',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 28),
          ),
          ElevatedButton.icon(
            onPressed: controller.openAddForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(
                horizontal: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 24,
                ),
                vertical: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 12,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 30),
                ),
              ),
            ),
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Add Pet',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off_rounded, size: 64, color: Colors.grey),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
          ),
          Text(
            'Failed to load pets',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
          ),
          ElevatedButton(
            onPressed: controller.fetchPets,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            child: const Text('Retry', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _PetCard extends StatelessWidget {
  const _PetCard({required this.pet, required this.controller});
  final AnimalModel pet;
  final MyPetsController controller;

  @override
  Widget build(BuildContext context) {
    final hasImage = pet.imageUrl != null && pet.imageUrl!.isNotEmpty;

    return Container(
      margin: EdgeInsets.only(
        bottom: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 12,
            ),
            offset: Offset(
              0,
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4),
            ),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          ClipRRect(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
              ),
            ),
            child: hasImage
                ? Image.network(
                    pet.imageUrl!,
                    width: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 90,
                    ),
                    height: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 90,
                    ),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      log(error.toString());
                      return _defaultAvatar(context);
                    },
                  )
                : _defaultAvatar(context),
          ),

          SizedBox(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14),
          ),

          // Info
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 14,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          pet.name,
                          style: TextStyle(
                            fontSize: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 16,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _genderChip(pet.gender, context),
                    ],
                  ),
                  SizedBox(
                    height: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 4,
                    ),
                  ),
                  Text(
                    '${pet.species} · ${pet.breed}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 6,
                    ),
                  ),
                  Row(
                    children: [
                      _infoTag(Icons.cake_outlined, '${pet.age} yr', context),
                      SizedBox(
                        width: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 8,
                        ),
                      ),
                      _infoTag(
                        Icons.monitor_weight_outlined,
                        '${pet.weight} kg',
                        context,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Actions
          Padding(
            padding: EdgeInsets.only(
              right: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () => controller.openEditForm(pet),
                  tooltip: 'Edit',
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                  ),
                  onPressed: () => controller.deletePet(pet),
                  tooltip: 'Delete',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _defaultAvatar(BuildContext context) {
    return Container(
      width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 90),
      height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 90),
      color: AppColors.primaryColor.withValues(alpha: 0.1),
      child: Icon(
        Icons.pets,
        size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 36),
        color: AppColors.primaryColor,
      ),
    );
  }

  Widget _genderChip(String gender, BuildContext context) {
    final isMale = gender.toLowerCase() == 'male';
    return Container(
      margin: EdgeInsets.only(
        right: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
        vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 3),
      ),
      decoration: BoxDecoration(
        color: (isMale ? Colors.blue : Colors.pink).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 30),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMale ? Icons.male : Icons.female,
            size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 13),
            color: isMale ? Colors.blue : Colors.pink,
          ),
          SizedBox(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 2),
          ),
          Text(
            isMale ? 'Male' : 'Female',
            style: TextStyle(
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 11,
              ),
              fontWeight: FontWeight.w600,
              color: isMale ? Colors.blue : Colors.pink,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTag(IconData icon, String label, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 13),
          color: Colors.grey[500],
        ),
        SizedBox(
          width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 3),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 12,
            ),
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
