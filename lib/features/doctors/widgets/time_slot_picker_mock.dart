import 'package:flutter/material.dart';

import '../../../core/classes/adaptive_layout.dart';
import 'mock_drop_down.dart';

class TimeSlotPickerMock extends StatelessWidget {
  const TimeSlotPickerMock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: MockDropdown(label: "Available from day", value: "Monday"),
            ),
            SizedBox(
              width: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
            ),
            const Expanded(
              child: MockDropdown(label: "Until", value: "Friday"),
            ),
          ],
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF009689),
            borderRadius: BorderRadius.circular(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
            ),
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
      ],
    );
  }
}

