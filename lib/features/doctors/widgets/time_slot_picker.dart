import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/classes/adaptive_layout.dart';
import '../../../core/theme/app_colors.dart';
import '../doctor_portal_controller.dart';

class TimeSlotPicker extends StatefulWidget {
  const TimeSlotPicker({super.key});

  @override
  State<TimeSlotPicker> createState() => _TimeSlotPickerState();
}

class _TimeSlotPickerState extends State<TimeSlotPicker> {
  final controller = Get.find<DoctorPortalController>();

  String selectedDay = 'Monday';
  TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 17, minute: 0);

  final List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (picked != null) {
      setState(() {
        startTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime,
    );
    if (picked != null) {
      setState(() {
        endTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // List of Availabilities
        Obx(() {
          if (controller.availabilities.isEmpty) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Center(
                child: Text(
                  "No time slots added yet. 📅",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.availabilities.length,
            separatorBuilder: (context, index) => SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 8,
              ),
            ),
            itemBuilder: (context, index) {
              final slot = controller.availabilities[index];
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 12,
                  ),
                  vertical: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 10,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.teal.shade100),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: const Color(0xFF009689),
                          size: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 8,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              slot['day'] ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 13,
                                ),
                                color: Colors.teal.shade900,
                              ),
                            ),
                            Text(
                              "${slot['start_time']} - ${slot['end_time']}",
                              style: TextStyle(
                                color: Colors.teal.shade700,
                                fontSize: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                      ),
                      onPressed: () => controller.removeAvailability(index),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              );
            },
          );
        }),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        ),

        // Add New Slot Section Header
        Text(
          "Add Time Slot",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 13,
            ),
          ),
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
        ),

        // Select Day Dropdown
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 12,
            ),
          ),
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedDay,
              isExpanded: true,
              style: TextStyle(
                color: Colors.black87,
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 13,
                ),
              ),
              items: days.map((String day) {
                return DropdownMenuItem<String>(value: day, child: Text(day));
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedDay = value;
                  });
                }
              },
            ),
          ),
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
        ),

        // Pick Times Row
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _selectStartTime(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 10,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Start Time",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 10,
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
                        startTime.format(context),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
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
              child: InkWell(
                onTap: () => _selectEndTime(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 10,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "End Time",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 10,
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
                        endTime.format(context),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        ),

        // Add Button
        InkWell(
          onTap: () {
            final startStr = _formatTimeOfDay(startTime);
            final endStr = _formatTimeOfDay(endTime);
            controller.addAvailability(selectedDay, startStr, endStr);
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF009689),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "+ Add Time Slot",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
