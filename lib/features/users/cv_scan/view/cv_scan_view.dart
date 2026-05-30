import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/classes/adaptive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../controller/cv_scan_controller.dart';

class CvScanView extends StatelessWidget {
  const CvScanView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CvScanController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5FFFE),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Column(
          children: [
            Text(
              'AI Disease Scan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              'Powered by Deep Learning',
              style: TextStyle(
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 10,
                ),
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Animal Type Selector ────────────────────────────────────────
            Text(
              'Select Animal Type',
              style: TextStyle(
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 15,
                ),
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1C1E),
              ),
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
            ),
            Obx(
              () => Row(
                children: [
                  _AnimalTypeCard(
                    emoji: '🐄',
                    label: 'Cattle',
                    sublabel: 'Lumpy Skin\nFoot-and-Mouth',
                    type: AnimalType.cattle,
                    isSelected:
                        controller.selectedAnimalType.value ==
                        AnimalType.cattle,
                    onTap: () => controller.selectAnimalType(AnimalType.cattle),
                  ),
                  SizedBox(
                    width: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 10,
                    ),
                  ),
                  _AnimalTypeCard(
                    emoji: '🐈',
                    label: 'Cat',
                    sublabel: 'Ringworm\nScabies',
                    type: AnimalType.cat,
                    isSelected:
                        controller.selectedAnimalType.value == AnimalType.cat,
                    onTap: () => controller.selectAnimalType(AnimalType.cat),
                  ),
                  SizedBox(
                    width: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 10,
                    ),
                  ),
                  _AnimalTypeCard(
                    emoji: '🐔',
                    label: 'Chicken',
                    sublabel: 'Newcastle\nCoccidiosis',
                    type: AnimalType.chicken,
                    isSelected:
                        controller.selectedAnimalType.value ==
                        AnimalType.chicken,
                    onTap: () =>
                        controller.selectAnimalType(AnimalType.chicken),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 24,
              ),
            ),

            // ── Image Upload Area ───────────────────────────────────────────
            Text(
              'Upload Animal Image',
              style: TextStyle(
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 15,
                ),
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1C1E),
              ),
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
            ),
            Obx(() {
              final img = controller.pickedImage.value;
              return GestureDetector(
                onTap: _showImageSourceDialog(context, controller),
                child: Container(
                  width: double.infinity,
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 220,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 18,
                      ),
                    ),
                    border: Border.all(
                      color: img != null
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.3),
                      width: img != null ? 2 : 1.5,
                      style: BorderStyle.solid,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 10,
                        ),
                        offset: Offset(
                          0,
                          AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  child: img != null
                      ? Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 16,
                                ),
                              ),
                              child: Image.file(
                                img,
                                width: double.infinity,
                                height: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 220,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 10,
                              ),
                              right: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 10,
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      AdaptiveLayout.getResponsiveFontSize(
                                        context,
                                        fontSize: 12,
                                      ),
                                  vertical:
                                      AdaptiveLayout.getResponsiveFontSize(
                                        context,
                                        fontSize: 6,
                                      ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(
                                    AdaptiveLayout.getResponsiveFontSize(
                                      context,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      size:
                                          AdaptiveLayout.getResponsiveFontSize(
                                            context,
                                            fontSize: 14,
                                          ),
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width:
                                          AdaptiveLayout.getResponsiveFontSize(
                                            context,
                                            fontSize: 4,
                                          ),
                                    ),
                                    Text(
                                      'Change',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            AdaptiveLayout.getResponsiveFontSize(
                                              context,
                                              fontSize: 12,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 64,
                              ),
                              height: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 64,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add_photo_alternate_outlined,
                                color: AppColors.primary,
                                size: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 32,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Tap to upload image',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 4,
                              ),
                            ),
                            Text(
                              'Take a clear photo of the affected area',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              );
            }),

            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 20,
              ),
            ),

            // ── Scan Button ─────────────────────────────────────────────────
            Obx(() {
              final isLoading =
                  controller.scanStatus.value == ScanStatus.loading;
              return SizedBox(
                width: double.infinity,
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 54,
                ),
                child: ElevatedButton(
                  onPressed: isLoading ? null : controller.runScan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.primary.withValues(
                      alpha: 0.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    elevation: 3,
                  ),
                  child: isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 20,
                              ),
                              height: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 20,
                              ),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            ),
                            SizedBox(
                              width: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Analyzing...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 15,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.biotech_outlined,
                              color: Colors.white,
                              size: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(
                              width: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              'Scan Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 15,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              );
            }),

            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 24,
              ),
            ),

            // ── Result Card ─────────────────────────────────────────────────
            Obx(() {
              if (controller.scanStatus.value != ScanStatus.success) {
                return const SizedBox.shrink();
              }
              return _ResultCard(controller: controller);
            }),
          ],
        ),
      ),
    );
  }

  VoidCallback _showImageSourceDialog(
    BuildContext context,
    CvScanController controller,
  ) {
    return () => showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
          ),
        ),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.all(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 40,
              ),
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 2),
                ),
              ),
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16,
              ),
            ),
            Text(
              'Select Image Source',
              style: TextStyle(
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 20,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: _SourceOption(
                    icon: Icons.photo_library_outlined,
                    label: 'Gallery',
                    onTap: () {
                      Get.back();
                      controller.pickImage();
                    },
                  ),
                ),
                SizedBox(
                  width: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 12,
                  ),
                ),
                Expanded(
                  child: _SourceOption(
                    icon: Icons.camera_alt_outlined,
                    label: 'Camera',
                    onTap: () {
                      Get.back();
                      controller.pickImageFromCamera();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Animal Type Card ──────────────────────────────────────────────────────────
class _AnimalTypeCard extends StatelessWidget {
  final String emoji;
  final String label;
  final String sublabel;
  final AnimalType type;
  final bool isSelected;
  final VoidCallback onTap;

  const _AnimalTypeCard({
    required this.emoji,
    required this.label,
    required this.sublabel,
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            vertical: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 14,
            ),
            horizontal: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 8,
            ),
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
            ),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey.shade200,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 10,
                      ),
                      offset: Offset(
                        0,
                        AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 4,
                        ),
                      ),
                    ),
                  ]
                : [],
          ),
          child: Column(
            children: [
              Text(
                emoji,
                style: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 28,
                  ),
                ),
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 6,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 13,
                  ),
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 3,
                ),
              ),
              Text(
                sublabel,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 9,
                  ),
                  color: isSelected ? Colors.white70 : Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Result Card ───────────────────────────────────────────────────────────────
