import 'custom_doctor_card.dart';
import 'package:flutter/material.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class MobileBookAppointment extends StatelessWidget {
  const MobileBookAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      padding: EdgeInsets.symmetric(
        horizontal: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
        vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) => const CustomDoctorCard(),
    );
  }
}
