import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class CustomDateTimeSelector extends StatelessWidget {
  const CustomDateTimeSelector({
    super.key,
    required this.dateTimeSlots,
    required this.selectedSlot,
    required this.onSlotSelected,
  });

  /// List of maps: { "date": "Tuesday, January 22, 2026", "times": ["11:00 AM", "2:00 PM"] }
  final List<Map<String, dynamic>> dateTimeSlots;

  /// Currently selected slot as "date|time" string, e.g. "Tuesday, January 22, 2026|11:00 AM"
  final String? selectedSlot;

  /// Callback when a time slot is tapped with "date|time" key
  final ValueChanged<String> onSlotSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
              color: AppColors.primaryColor,
            ),
            SizedBox(
              width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 6),
            ),
            Text(
              "Select Date & Time",
              style: TextStyle(
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        ),
        ...dateTimeSlots.map(
          (dateGroup) => _buildDateGroup(context, dateGroup),
        ),
      ],
    );
  }

  Widget _buildDateGroup(BuildContext context, Map<String, dynamic> dateGroup) {
    final String date = dateGroup["date"] as String;
    final List<String> times = List<String>.from(dateGroup["times"] as List);

    return Padding(
      padding: EdgeInsets.only(
        bottom: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: TextStyle(
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 13,
              ),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
          ),
          Wrap(
            spacing: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 10,
            ),
            runSpacing: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 8,
            ),
            children: times.map((time) {
              final String slotKey = "$date|$time";
              final bool isSelected = selectedSlot == slotKey;

              return GestureDetector(
                onTap: () => onSlotSelected(slotKey),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 14,
                    ),
                    vertical: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 8,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryColor
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(
                      AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 10,
                      ),
                    ),
                    border: isSelected
                        ? null
                        : Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 12,
                      ),
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
