import 'package:flutter/material.dart';

import '../../../../../core/classes/adaptive_layout.dart';

class CustomPaymentMethodOption extends StatelessWidget {
  const CustomPaymentMethodOption({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    bool isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: EdgeInsets.all(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
          ),
          border: Border.all(
            color: isSelected ? const Color(0xFF009689) : Colors.grey.shade300,
            width: isSelected
                ? AdaptiveLayout.getResponsiveFontSize(context, fontSize: 2)
                : AdaptiveLayout.getResponsiveFontSize(context, fontSize: 1),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF009689) : Colors.grey,
            ),
            SizedBox(
              width: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFF009689)),
          ],
        ),
      ),
    );
  }
}
