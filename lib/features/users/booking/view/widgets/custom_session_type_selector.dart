import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class CustomSessionTypeSelector extends StatelessWidget {
  const CustomSessionTypeSelector({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  final String selectedType;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Session Type",
          style: TextStyle(
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 16,
            ),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
        ),
        Row(
          children: [
            Expanded(
              child: _SessionTypeCard(
                icon: Icons.videocam_outlined,
                title: "Online Session",
                subtitle: "Video or consultation",
                isSelected: selectedType == "online",
                onTap: () => onChanged("online"),
              ),
            ),
            SizedBox(
              width: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
            ),
            Expanded(
              child: _SessionTypeCard(
                icon: Icons.person_outline,
                title: "In-Person Session",
                subtitle: "Visit the clinic",
                isSelected: selectedType == "in-person",
                onTap: () => onChanged("in-person"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SessionTypeCard extends StatelessWidget {
  const _SessionTypeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 12,
          ),
          vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
          ),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected
              ? AppColors.primaryColor.withValues(alpha: 0.05)
              : Colors.white,
        ),
        child: Row(
          children: [
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(
                  right: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 6,
                  ),
                ),
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.primaryColor,
                  size: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
              ),
            Icon(
              icon,
              color: isSelected ? AppColors.primaryColor : Colors.grey.shade600,
              size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
            ),
            SizedBox(
              width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 6),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 11,
                      ),
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 2,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 9,
                      ),
                      color: Colors.grey.shade500,
                    ),
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