class _ResultCard extends StatelessWidget {
  final CvScanController controller;
  const _ResultCard({required this.controller});

  Color _severityColor(String label) {
    final lower = label.toLowerCase();
    if (lower.contains('healthy')) return const Color(0xFF2E7D32);
    if (lower.contains('mild') || lower.contains('allergy')) {
      return const Color(0xFFED6C02);
    }
    return const Color(0xFFBA1A1A);
  }

  @override
  Widget build(BuildContext context) {
    final label = controller.resultLabel.value;
    final confidence = controller.resultConfidence.value;
    final color = _severityColor(label);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
        ),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.12),
            blurRadius: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 16,
            ),
            offset: Offset(
              0,
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 6),
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.biotech,
                  color: color,
                  size: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                width: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 12,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Diagnosis Result',
                      style: TextStyle(
                        fontSize: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 12,
                        ),
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 17,
                        ),
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 10,
                  ),
                  vertical: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 5,
                  ),
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
                  ),
                ),
                child: Text(
                  '${(confidence * 100).toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
          ),

          // Confidence bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Confidence',
                style: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 12,
                  ),
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 6,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4),
                ),
                child: LinearProgressIndicator(
                  value: confidence,
                  minHeight: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 8,
                  ),
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ],
          ),

          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
          ),

          // Ask فيتو button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: controller.askFeto,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 12,
                  ),
                ),
              ),
              icon: Text(
                '🐾',
                style: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 18,
                  ),
                ),
              ),
              label: const Text(
                'Ask فيتو about this',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Source Option ─────────────────────────────────────────────────────────────
class _SourceOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SourceOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 28),
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 6,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
